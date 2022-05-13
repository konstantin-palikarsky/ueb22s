%{
#include <stdlib.h>
#include <string.h>

#include "symtab.h"

void yyerror(char const*);
extern int yylex();
%}

%token END RETURN GOTO IF VAR NOT AND ID NUM
%token ';' '(' ')' '{' '}' ',' ':' '=' '[' ']' '+' '*' '>' '-' '@'

%start Start

@autoinh ids

@attributes { char *name; } ID
@attributes { list_t *pars; } Pars Parscsv
@attributes { list_t *in; list_t* out; } Stat Stats
@attributes { list_t *labels; } Labeldef Labeldefs
@attributes { list_t *ids; } Expr Exprs Exprcsv Lexpr Term Termaddsv Termmulsv Termandsv NotOrMinusChain

@traversal @postorder visible duplicate

%%
Start   : Program
        ;

Program :
        | Program Def ';'
        ; 

Def     : ID '(' Pars ')' END 
        | ID '(' Pars ')' Stats END             @{@i @Stats.in@ = @Pars.pars@; @}
        | ID '{' Pars '}' '(' Pars ')' END              
        | ID '{' Pars '}' '(' Pars ')' Stats END @{@i @Stats.in@ = merge_lists(@Pars.0.pars@, @Pars.1.pars@); @} 
        ;

Pars    : ID                                    @{@i @Pars.pars@ = add_node(empty_list(), @ID.name@, VARIABLE); @}                                /* Parameterdefinition */
        | Parscsv ID                            @{@i @Pars.pars@ = add_node(@Parscsv.pars@, @ID.name@, VARIABLE); @}
        ;

Parscsv : ID ','                                @{@i @Parscsv.pars@ = add_node(empty_list(), @ID.name@, VARIABLE); @}    
        | Parscsv ID ','                        @{@i @Parscsv.0.pars@ = add_node(@Parscsv.1.pars@, @ID.name@, VARIABLE); @}
        ;
        

Stats   : Stat ';'                              @{ 
                                                  @i @Stat.in@ = @Stats.in@;

                                                  @i @Stats.out@ = @Stat.out@;
                                                @}                                      
        | Labeldefs Stat ';'                    @{
                                                  @i @Stat.in@ = merge_lists(@Stats.in@, @Labeldefs.labels@);
                                                  @i @Stats.out@ = merge_lists(@Stat.out@, @Labeldefs.labels@);
                                                @} 
        | Stats Stat ';'                        @{
                                                  @i @Stats.1.in@ =  merge_lists(@Stats.0.in@, @Stat.out@);
                                                  @i @Stat.in@ = merge_lists(@Stats.0.in@, @Stats.1.out@);

                                                  @i @Stats.0.out@ = merge_lists(@Stat.out@, @Stats.1.out@);
                                                @} 
        | Stats Labeldefs Stat ';'              @{
                                                  @i @Stats.1.in@ =  merge_three_lists(@Stats.0.in@, @Stat.out@, @Labeldefs.labels@);
                                                  @i @Stat.in@ = merge_three_lists(@Stats.0.in@, @Stats.1.out@, @Labeldefs.labels@);

                                                  @i @Stats.0.out@ = merge_three_lists(@Stat.out@, @Stats.1.out@, @Labeldefs.labels@);
                                                @}                          
        ;       

Labeldefs   : Labeldef                          @{@i @Labeldefs.labels@ = @Labeldef.labels@; @}
            | Labeldefs Labeldef                @{@i @Labeldefs.0.labels@ = merge_lists(@Labeldefs.1.labels@, @Labeldef.labels@); @}
            ;


Labeldef    : ID ':'                            @{@i @Labeldef.labels@ = add_node(empty_list(), @ID.name@, LABEL); @}
            ;

Stat    : RETURN Expr                           @{
                                                  @i @Expr.ids@ = @Stat.in@;
                                                  @i @Stat.out@ = empty_list();
                                                @}
        | GOTO ID                               @{
                                                  @visible visibility_check(@Stat.in@, @ID.name@, LABEL);
                                                  @i @Stat.out@ = empty_list();
                                                @}               
        | IF Expr GOTO ID                       @{
                                                  @i @Expr.ids@ = @Stat.in@;
                                                  @visible visibility_check(@Stat.in@, @ID.name@, LABEL);
                                                  @i @Stat.out@ = empty_list();
                                                @} 
        | VAR ID '=' Expr                       @{
                                                  @i @Expr.ids@ = @Stat.in@;
                                                  @duplicate duplicate_check(@Stat.in@,@ID.name@);
                                                  @i @Stat.out@ = add_node(empty_list(), @ID.name@, VARIABLE);
                                                @}
        | Lexpr '=' Expr                        @{
                                                  @i @Expr.ids@ = @Stat.in@;
                                                  @i @Lexpr.ids@ = @Stat.in@;
                                                  @i @Stat.out@ = empty_list();
                                                @}
        | Term                                  @{
                                                  @i @Term.ids@ = @Stat.in@;
                                                  @i @Stat.out@ = empty_list();
                                                @}
        ;

Lexpr   : ID                    @{@visible visibility_check(@Lexpr.ids@, @ID.name@, VARIABLE); @} /* schreibender Variablenzugriff */
        | Term '[' Expr ']'     /* schreibender Arrayzugriff, handled in expr and term respectively */
        ;

Expr    : Term
        | NotOrMinusChain Term
        | Term Termaddsv
        | Term Termmulsv
        | Term Termandsv
        | Term '>' Term
        | Term '='  Term
        ;

NotOrMinusChain : NOT
                | '-'
                | NotOrMinusChain NOT
                | NotOrMinusChain '-'
                ;

Termaddsv   : '+' Term
            | Termaddsv '+' Term
            ;

Termmulsv   : '*' Term
            | Termmulsv '*' Term
            ;

Termandsv   : AND Term
            | Termandsv AND Term
            ;


Term    : '(' Expr ')'
        | NUM
        | Term '[' Expr ']'         /* lesender Arrayzugriff */
        | ID                        @{@visible visibility_check(@Term.ids@, @ID.name@, VARIABLE); @}     /* lesender Variablenzugriff */
        | ID '(' Exprs ')'          /* Funktionsaufruf */
        | ID '{' Exprs '}'          /* Stufe 1 */
        | Term '@' '(' Exprs ')'    /* Stufe 2 */
        ;

Exprs   : Expr
        | Exprcsv Expr

Exprcsv : Expr ','
        | Exprcsv Expr ','
        ;

%%

int main(void) {
        yyparse();
        return 0;
}
