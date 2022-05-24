%{
#include "symtab.h"
#include "tree.h"
#include "asm_gen.h"

extern void burm_reduce(NODEPTR_TYPE, int);
extern void burm_label(NODEPTR_TYPE);

void yyerror(char const*);
extern int yylex();
%}

%token END RETURN GOTO IF VAR NOT AND ID NUM
%token ';' '(' ')' '{' '}' ',' ':' '=' '[' ']' '+' '*' '>' '-' '@'

%start Start

@autosyn tree
@autoinh ids

@attributes { long val; } NUM 
@attributes { char *name; } ID
@attributes { list_t *pars; } Pars Parscsv
@attributes { list_t *in; list_t* out; tree_t* tree; } Stat 
@attributes { list_t *in; list_t* out; }  Stats
@attributes { list_t *labels; } Labeldef Labeldefs
@attributes { list_t *ids; tree_t *tree; } Expr Exprs Exprcsv Lexpr Term Termaddsv Termmulsv Termandsv NotOrMinusChain

@traversal @postorder visible duplicate
@traversal @preorder reg
@traversal @postorder generate

%%
Start   : Program
        ;

Program :
        | Program Def ';'
        ; 

Def     : ID '(' Pars ')' Stats END             @{@i
                                                @Stats.in@ = @Pars.pars@; 
                                                @generate @revorder(1) export_function_label(@ID.name@);
                                                @}

        | ID '{' Pars '}' '(' Pars ')' Stats END 
                                                @{@i 
                                                @Stats.in@ = merge_lists(@Pars.1.pars@, @Pars.0.pars@); 
                                                @} 
        ;

Pars    : ID                            @{@i @Pars.pars@ = param_node(@ID.name@); @}                                /* Parameterdefinition */
        | Parscsv ID                    @{@i @Pars.pars@ = merge_lists(@Parscsv.pars@, param_node(@ID.name@)); @}
        ;

Parscsv : ID ','                        @{@i @Parscsv.pars@ = param_node(@ID.name@); @}    
        | Parscsv ID ','                @{@i @Parscsv.0.pars@ = merge_lists(@Parscsv.1.pars@, param_node(@ID.name@)); @}
        ;
        

Stats   :                               @{@i @Stats.out@ = empty_list();  @}

        | Stats Labeldefs Stat ';'      @{
                                        @i @Stats.1.in@ =  merge_three_lists(@Stats.0.in@, @Stat.out@, @Labeldefs.labels@);
                                        @i @Stat.in@ = merge_three_lists(@Stats.0.in@, @Stats.1.out@, @Labeldefs.labels@);

                                        @i @Stats.0.out@ = merge_three_lists(@Stat.out@, @Stats.1.out@, @Labeldefs.labels@);
                                                 
                                        @generate burm_label(@Stat.tree@); burm_reduce(@Stat.tree@, 1);
                                        @}                          
        ;       

Labeldefs   :                           @{@i @Labeldefs.labels@ = empty_list(); @}
            | Labeldefs Labeldef        @{@i @Labeldefs.0.labels@ = merge_lists(@Labeldefs.1.labels@, @Labeldef.labels@); @}
            ;


Labeldef    : ID ':'                    @{@i @Labeldef.labels@ = add_node(empty_list(), @ID.name@, LABEL); @}
            ;

Stat    : RETURN Expr                   @{
                                        @i @Expr.ids@ = @Stat.in@;
                                        @i @Stat.out@ = empty_list();
                                        @i @Stat.tree@ = node(OP_RETURN, @Expr.tree@, NULL);
                                        @reg @Stat.tree@->reg = next_free_register(NULL); @Expr.tree@->reg = @Stat.tree@->reg;

                                        @}
        | GOTO ID                       @{
                                        @visible visibility_check(@Stat.in@, @ID.name@, LABEL);
                                        @i @Stat.out@ = empty_list();
                                        @i @Stat.tree@ = NULL;
                                        @}               
        | IF Expr GOTO ID               @{
                                        @i @Expr.ids@ = @Stat.in@;
                                        @visible visibility_check(@Stat.in@, @ID.name@, LABEL);
                                        @i @Stat.out@ = empty_list();
                                        @i @Stat.tree@ = NULL;
                                        @} 
        | VAR ID '=' Expr               @{
                                        @i @Expr.ids@ = @Stat.in@;
                                        @duplicate duplicate_check(@Stat.in@,@ID.name@);
                                        @i @Stat.out@ = add_node(empty_list(), @ID.name@, VARIABLE);
                                        @i @Stat.tree@ = NULL;
                                        @}
        | Lexpr '=' Expr                @{
                                        @i @Expr.ids@ = @Stat.in@;
                                        @i @Lexpr.ids@ = @Stat.in@;
                                        @i @Stat.out@ = empty_list();
                                        @i @Stat.tree@ = NULL;
                                        @}
        | Term                          @{
                                        @i @Term.ids@ = @Stat.in@;
                                        @i @Stat.out@ = empty_list();
                                        @i @Stat.tree@ = NULL;
                                        @}
        ;

Lexpr   : ID                            @{
                                        @visible visibility_check(@Lexpr.ids@, @ID.name@, VARIABLE);
                                        @i @Lexpr.tree@ = NULL;
                                        @}
                                        
        | Term '[' Expr ']'             @{@i @Lexpr.tree@ = NULL;@} 
        ;

