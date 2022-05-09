/* output from Ox version G1.04 */
%option noyywrap

%{
#include <stdio.h>
#include <string.h>

#include "oxout.tab.h"
#include "symtab.h"
%}

identifier [A-Za-z_][A-Za-z0-9_]*
dec [0-9]+
hex \$[A-Fa-f0-9]+
whitespace [\n\t ]+
comment "//".*


%{


struct yyyT1 { char *name; }; 
typedef struct yyyT1 *yyyP1; 


struct yyyT2 { list_t *pars; }; 
typedef struct yyyT2 *yyyP2; 


struct yyyT3 { list_t *in; list_t* out; }; 
typedef struct yyyT3 *yyyP3; 


struct yyyT4 { list_t *labels; }; 
typedef struct yyyT4 *yyyP4; 


struct yyyT5 { list_t *ids; }; 
typedef struct yyyT5 *yyyP5; 
                                                      /*custom*/  
typedef unsigned char yyyWAT; 
typedef unsigned char yyyRCT; 
typedef unsigned short yyyPNT; 
typedef unsigned char yyyWST; 

#include <limits.h>
#define yyyR UCHAR_MAX  

 /* funny type; as wide as the widest of yyyWAT,yyyWST,yyyRCT  */ 
typedef unsigned short yyyFT;

                                                      /*stock*/  




struct yyyGenNode {void *parent;  
                   struct yyyGenNode **cL; /* child list */ 
                   yyyRCT *refCountList; 
                   yyyPNT prodNum;                      
                   yyyWST whichSym; /* which child of parent? */ 
                  }; 

typedef struct yyyGenNode yyyGNT; 



struct yyyTB {int isEmpty; 
              int typeNum; 
              int nAttrbs; 
              char *snBufPtr; 
              yyyWAT *startP,*stopP; 
             };  




extern struct yyyTB yyyTermBuffer; 
extern yyyWAT yyyLRCIL[]; 
extern void yyyGenLeaf(); 


%}
%%

end	     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return END;} 
return	 {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return RETURN;} 
goto      {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return GOTO;} 
if	     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return IF;} 
var	     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return VAR;} 
not	     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return NOT;} 
and	     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return AND;} 

";"    	 {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return ';';} 
"("    	 {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return '(';}       
")"      {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return ')';}    
"{"    	 {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return '{';} 
"}"    	 {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return '}';} 
","	     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return ',';} 
":"	     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return ':';} 
"="	     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return '=';} 
"["	     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return '[';} 
"]"	     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return ']';} 
"+"	     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return '+';} 
"*"	     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return '*';} 
">"	     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return '>';} 
"-"	     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return '-';} 
"@"	     {yyyGenLeaf(0,0,yyyLRCIL+0,yyyLRCIL+0);return '@';} 

{identifier}     {yyyGenLeaf(1,1,yyyLRCIL+0,yyyLRCIL+1); (((yyyP1)(yyyTermBuffer.snBufPtr))->name) = strdup(yytext); return ID;} 
 
{hex}      	     {yyyGenLeaf(0,0,yyyLRCIL+1,yyyLRCIL+1);return NUM;} 
{dec}  	         {yyyGenLeaf(0,0,yyyLRCIL+1,yyyLRCIL+1);return NUM;} 

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