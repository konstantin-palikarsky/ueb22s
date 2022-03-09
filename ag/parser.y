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

%%
Start   : Program
        ;

Program :
        | Program Def ';'
        ; 

Def     : ID '(' Pars ')' END
        | ID '(' Pars ')' Stats END                 /* Funktion */
        | ID '{' Pars '}' '(' Pars ')' END
        | ID '{' Pars '}' '(' Pars ')' Stats END    /* zweistufige Funktion */
        ;

Pars    : ID                                        /* Parameterdefinition */
        | Parscsv ID
        ;

Parscsv : ID ','
        | Parscsv ID ','
        ;

Stats   : Stat ';'
        | Labeldefs Stat ';'
        | Stats Stat ';'
        | Stats Labeldefs Stat ';'
        ;       

Labeldefs   : Labeldef
            | Labeldefs Labeldef
            ;


Labeldef    : ID ':'            /* Labeldefinition */
            ;

Stat    : RETURN Expr
        | GOTO ID
        | IF Expr GOTO ID
        | VAR ID '=' Expr       /* Variablendefinition */
        | Lexpr '=' Expr        /* Zuweisung */
        | Term
        ;

Lexpr   : ID                    /* schreibender Variablenzugriff */
        | Term '[' Expr ']'     /* schreibender Arrayzugriff */
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
        | ID                        /* lesender Variablenzugriff */
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