Expr    : NotOrMinusChain               @{
                                        @reg @NotOrMinusChain.tree@->reg = @Expr.tree@->reg;
                                        @}
        | Term Termaddsv                @{
                                        @i @Expr.tree@ = node(OP_ADD, @Term.tree@, @Termaddsv.tree@);
                                        @reg @Term.tree@->reg = @Expr.tree@->reg; @Termaddsv.tree@->reg = next_free_register(@Expr.tree@->reg);
                                        @}   
        | Term Termmulsv                @{
                                        @i @Expr.tree@ = node(OP_MUL, @Term.tree@, @Termmulsv.tree@);
                                        @reg @Term.tree@->reg = @Expr.tree@->reg; @Termmulsv.tree@->reg = next_free_register(@Expr.tree@->reg);
                                        @}  
        | Term Termandsv                @{
                                        @i @Expr.tree@ = node(OP_AND, @Term.tree@, @Termandsv.tree@);
                                        @reg @Term.tree@->reg = @Expr.tree@->reg; @Termandsv.tree@->reg = next_free_register(@Expr.tree@->reg);
                                        @}  
        | Term '>' Term                 @{
                                        @i @Expr.tree@ = node(OP_GREATER, @Term.0.tree@, @Term.1.tree@);
                                        @reg @Term.0.tree@->reg = @Expr.tree@->reg; @Term.1.tree@->reg = next_free_register(@Expr.tree@->reg);
                                        @}  
        | Term '='  Term                @{
                                        @i @Expr.tree@ = node(OP_EQUAL, @Term.0.tree@, @Term.1.tree@);
                                        @reg @Term.0.tree@->reg = @Expr.tree@->reg; @Term.1.tree@->reg = next_free_register(@Expr.tree@->reg);
                                        @}  
        ;

NotOrMinusChain :  NOT  NotOrMinusChain @{
                                        @i @NotOrMinusChain.0.tree@ = node(OP_NOT, @NotOrMinusChain.1.tree@, NULL);
                                        @reg @NotOrMinusChain.1.tree@->reg = @NotOrMinusChain.0.tree@->reg;
                                        @}  
                |  '-' NotOrMinusChain  @{
                                        @i @NotOrMinusChain.0.tree@ = node(OP_MINUS, @NotOrMinusChain.1.tree@, NULL);
                                        @reg @NotOrMinusChain.1.tree@->reg = @NotOrMinusChain.0.tree@->reg;
                                        @}  
                |  Term                 @{
                                        @reg @Term.tree@->reg = @NotOrMinusChain.tree@->reg;
                                        @}  
                ;

Termaddsv   : '+' Term
            | '+' Term Termaddsv       @{
                                        @i @Termaddsv.0.tree@ = node(OP_ADD, @Term.tree@, @Termaddsv.1.tree@);
                                        @reg @Term.tree@->reg = @Termaddsv.0.tree@->reg; if (@Termaddsv.1.tree@ != NULL){@Termaddsv.1.tree@->reg = next_free_register(@Termaddsv.0.tree@->reg);}
                                        @}      
            ;

Termmulsv   : '*' Term
            | '*' Term Termmulsv        @{
                                        @i @Termmulsv.0.tree@ = node(OP_MUL, @Term.tree@, @Termmulsv.1.tree@);
                                        @reg @Term.tree@->reg = @Termmulsv.0.tree@->reg; if (@Termmulsv.1.tree@ != NULL){@Termmulsv.1.tree@->reg = next_free_register(@Termmulsv.0.tree@->reg);}
                                        @}
            ;

Termandsv   : AND Term
            | AND Term Termandsv        @{
                                        @i @Termandsv.0.tree@ = node(OP_AND, @Term.tree@, @Termandsv.1.tree@);
                                        @reg @Term.tree@->reg = @Termandsv.0.tree@->reg; if (@Termandsv.1.tree@ != NULL){@Termandsv.1.tree@->reg = next_free_register(@Termandsv.0.tree@->reg);}
                                        @}
            ;


Term    : '(' Expr ')'
        | NUM                           @{
                                        @i @Term.tree@ = num_leaf(@NUM.val@);
                                        @}

        | Term '[' Expr ']'             @{
                                        @i @Term.0.tree@ = node(OP_ARRAY_ACCESS, @Term.1.tree@, @Expr.tree@);
                                        @reg @Term.1.tree@->reg = @Term.tree@->reg; @Expr.tree@->reg = next_free_register(@Term.tree@->reg);
                                        @}
        | ID                            
                                        @{
                                        @i @Term.tree@ = id_leaf(@ID.name@, find_param_index(@Term.ids@, @ID.name@));   

                                        @visible visibility_check(@Term.ids@, @ID.name@, VARIABLE); 
                                        @} 


        | ID '(' Exprs ')'              @{@i @Term.tree@ = NULL;@}
        | ID '{' Exprs '}'              @{@i @Term.tree@ = NULL;@} 
        | Term '@' '(' Exprs ')'        @{@i @Term.tree@ = NULL;@} 

Exprs   : Expr                          @{@i @Exprs.tree@ = NULL;@}
        | Exprcsv Expr                  @{@i @Exprs.tree@ = NULL;@}

Exprcsv : Expr ','                      @{@i @Exprcsv.tree@ = NULL;@}
        | Exprcsv Expr ','              @{@i @Exprcsv.tree@ = NULL;@}
        ;

%%

int main(void) {
        yyparse();
        return 0;
}
