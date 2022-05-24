%option noyywrap

%{
#include <stdio.h>
#include <string.h>

#include "oxout.tab.h"
#include "symtab.h"
#include "tree.h"
%}

identifier [A-Za-z_][A-Za-z0-9_]*
dec [0-9]+
hex \$[A-Fa-f0-9]+
whitespace [\n\t ]+
comment "//".*

%%

end	     return END; 
return	 return RETURN; 
goto     return GOTO; 
if	     return IF; 
var	     return VAR; 
not	     return NOT; 
and	     return AND; 

";"    	 return ';'; 
"("    	 return '(';       
")"      return ')';    
"{"    	 return '{'; 
"}"    	 return '}'; 
","	     return ','; 
":"	     return ':'; 
"="	     return '='; 
"["	     return '['; 
"]"	     return ']'; 
"+"	     return '+'; 
"*"	     return '*'; 
">"	     return '>'; 
"-"	     return '-'; 
"@"	     return '@'; 

{identifier}     return ID; @{ @ID.name@ = strdup(yytext); @}
 
{hex}      	     return NUM; @{ @NUM.val@ = strtol(yytext + 1, NULL, 16); @}
{dec}  	         return NUM; @{ @NUM.val@ = strtol(yytext, NULL, 10); @}

{whitespace} ;
{comment}    ;

.           {
              fprintf(stderr, "lexical error in line %d (invald character sequence: %d)\n", yylineno, yytext);
              exit(1);
            }


%%

void yyerror (char const *message)
{

    fprintf(stderr, "Error parsing line: %d char: %s\n%s\n", yylineno,yytext, message);
    exit(2);
}