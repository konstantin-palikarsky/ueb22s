%option noyywrap

%{
#include <stdio.h>
#include <string.h>    
%}

keywords end|return|goto|if|var|not|and
identifier [A-Za-z_][A-Za-z0-9_]*
dec [0-9]+
hex \$[A-Fa-f0-9]+
whitespace [\n\t ]+
comment "//".*

%%

{keywords}   fprintf(stdout,"%s\n", yytext);
";"          fprintf(stdout,"%s\n", yytext);
"("          fprintf(stdout,"%s\n", yytext);
")"          fprintf(stdout,"%s\n", yytext);
"{"          fprintf(stdout,"%s\n", yytext);
"}"          fprintf(stdout,"%s\n", yytext);
","          fprintf(stdout,"%s\n", yytext);
":"          fprintf(stdout,"%s\n", yytext);
"="          fprintf(stdout,"%s\n", yytext);
"["          fprintf(stdout,"%s\n", yytext);
"]"          fprintf(stdout,"%s\n", yytext);
"+"          fprintf(stdout,"%s\n", yytext);
"*"          fprintf(stdout,"%s\n", yytext);
">"          fprintf(stdout,"%s\n", yytext);
"-"          fprintf(stdout,"%s\n", yytext);
"@"          fprintf(stdout,"%s\n", yytext);
{identifier} fprintf(stdout,"id %s\n", yytext);
{hex}        {
             memmove(yytext,yytext+1,strlen(yytext));
             fprintf(stdout, "num %ld\n", strtol(yytext , NULL, 16));
             }
{dec}        fprintf(stdout, "num %ld\n", strtol(yytext, NULL, 10));
{whitespace} ;
{comment}    ;
.            {
              fprintf(stderr, "lexical error in line %d (invald character sequence: %d)\n", yylineno, yytext);
              exit(1);
             }
%%
int main(){
    yylex();

    exit(0);
}