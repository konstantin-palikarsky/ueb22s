/* output from Ox version G1.04 */
%{
%}
%{
#include <stdlib.h>
#include <string.h>

#include "symtab.h"

void yyerror(char const*);
extern int yylex();
%}

%token END RETURN GOTO IF VAR NOT AND ID NUM
%token ';' '(' ')' '{' '}' ',' ':' '=' '[' ']' '+' '*' '>' '-' '@'

%start yyyAugNonterm



 
  
  
  
         

 


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

%{
#include <stdio.h>

int yyyYok = 1;
int yyyInitDone = 0;
char *yyySTsn;
yyyGNT *yyySTN;
int yyyGNSz = sizeof(yyyGNT);
int yyyProdNum,yyyRHSlength,yyyNattrbs,yyyTypeNum; 

extern yyyFT yyyRCIL[];

void yyyExecuteRRsection();
void yyyYoxInit();
void yyyYoxReset();
void yyyDecorate();
void yyyGenIntNode();
void yyyAdjustINRC();
void yyyPrune();
void yyyUnsolvedInstSearchTrav();
void yyyUnsolvedInstSearchTravAux();
void yyyerror();
void yyyShift();



#define yyyRSU(NUM1,NUM2,NUM3,NUM4) \
   yyyProdNum=NUM1;yyyRHSlength=NUM2;yyyNattrbs=NUM3;yyyTypeNum=NUM4;\
   if ((yychar <= 0) && (!yyyTermBuffer.isEmpty)) yyyShift(); 
%}


%%
yyyAugNonterm 
	:	{if (!yyyInitDone) 
		    {yyyYoxInit(); 
		     yyyInitDone = 1;
		    }
		 yyyYoxReset();
		}
		Start
		{
		 yyyDecorate(); yyyExecuteRRsection();
		}
	;
Start   : Program
        {if(yyyYok){
yyyRSU(1,1,0,0);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+0,yyyRCIL+0);/*yyyPrune(1);*/}};

Program :
        {if(yyyYok){
yyyRSU(2,0,0,0);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+0,yyyRCIL+0);}}| Program Def ';'
        {if(yyyYok){
yyyRSU(3,3,0,0);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+0,yyyRCIL+0);/*yyyPrune(3);*/}}; 

Def     : ID '(' Pars ')' END 
        {if(yyyYok){
yyyRSU(4,5,0,0);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+0,yyyRCIL+0);/*yyyPrune(4);*/}}| ID '(' Pars ')' Stats END             {if(yyyYok){
yyyRSU(5,6,0,0);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+0,yyyRCIL+3);/*yyyPrune(5);*/}}
        | ID '{' Pars '}' '(' Pars ')' END              
        {if(yyyYok){
yyyRSU(6,8,0,0);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+3,yyyRCIL+3);/*yyyPrune(6);*/}}| ID '{' Pars '}' '(' Pars ')' Stats END {if(yyyYok){
yyyRSU(7,9,0,0);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+3,yyyRCIL+6);/*yyyPrune(7);*/}} 
        ;

Pars    : ID                                    {if(yyyYok){
yyyRSU(8,1,1,2);
yyyGenIntNode();
 (((yyyP2)yyySTsn)->pars) = add_node(empty_list(), (((yyyP1)(((char *)((yyySTN->cL)[0]))+yyyGNSz))->name), VARIABLE); yyyAdjustINRC(yyyRCIL+6,yyyRCIL+9);/*yyyPrune(8);*/}}                                /* Parameterdefinition */
        | Parscsv ID                            {if(yyyYok){
yyyRSU(9,2,1,2);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+9,yyyRCIL+12);/*yyyPrune(9);*/}}
        ;

Parscsv : ID ','                                {if(yyyYok){
yyyRSU(10,2,1,2);
yyyGenIntNode();
 (((yyyP2)yyySTsn)->pars) = add_node(empty_list(), (((yyyP1)(((char *)((yyySTN->cL)[0]))+yyyGNSz))->name), VARIABLE); yyyAdjustINRC(yyyRCIL+12,yyyRCIL+15);/*yyyPrune(10);*/}}    
        | Parscsv ID ','                        {if(yyyYok){
yyyRSU(11,3,1,2);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+15,yyyRCIL+18);/*yyyPrune(11);*/}}
        ;
        

Stats   : Stat ';'                              {if(yyyYok){
yyyRSU(12,2,2,3);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+18,yyyRCIL+24);}}                                      
        | Labeldefs Stat ';'                    {if(yyyYok){
yyyRSU(13,3,2,3);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+24,yyyRCIL+30);}} 
        | Stats Stat ';'                        {if(yyyYok){
yyyRSU(14,3,2,3);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+30,yyyRCIL+39);}} 
        | Stats Labeldefs Stat ';'              {if(yyyYok){
yyyRSU(15,4,2,3);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+39,yyyRCIL+48);}}                          
        ;       

Labeldefs   : Labeldef                          {if(yyyYok){
yyyRSU(16,1,1,4);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+48,yyyRCIL+51);/*yyyPrune(16);*/}}
            | Labeldefs Labeldef                {if(yyyYok){
yyyRSU(17,2,1,4);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+51,yyyRCIL+54);/*yyyPrune(17);*/}}
            ;


Labeldef    : ID ':'                            {if(yyyYok){
yyyRSU(18,2,1,4);
yyyGenIntNode();
 (((yyyP4)yyySTsn)->labels) = add_node(empty_list(), (((yyyP1)(((char *)((yyySTN->cL)[0]))+yyyGNSz))->name), LABEL); yyyAdjustINRC(yyyRCIL+54,yyyRCIL+57);/*yyyPrune(18);*/}}
            ;

Stat    : RETURN Expr                           {if(yyyYok){
yyyRSU(19,2,2,3);
yyyGenIntNode();
 (((yyyP3)yyySTsn)->out) = empty_list();
                                                yyyAdjustINRC(yyyRCIL+57,yyyRCIL+63);}}
        | GOTO ID                               {if(yyyYok){
yyyRSU(20,2,2,3);
yyyGenIntNode();
 (((yyyP3)yyySTsn)->out) = empty_list();
                                                yyyAdjustINRC(yyyRCIL+63,yyyRCIL+66);/*yyyPrune(20);*/}}               
        | IF Expr GOTO ID                       {if(yyyYok){
yyyRSU(21,4,2,3);
yyyGenIntNode();
 (((yyyP3)yyySTsn)->out) = empty_list();
                                                yyyAdjustINRC(yyyRCIL+66,yyyRCIL+72);}} 
        | VAR ID '=' Expr                       {if(yyyYok){
yyyRSU(22,4,2,3);
yyyGenIntNode();
 (((yyyP3)yyySTsn)->out) = add_node(empty_list(), (((yyyP1)(((char *)((yyySTN->cL)[1]))+yyyGNSz))->name), VARIABLE);
                                                yyyAdjustINRC(yyyRCIL+72,yyyRCIL+78);}}
        | Lexpr '=' Expr                        {if(yyyYok){
yyyRSU(23,3,2,3);
yyyGenIntNode();
 (((yyyP3)yyySTsn)->out) = empty_list();
                                                yyyAdjustINRC(yyyRCIL+78,yyyRCIL+87);}}
        | Term                                  {if(yyyYok){
yyyRSU(24,1,2,3);
yyyGenIntNode();
 (((yyyP3)yyySTsn)->out) = empty_list();
                                                yyyAdjustINRC(yyyRCIL+87,yyyRCIL+93);}}
        ;

Lexpr   : ID                    {if(yyyYok){
yyyRSU(25,1,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+93,yyyRCIL+93);/*yyyPrune(25);*/}} /* schreibender Variablenzugriff */
        | Term '[' Expr ']'     /* schreibender Arrayzugriff, handled in expr and term respectively */
        {if(yyyYok){
yyyRSU(26,4,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+93,yyyRCIL+99);}};

Expr    : Term
        {if(yyyYok){
yyyRSU(27,1,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+99,yyyRCIL+102);}}| NotOrMinusChain Term
        {if(yyyYok){
yyyRSU(28,2,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+102,yyyRCIL+108);}}| Term Termaddsv
        {if(yyyYok){
yyyRSU(29,2,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+108,yyyRCIL+114);}}| Term Termmulsv
        {if(yyyYok){
yyyRSU(30,2,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+114,yyyRCIL+120);}}| Term Termandsv
        {if(yyyYok){
yyyRSU(31,2,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+120,yyyRCIL+126);}}| Term '>' Term
        {if(yyyYok){
yyyRSU(32,3,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+126,yyyRCIL+132);}}| Term '='  Term
        {if(yyyYok){
yyyRSU(33,3,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+132,yyyRCIL+138);}};

NotOrMinusChain : NOT
                {if(yyyYok){
yyyRSU(34,1,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+138,yyyRCIL+138);/*yyyPrune(34);*/}}| '-'
                {if(yyyYok){
yyyRSU(35,1,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+138,yyyRCIL+138);/*yyyPrune(35);*/}}| NotOrMinusChain NOT
                {if(yyyYok){
yyyRSU(36,2,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+138,yyyRCIL+141);}}| NotOrMinusChain '-'
                {if(yyyYok){
yyyRSU(37,2,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+141,yyyRCIL+144);}};

Termaddsv   : '+' Term
            {if(yyyYok){
yyyRSU(38,2,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+144,yyyRCIL+147);}}| Termaddsv '+' Term
            {if(yyyYok){
yyyRSU(39,3,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+147,yyyRCIL+153);}};

Termmulsv   : '*' Term
            {if(yyyYok){
yyyRSU(40,2,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+153,yyyRCIL+156);}}| Termmulsv '*' Term
            {if(yyyYok){
yyyRSU(41,3,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+156,yyyRCIL+162);}};

Termandsv   : AND Term
            {if(yyyYok){
yyyRSU(42,2,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+162,yyyRCIL+165);}}| Termandsv AND Term
            {if(yyyYok){
yyyRSU(43,3,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+165,yyyRCIL+171);}};


Term    : '(' Expr ')'
        {if(yyyYok){
yyyRSU(44,3,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+171,yyyRCIL+174);}}| NUM
        {if(yyyYok){
yyyRSU(45,1,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+174,yyyRCIL+174);/*yyyPrune(45);*/}}| Term '[' Expr ']'         /* lesender Arrayzugriff */
        {if(yyyYok){
yyyRSU(46,4,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+174,yyyRCIL+180);}}| ID                        {if(yyyYok){
yyyRSU(47,1,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+180,yyyRCIL+180);/*yyyPrune(47);*/}}     /* lesender Variablenzugriff */
        | ID '(' Exprs ')'          /* Funktionsaufruf */
        {if(yyyYok){
yyyRSU(48,4,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+180,yyyRCIL+183);}}| ID '{' Exprs '}'          /* Stufe 1 */
        {if(yyyYok){
yyyRSU(49,4,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+183,yyyRCIL+186);}}| Term '@' '(' Exprs ')'    /* Stufe 2 */
        {if(yyyYok){
yyyRSU(50,5,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+186,yyyRCIL+192);}};

Exprs   : Expr
        {if(yyyYok){
yyyRSU(51,1,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+192,yyyRCIL+195);}}| Exprcsv Expr

{if(yyyYok){
yyyRSU(52,2,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+195,yyyRCIL+201);}}Exprcsv : Expr ','
        {if(yyyYok){
yyyRSU(53,2,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+201,yyyRCIL+204);}}| Exprcsv Expr ','
        {if(yyyYok){
yyyRSU(54,3,1,5);
yyyGenIntNode();
yyyAdjustINRC(yyyRCIL+204,yyyRCIL+210);}};


%%

int main(void) {
        yyparse();
        return 0;
}
                                                      /*custom*/  
long yyyMaxNbytesNodeStg = 2000000; 
long yyyMaxNrefCounts =    500000; 
long yyyMaxNchildren =     60000; 
long yyyMaxStackSize =     2000; 
long yyySSALspaceSize =    20000; 
long yyyRSmaxSize =        1000; 
long yyyTravStackMaxSize = 2000; 


struct yyyTB yyyTermBuffer; 

char *yyyNodeAndStackSpace; 

char *yyyNodeSpace;
char *yyyNextNodeSpace; 
char *yyyAfterNodeSpace; 


 
struct yyyGenNode **yyyChildListSpace;  
struct yyyGenNode **yyyNextCLspace; 
struct yyyGenNode **yyyAfterChildListSpace; 



yyyRCT *yyyRefCountListSpace;
yyyRCT *yyyNextRCLspace;  
yyyRCT *yyyAfterRefCountListSpace;   



struct yyySolvedSAlistCell {yyyWAT attrbNum; 
                            long next; 
                           }; 
#define yyyLambdaSSAL 0 
long yyySSALCfreeList = yyyLambdaSSAL; 
long yyyNewSSALC = 1; 
 
struct yyySolvedSAlistCell *yyySSALspace; 


 
struct yyyStackItem {struct yyyGenNode *node; 
                     long solvedSAlist; 
                     struct yyyGenNode *oldestNode; 
                    };  

long yyyNbytesStackStg; 
struct yyyStackItem *yyyStack; 
struct yyyStackItem *yyyAfterStack; 
struct yyyStackItem *yyyStackTop; 



struct yyyRSitem {yyyGNT *node; 
                  yyyWST whichSym; 
                  yyyWAT wa;  
                 };  

struct yyyRSitem *yyyRS;  
struct yyyRSitem *yyyRSTop;  
struct yyyRSitem *yyyAfterRS;  
 





yyyFT yyyRCIL[] = {
4,0,1, 7,0,2, yyyR,0,0, yyyR,0,1, yyyR,0,0, yyyR,0,1, 
yyyR,1,1, 0,0,1, yyyR,1,2, 1,0,2, yyyR,1,2, 0,0,2, 
1,0,2, yyyR,1,3, 0,0,3, 2,0,3, yyyR,0,1, yyyR,0,2, 
yyyR,0,0, yyyR,1,0, 1,0,1, yyyR,1,0, yyyR,1,0, 1,0,1, 
yyyR,1,0, 3,0,1, yyyR,1,0, 0,0,1, 2,0,1, yyyR,1,0, 
0,0,1, 0,0,1, 2,0,1, 0,0,1, 0,0,1, 1,0,1, 
0,0,1, 1,0,1, 0,0,1, 1,0,1, 0,0,1, 1,0,1, 
0,0,1, 2,0,1, 0,0,1, 2,0,1, 0,0,1, 0,0,1, 
1,0,1, 0,0,1, 2,0,1, 1,0,1, 0,0,1, 2,0,1, 
1,0,1, 0,0,1, 2,0,1, 1,0,1, 0,0,1, 2,0,1, 
2,0,1, 2,0,1, 0,0,1, 3,0,1, 0,0,1, 0,0,1, 
1,0,1, 0,0,1, 0,0,1, 1,0,1, 
};

short yyyIIIEL[] = {0,
0,2,3,7,13,20,29,39,41,44,
47,51,54,58,62,67,69,72,75,78,
81,86,91,95,97,99,104,106,109,112,
115,118,122,126,128,130,133,136,139,143,
146,150,153,157,161,163,168,170,175,180,
186,188,191,194,
};

long yyyIIEL[] = {
0,0,0,0,0,0,0,0,0,1,1,2,
2,2,2,3,3,4,4,6,6,6,7,7,
8,8,8,9,9,9,9,10,10,11,11,11,
12,12,14,14,15,16,17,18,19,20,21,21,
22,23,24,24,26,28,28,30,31,33,33,35,
37,39,39,41,43,44,46,46,47,48,49,50,
51,52,53,53,55,55,56,58,58,59,61,61,
62,62,63,65,65,66,66,67,69,70,70,71,
73,74,75,76,77,78,78,79,79,80,81,82,
83,84,85,86,87,88,89,90,91,92,93,94,
95,95,96,97,98,98,99,100,100,101,101,102,
103,103,104,105,105,106,106,107,108,109,109,110,
111,111,112,113,114,114,115,116,116,117,118,119,
119,120,121,121,122,122,123,123,124,125,125,126,
126,127,128,129,130,130,131,131,132,133,133,134,
134,135,136,136,136,137,137,138,139,140,141,142,
143,144,144,145,146,147,
};

long yyyIEL[] = {
0,0,0,0,2,2,2,2,
2,2,2,4,6,6,6,6,
8,8,10,12,12,14,14,16,
18,20,20,20,22,24,24,28,
28,30,34,34,34,38,38,42,
46,46,46,50,56,56,60,60,
62,62,64,66,66,68,70,70,
70,70,70,70,72,72,72,72,
74,74,76,76,80,80,80,80,
82,82,82,82,82,86,86,86,
88,88,92,92,92,96,96,96,
100,100,100,104,104,104,108,108,
108,112,112,112,112,112,114,114,
116,116,118,118,122,122,122,124,
124,128,128,128,130,130,134,134,
134,136,136,136,140,140,140,140,
140,142,142,142,144,144,144,148,
148,148,150,150,154,154,154,156,
156,160,160,160,
};

yyyFT yyyEntL[] = {
5,0,8,0,8,0,0,0,0,0,0,0,0,0,0,0,
0,0,1,0,0,1,2,0,0,1,2,0,0,1,2,0,
1,0,0,1,2,0,0,1,1,0,3,0,1,0,0,1,
3,0,0,1,3,0,1,0,0,1,1,0,0,0,0,0,
0,0,0,0,2,0,2,0,4,0,0,1,1,0,3,0,
1,0,3,0,1,0,1,0,2,0,1,0,2,0,1,0,
2,0,1,0,2,0,1,0,3,0,1,0,3,0,1,0,
1,0,1,0,2,0,3,0,1,0,2,0,3,0,1,0,
2,0,3,0,1,0,2,0,3,0,1,0,3,0,3,0,
4,0,1,0,1,0,2,0,1,0,1,0,2,0,1,0,

};

#define yyyPermitUserAlloc  0 


void yyyfatal(msg)
  char *msg; 
{fprintf(stderr,msg);exit(-1);} 



#define yyyNSof   'n' 
#define yyyRCof   'r' 
#define yyyCLof   'c' 
#define yyySof    's' 
#define yyySSALof 'S' 
#define yyyRSof   'q' 
#define yyyTSof   't' 



void yyyHandleOverflow(which) 
  char which; 
  {char *msg1,*msg2; 
   long  oldSize,newSize; 
   switch(which) 
     {
      case yyyNSof   : 
           msg1 = "node storage overflow: ";
           oldSize = yyyMaxNbytesNodeStg; 
           break; 
      case yyyRCof   : 
           msg1 = "dependee count overflow: ";
           oldSize = yyyMaxNrefCounts; 
           break; 
      case yyyCLof   : 
           msg1 = "child list overflow: ";
           oldSize = yyyMaxNchildren; 
           break; 
      case yyySof    : 
           msg1 = "parse-tree stack overflow: ";
           oldSize = yyyMaxStackSize; 
           break; 
      case yyySSALof : 
           msg1 = "SSAL overflow: ";
           oldSize = yyySSALspaceSize; 
           break; 
      case yyyRSof   : 
           msg1 = "ready set overflow: ";
           oldSize = yyyRSmaxSize; 
           break; 
      case yyyTSof   : 
           msg1 = "traversal stack overflow: ";
           oldSize = yyyTravStackMaxSize; 
           break; 
      default        :;  
     }
   newSize = (3*oldSize)/2; 
   if (newSize < 100) newSize = 100; 
   fprintf(stderr,msg1); 
   fprintf(stderr,"size was %d.\n",oldSize); 
   if (yyyPermitUserAlloc) 
      msg2 = "     Try -Y%c%d option.\n"; 
      else 
      msg2 = "     Have to modify evaluator:  -Y%c%d.\n"; 
   fprintf(stderr,msg2,which,newSize); 
   exit(-1); 
  }



void yyySignalEnts(node,startP,stopP) 
  register yyyGNT *node; 
  register yyyFT *startP,*stopP;  
  {register yyyGNT *dumNode; 

   while (startP < stopP)  
     {
      if (!(*startP)) dumNode = node;  
         else dumNode = (node->cL)[(*startP)-1];   
      if (!(--((dumNode->refCountList)[*(startP+1)]
              ) 
           )
         ) 
         { 
          if (++yyyRSTop == yyyAfterRS) 
             {yyyHandleOverflow(yyyRSof); 
              break; 
             }
          yyyRSTop->node = dumNode; 
          yyyRSTop->whichSym = *startP;  
          yyyRSTop->wa = *(startP+1);  
         }  
      startP += 2;  
     }  
  } 




#define yyyCeiling(num,inc) (((inc) * ((num)/(inc))) + (((num)%(inc))?(inc):0)) 



int yyyAlignSize = 8;
int yyyNdSz[6];

int yyyNdPrSz[6];

typedef int yyyCopyType;

int yyyNdCopySz[6];
long yyyBiggestNodeSize = 0;

void yyyNodeSizeCalc()
  {int i;
   yyyGNSz = yyyCeiling(yyyGNSz,yyyAlignSize); 
   yyyNdSz[0] = 0;
   yyyNdSz[1] = sizeof(struct yyyT1);
   yyyNdSz[2] = sizeof(struct yyyT2);
   yyyNdSz[3] = sizeof(struct yyyT3);
   yyyNdSz[4] = sizeof(struct yyyT4);
   yyyNdSz[5] = sizeof(struct yyyT5);
   for (i=0;i<6;i++) 
       {yyyNdSz[i] = yyyCeiling(yyyNdSz[i],yyyAlignSize); 
        yyyNdPrSz[i] = yyyNdSz[i] + yyyGNSz;
        if (yyyBiggestNodeSize < yyyNdSz[i])
           yyyBiggestNodeSize = yyyNdSz[i];
        yyyNdCopySz[i] = yyyCeiling(yyyNdSz[i],sizeof(yyyCopyType)) / 
                         sizeof(yyyCopyType); 
       }
  }




void yyySolveAndSignal() {
register long yyyiDum,*yyypL;
register int yyyws,yyywa;
register yyyGNT *yyyRSTopN,*yyyRefN; 
register void *yyyRSTopNp; 


yyyRSTopNp = (yyyRSTopN = yyyRSTop->node)->parent;
yyyRefN= (yyyws = (yyyRSTop->whichSym))?((yyyGNT *)yyyRSTopNp):yyyRSTopN;
yyywa = yyyRSTop->wa; 
yyyRSTop--;
switch(yyyRefN->prodNum) {
case 1:  /***yacc rule 1***/
  switch (yyyws) {
  }
break;
case 2:  /***yacc rule 2***/
  switch (yyyws) {
  }
break;
case 3:  /***yacc rule 3***/
  switch (yyyws) {
  }
break;
case 4:  /***yacc rule 4***/
  switch (yyyws) {
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 5:  /***yacc rule 5***/
  switch (yyyws) {
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  case 5:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->in) = (((yyyP2)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->pars);     break;
    }
  break;
  }
break;
case 6:  /***yacc rule 6***/
  switch (yyyws) {
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  case 6:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 7:  /***yacc rule 7***/
  switch (yyyws) {
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    }
  break;
  case 6:  /**/
    switch (yyywa) {
    }
  break;
  case 8:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->in) = merge_lists((((yyyP2)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->pars), (((yyyP2)(((char *)((yyyRefN->cL)[5]))+yyyGNSz))->pars));     break;
    }
  break;
  }
break;
case 8:  /***yacc rule 8***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 9:  /***yacc rule 9***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP2)(((char *)yyyRSTopN)+yyyGNSz))->pars) = add_node((((yyyP2)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->pars), (((yyyP1)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->name), VARIABLE);     break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 10:  /***yacc rule 10***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 11:  /***yacc rule 11***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP2)(((char *)yyyRSTopN)+yyyGNSz))->pars) = add_node((((yyyP2)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->pars), (((yyyP1)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->name), VARIABLE);     break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 12:  /***yacc rule 12***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 1:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->out) = (((yyyP3)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->out);
                                                    break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->in) = (((yyyP3)(((char *)yyyRefN)+yyyGNSz))->in);

                                                      break;
    }
  break;
  }
break;
case 13:  /***yacc rule 13***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 1:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->out) = merge_lists((((yyyP3)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->out), (((yyyP4)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->labels));
                                                    break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->in) = merge_lists((((yyyP3)(((char *)yyyRefN)+yyyGNSz))->in), (((yyyP4)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->labels));
                                                      break;
    }
  break;
  }
break;
case 14:  /***yacc rule 14***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 1:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->out) = merge_lists((((yyyP3)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->out), (((yyyP3)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->out));
                                                    break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->in) =  merge_lists((((yyyP3)(((char *)yyyRefN)+yyyGNSz))->in), (((yyyP3)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->out));
                                                      break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->in) = merge_lists((((yyyP3)(((char *)yyyRefN)+yyyGNSz))->in), (((yyyP3)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->out));

                                                      break;
    }
  break;
  }
break;
case 15:  /***yacc rule 15***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 1:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->out) = merge_three_lists((((yyyP3)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->out), (((yyyP3)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->out), (((yyyP4)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->labels));
                                                    break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->in) =  merge_three_lists((((yyyP3)(((char *)yyyRefN)+yyyGNSz))->in), (((yyyP3)(((char *)((yyyRefN->cL)[2]))+yyyGNSz))->out), (((yyyP4)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->labels));
                                                      break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP3)(((char *)yyyRSTopN)+yyyGNSz))->in) = merge_three_lists((((yyyP3)(((char *)yyyRefN)+yyyGNSz))->in), (((yyyP3)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->out), (((yyyP4)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->labels));

                                                      break;
    }
  break;
  }
break;
case 16:  /***yacc rule 16***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP4)(((char *)yyyRSTopN)+yyyGNSz))->labels) = (((yyyP4)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->labels);     break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 17:  /***yacc rule 17***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP4)(((char *)yyyRSTopN)+yyyGNSz))->labels) = merge_lists((((yyyP4)(((char *)((yyyRefN->cL)[0]))+yyyGNSz))->labels), (((yyyP4)(((char *)((yyyRefN->cL)[1]))+yyyGNSz))->labels));     break;
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 18:  /***yacc rule 18***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 19:  /***yacc rule 19***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP3)(((char *)yyyRefN)+yyyGNSz))->in);
                                                      break;
    }
  break;
  }
break;
case 20:  /***yacc rule 20***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 21:  /***yacc rule 21***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP3)(((char *)yyyRefN)+yyyGNSz))->in);
                                                      break;
    }
  break;
  case 4:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 22:  /***yacc rule 22***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    }
  break;
  case 4:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP3)(((char *)yyyRefN)+yyyGNSz))->in);
                                                      break;
    }
  break;
  }
break;
case 23:  /***yacc rule 23***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP3)(((char *)yyyRefN)+yyyGNSz))->in);
                                                      break;
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP3)(((char *)yyyRefN)+yyyGNSz))->in);
                                                      break;
    }
  break;
  }
break;
case 24:  /***yacc rule 24***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
 (((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP3)(((char *)yyyRefN)+yyyGNSz))->in);
                                                      break;
    }
  break;
  }
break;
case 25:  /***yacc rule 25***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 26:  /***yacc rule 26***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 27:  /***yacc rule 27***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 28:  /***yacc rule 28***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 29:  /***yacc rule 29***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 30:  /***yacc rule 30***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 31:  /***yacc rule 31***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 32:  /***yacc rule 32***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 33:  /***yacc rule 33***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 34:  /***yacc rule 34***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 35:  /***yacc rule 35***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 36:  /***yacc rule 36***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 37:  /***yacc rule 37***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 38:  /***yacc rule 38***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 39:  /***yacc rule 39***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 40:  /***yacc rule 40***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 41:  /***yacc rule 41***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 42:  /***yacc rule 42***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 43:  /***yacc rule 43***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 44:  /***yacc rule 44***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 45:  /***yacc rule 45***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 46:  /***yacc rule 46***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 47:  /***yacc rule 47***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  }
break;
case 48:  /***yacc rule 48***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 49:  /***yacc rule 49***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    }
  break;
  case 3:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 50:  /***yacc rule 50***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  case 4:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 51:  /***yacc rule 51***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 52:  /***yacc rule 52***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 53:  /***yacc rule 53***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
case 54:  /***yacc rule 54***/
  switch (yyyws) {
  case 0:  /**/
    switch (yyywa) {
    }
  break;
  case 1:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  case 2:  /**/
    switch (yyywa) {
    case 0:
(((yyyP5)(((char *)yyyRSTopN)+yyyGNSz))->ids) = (((yyyP5)(((char *)yyyRefN)+yyyGNSz))->ids);
    break;
    }
  break;
  }
break;
} /* switch */ 

if (yyyws)  /* the just-solved instance was inherited. */ 
   {if (yyyRSTopN->prodNum) 
       {yyyiDum = yyyIIEL[yyyIIIEL[yyyRSTopN->prodNum]] + yyywa;
        yyySignalEnts(yyyRSTopN,yyyEntL + yyyIEL[yyyiDum],
                                yyyEntL + yyyIEL[yyyiDum+1]
                     );
       }
   } 
   else     /* the just-solved instance was synthesized. */ 
   {if ((char *)yyyRSTopNp >= yyyNodeSpace) /* node has a parent. */ 
       {yyyiDum = yyyIIEL[yyyIIIEL[((yyyGNT *)yyyRSTopNp)->prodNum] + 
                          yyyRSTopN->whichSym 
                         ] + 
                  yyywa;
        yyySignalEnts((yyyGNT *)yyyRSTopNp,
                      yyyEntL + yyyIEL[yyyiDum],
                      yyyEntL + yyyIEL[yyyiDum+1] 
                     );
       } 
       else   /* node is still on the stack--it has no parent yet. */ 
       {yyypL = &(((struct yyyStackItem *)yyyRSTopNp)->solvedSAlist); 
        if (yyySSALCfreeList == yyyLambdaSSAL) 
           {yyySSALspace[yyyNewSSALC].next = *yyypL; 
            if ((*yyypL = yyyNewSSALC++) == yyySSALspaceSize) 
               yyyHandleOverflow(yyySSALof); 
           }  
           else
           {yyyiDum = yyySSALCfreeList; 
            yyySSALCfreeList = yyySSALspace[yyySSALCfreeList].next; 
            yyySSALspace[yyyiDum].next = *yyypL; 
            *yyypL = yyyiDum;  
           } 
        yyySSALspace[*yyypL].attrbNum = yyywa; 
       } 
   }

} /* yyySolveAndSignal */ 






#define condStg unsigned int conds;
#define yyyClearConds {yyyTST->conds = 0;}
#define yyySetCond(n) {yyyTST->conds += (1<<(n));}
#define yyyCond(n) ((yyyTST->conds & (1<<(n)))?1:0)



struct yyyTravStackItem {yyyGNT *node; 
                         char isReady;
                         condStg
                        };



void yyyDoTraversals()
{struct yyyTravStackItem *yyyTravStack,*yyyTST,*yyyAfterTravStack;
 register yyyGNT *yyyTSTn,**yyyCLptr1,**yyyCLptr2; 
 register int yyyi,yyyRL,yyyPass;

 if (!yyyYok) return;
 if ((yyyTravStack = 
                 ((struct yyyTravStackItem *) 
                  malloc((yyyTravStackMaxSize * 
                                  sizeof(struct yyyTravStackItem)
                                 )
                        )
                 )
     )
     == 
     (struct yyyTravStackItem *)NULL
    ) 
    {fprintf(stderr,"malloc error in traversal stack allocation\n"); 
     exit(-1); 
    } 

yyyAfterTravStack = yyyTravStack + yyyTravStackMaxSize; 
yyyTravStack++; 


for (yyyi=0; yyyi<2; yyyi++) {
yyyTST = yyyTravStack; 
yyyTST->node = yyyStack->node;
yyyTST->isReady = 0;
yyyClearConds

while(yyyTST >= yyyTravStack)
  {yyyTSTn = yyyTST->node;
   if (yyyTST->isReady)  
      {yyyPass = 1;
       goto yyyTravSwitch;
yyyTpop:
       yyyTST--;
      } 
      else 
      {yyyPass = 0;
       goto yyyTravSwitch;
yyyTpush:
       yyyTST->isReady = 1;  
       if (yyyTSTn->prodNum)
          if (yyyRL)
             {yyyCLptr2 = yyyTSTn->cL; 
              while 
                ((yyyCLptr2 != yyyNextCLspace)
                 &&
                 ((*yyyCLptr2)->parent == yyyTSTn) 
                )  
                {if (++yyyTST == yyyAfterTravStack)
                    yyyHandleOverflow(yyyTSof);
                    else
                    {yyyTST->node = *yyyCLptr2; 
                     yyyTST->isReady = 0; 
                     yyyClearConds
                    }
                 yyyCLptr2++; 
                } 
             } /* right to left */
             else  /* left to right */
             {yyyCLptr1 = yyyCLptr2 = yyyTSTn->cL; 
              while 
                ((yyyCLptr2 != yyyNextCLspace)
                 &&
                 ((*yyyCLptr2)->parent == yyyTSTn) 
                )  
                yyyCLptr2++; 
              while (yyyCLptr2-- > yyyCLptr1)
                if (++yyyTST == yyyAfterTravStack)
                   yyyHandleOverflow(yyyTSof);
                   else
                   {yyyTST->node = *yyyCLptr2; 
                    yyyTST->isReady = 0; 
                    yyyClearConds
                   }
             } /* left to right */
      } /* else */
   continue;
yyyTravSwitch:
				switch(yyyTSTn->prodNum)	{
case 1:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 2:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 3:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 4:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 5:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 6:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 7:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 8:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 9:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 10:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 11:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 12:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 13:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 14:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 15:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 16:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 17:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 18:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 19:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 20:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

if (yyyCond(0) != yyyPass) { visibility_check((((yyyP3)(((char *)yyyTSTn)+yyyGNSz))->in), (((yyyP1)(((char *)((yyyTSTn->cL)[1]))+yyyGNSz))->name), LABEL);
                                                  }
				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 21:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

if (yyyCond(0) != yyyPass) { visibility_check((((yyyP3)(((char *)yyyTSTn)+yyyGNSz))->in), (((yyyP1)(((char *)((yyyTSTn->cL)[3]))+yyyGNSz))->name), LABEL);
                                                  }
				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 22:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

if (yyyCond(0) != yyyPass) { duplicate_check((((yyyP3)(((char *)yyyTSTn)+yyyGNSz))->in),(((yyyP1)(((char *)((yyyTSTn->cL)[1]))+yyyGNSz))->name));
                                                  }
				break;
					}
		break;
			}

break;
case 23:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 24:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 25:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

if (yyyCond(0) != yyyPass) { visibility_check((((yyyP5)(((char *)yyyTSTn)+yyyGNSz))->ids), (((yyyP1)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->name), VARIABLE); }
				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 26:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 27:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 28:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 29:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 30:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 31:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 32:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 33:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 34:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 35:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 36:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 37:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 38:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 39:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 40:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 41:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 42:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 43:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 44:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 45:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 46:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 47:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

if (yyyCond(0) != yyyPass) { visibility_check((((yyyP5)(((char *)yyyTSTn)+yyyGNSz))->ids), (((yyyP1)(((char *)((yyyTSTn->cL)[0]))+yyyGNSz))->name), VARIABLE); }
				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 48:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 49:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 50:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 51:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 52:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 53:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
case 54:
	switch(yyyi)	{ 
		case 0:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
		case 1:
			switch(yyyPass)	{
				case 0:
yyyRL = 0;
				case 1:

				break;
					}
		break;
			}

break;
								} /* switch */ 
   if (yyyPass) goto yyyTpop; else goto yyyTpush; 
  } /* while */ 
 } /* for */ 
} /* yyyDoTraversals */ 

void yyyExecuteRRsection()  {
   int yyyi; 
   long yyynRefCounts; 
   long cycleSum = 0;
   long nNZrc = 0;

   if (!yyyYok) return; 
   yyynRefCounts = yyyNextRCLspace - yyyRefCountListSpace; 
   for (yyyi=0;yyyi<yyynRefCounts;yyyi++) 
     if (yyyRefCountListSpace[yyyi])
        {cycleSum += yyyRefCountListSpace[yyyi]; nNZrc++;} 
   if (nNZrc) 
      {
       fprintf(stderr,"\n\n\n**********\n");
       fprintf(stderr,
               "cycle detected in completed parse tree");
       fprintf(stderr,
               " after decoration.\n");
       fprintf(stderr,
         "searching parse tree for %d unsolved instances:\n",
               nNZrc
              );
       yyyUnsolvedInstSearchTravAux(yyyStackTop->node);
      }
   yyyDoTraversals();
} /* yyyExecuteRRsection */ 



yyyWAT yyyLRCIL[1] = {0,
};



void yyyYoxInit()                                  /*stock*/  
  { 

   yyyNodeSizeCalc(); 

   if ((yyyTermBuffer.snBufPtr = 
        (char *) malloc((yyyBiggestNodeSize + sizeof(yyyCopyType)))
       )  
       == 
       ((char *) NULL) 
      )   
      yyyfatal("malloc error in yyyTermBuffer allocation\n");  
  
  
   yyyNbytesStackStg = yyyMaxStackSize*sizeof(struct yyyStackItem); 
   yyyNbytesStackStg = ((yyyNbytesStackStg/yyyAlignSize)+1)*yyyAlignSize;  
   if ((yyyNodeAndStackSpace = 
        (char *) malloc((yyyNbytesStackStg + 
                                 yyyMaxNbytesNodeStg + 
                                 yyyGNSz + 
                                 yyyBiggestNodeSize + 
                                 sizeof(yyyCopyType) 
                                )
                       )
       )  
       == 
       ((char *) NULL) 
      )   
      yyyfatal("malloc error in ox node and stack space allocation\n");
   yyyStack = (struct yyyStackItem *) yyyNodeAndStackSpace; 
   yyyAfterStack = yyyStack + yyyMaxStackSize;  
   yyyNodeSpace = yyyNodeAndStackSpace + yyyNbytesStackStg;
   yyyAfterNodeSpace = yyyNodeSpace + yyyMaxNbytesNodeStg;
 
 
   if ((yyyRS = (struct yyyRSitem *) 
         malloc(((yyyRSmaxSize+1)*sizeof(struct yyyRSitem)))
       )  
       == 
       ((struct yyyRSitem *) NULL) 
      )   
      yyyfatal("malloc error in ox ready set space allocation\n");  
   yyyRS++; 
   yyyAfterRS = yyyRS + yyyRSmaxSize; 

 
   if ((yyyChildListSpace = 
        (yyyGNT **) malloc((yyyMaxNchildren*sizeof(yyyGNT *)))
       )  
       == 
       ((yyyGNT **) NULL) 
      )   
      yyyfatal("malloc error in ox child list space allocation\n");  
   yyyAfterChildListSpace = yyyChildListSpace + yyyMaxNchildren; 

 
   if ((yyyRefCountListSpace = 
        (yyyRCT *) malloc((yyyMaxNrefCounts * sizeof(yyyRCT)))
       )  
       == 
       ((yyyRCT *) NULL) 
      )   
      yyyfatal("malloc error in ox reference count list space allocation\n");  
   yyyAfterRefCountListSpace = yyyRefCountListSpace + yyyMaxNrefCounts;  
  
 
   if ((yyySSALspace = (struct yyySolvedSAlistCell *) 
          malloc(((yyySSALspaceSize+1) * 
                          sizeof(struct yyySolvedSAlistCell))
                         ) 
       ) 
       == 
       ((struct yyySolvedSAlistCell *) NULL) 
      ) 
      yyyfatal("malloc error in stack solved list space allocation\n"); 
  } /* yyyYoxInit */ 



void yyyYoxReset() 
  { 
   yyyTermBuffer.isEmpty = 1; 
   yyyStackTop = yyyStack; 
   while (yyyStackTop != yyyAfterStack) 
     (yyyStackTop++)->solvedSAlist = yyyLambdaSSAL; 
   yyyStackTop = yyyStack - 1; 
   yyyNextNodeSpace = yyyNodeSpace; 
   yyyRSTop = yyyRS - 1; 
   yyyNextCLspace = yyyChildListSpace;
   yyyNextRCLspace = yyyRefCountListSpace; 
  }  



void yyyDecorate() 
  { 
   while (yyyRSTop >= yyyRS) 
      yyySolveAndSignal();  
  } 



void yyyShift() 
  {yyyRCT *rcPdum; 
   register yyyCopyType *CTp1,*CTp2,*CTp3; 
   register yyyWAT *startP,*stopP;  

   if ((++yyyStackTop) == yyyAfterStack) 
      yyyHandleOverflow(yyySof);
   CTp2 = (yyyCopyType *)(yyyStackTop->oldestNode = 
                          yyyStackTop->node = 
                          (yyyGNT *)yyyNextNodeSpace 
                         ); 
   yyyTermBuffer.isEmpty = 1;
   ((yyyGNT *)CTp2)->parent = (void *)yyyStackTop; 
   ((yyyGNT *)CTp2)->cL = yyyNextCLspace;  
   rcPdum = ((yyyGNT *)CTp2)->refCountList = yyyNextRCLspace;  
   ((yyyGNT *)CTp2)->prodNum = 0; 
   if ((yyyNextRCLspace += yyyTermBuffer.nAttrbs) 
       > 
       yyyAfterRefCountListSpace 
      ) 
      yyyHandleOverflow(yyyRCof); 
   startP = yyyTermBuffer.startP;  
   stopP = yyyTermBuffer.stopP;  
   while (startP < stopP) rcPdum[*(startP++)] = 0; 
   if ((yyyNextNodeSpace += yyyNdPrSz[yyyTermBuffer.typeNum]) 
       > 
       yyyAfterNodeSpace 
      ) 
      yyyHandleOverflow(yyyNSof);  
   CTp1 = (yyyCopyType *)(yyyTermBuffer.snBufPtr); 
   CTp2 = (yyyCopyType *)(((char *)CTp2) + yyyGNSz); 
   CTp3 = CTp2 + yyyNdCopySz[yyyTermBuffer.typeNum]; 
   while (CTp2 < CTp3) *CTp2++ = *CTp1++; 
  } 



void yyyGenIntNode() 
  {register yyyWST i;
   register struct yyyStackItem *stDum;  
   register yyyGNT *gnpDum; 

   if ((stDum = (yyyStackTop -= (yyyRHSlength-1))) >= yyyAfterStack) 
      yyyHandleOverflow(yyySof);
   yyySTsn = ((char *)(yyySTN = (yyyGNT *)yyyNextNodeSpace)) + yyyGNSz; 
   yyySTN->parent       =  (void *)yyyStackTop;  
   yyySTN->cL           =  yyyNextCLspace; 
   yyySTN->refCountList =  yyyNextRCLspace; 
   yyySTN->prodNum      =  yyyProdNum; 
   if ((yyyNextCLspace+yyyRHSlength) > yyyAfterChildListSpace) 
      yyyHandleOverflow(yyyCLof); 
   for (i=1;i<=yyyRHSlength;i++) 
     {gnpDum = *(yyyNextCLspace++) = (stDum++)->node;  
      gnpDum->whichSym = i;  
      gnpDum->parent = (void *)yyyNextNodeSpace; 
     } 
   if ((yyyNextRCLspace += yyyNattrbs) > yyyAfterRefCountListSpace) 
      yyyHandleOverflow(yyyRCof); 
   if ((yyyNextNodeSpace += yyyNdPrSz[yyyTypeNum]) > yyyAfterNodeSpace) 
      yyyHandleOverflow(yyyNSof);  
  } 



#define yyyDECORfREQ 50 



void yyyAdjustINRC(startP,stopP) 
  register yyyFT *startP,*stopP;
  {yyyWST i;
   long SSALptr,SSALptrHead,*cPtrPtr; 
   long *pL; 
   struct yyyStackItem *stDum;  
   yyyGNT *gnpDum; 
   long iTemp;
   register yyyFT *nextP;
   static unsigned short intNodeCount = yyyDECORfREQ;

   nextP = startP;
   while (nextP < stopP) 
     {if ((*nextP) == yyyR)  
         {(yyySTN->refCountList)[*(nextP+1)] = *(nextP+2);
         } 
         else 
         {(((yyySTN->cL)[*nextP])->refCountList)[*(nextP+1)] = *(nextP+2);
         } 
      nextP += 3;  
     }
   pL = yyyIIEL + yyyIIIEL[yyyProdNum]; 
   stDum = yyyStackTop;  
   for (i=1;i<=yyyRHSlength;i++) 
     {pL++; 
      SSALptrHead = SSALptr = *(cPtrPtr = &((stDum++)->solvedSAlist)); 
      if (SSALptr != yyyLambdaSSAL) 
         {*cPtrPtr = yyyLambdaSSAL; 
          do 
            {
             iTemp = (*pL+yyySSALspace[SSALptr].attrbNum);
             yyySignalEnts(yyySTN,
                           yyyEntL + yyyIEL[iTemp],
                           yyyEntL + yyyIEL[iTemp+1]
                          );  
             SSALptr = *(cPtrPtr = &(yyySSALspace[SSALptr].next)); 
            } 
            while (SSALptr != yyyLambdaSSAL);  
          *cPtrPtr = yyySSALCfreeList;  
          yyySSALCfreeList = SSALptrHead;  
         } 
     } 
   nextP = startP + 2;
   while (nextP < stopP) 
     {if (!(*nextP))
         {if ((*(nextP-2)) == yyyR)  
             {pL = &(yyyStackTop->solvedSAlist); 
              if (yyySSALCfreeList == yyyLambdaSSAL) 
                 {yyySSALspace[yyyNewSSALC].next = *pL; 
                  if ((*pL = yyyNewSSALC++) == yyySSALspaceSize) 
                     yyyHandleOverflow(yyySSALof); 
                 }  
                 else
                 {iTemp = yyySSALCfreeList; 
                  yyySSALCfreeList = yyySSALspace[yyySSALCfreeList].next; 
                  yyySSALspace[iTemp].next = *pL; 
                  *pL = iTemp;  
                 } 
              yyySSALspace[*pL].attrbNum = *(nextP-1); 
             } 
             else 
             {if ((gnpDum = (yyySTN->cL)[*(nextP-2)])->prodNum != 0)
                 {
                  iTemp = yyyIIEL[yyyIIIEL[gnpDum->prodNum]] + *(nextP-1);
                  yyySignalEnts(gnpDum, 
                                yyyEntL + yyyIEL[iTemp],  
                                yyyEntL + yyyIEL[iTemp+1] 
                               );    
                 }  
             } 
         } 
      nextP += 3; 
     } 
   yyyStackTop->node = yyySTN;
   if (!yyyRHSlength) yyyStackTop->oldestNode = yyySTN; 
   if (!--intNodeCount) 
      {intNodeCount = yyyDECORfREQ; 
       yyyDecorate(); 
      } 
  } 



void yyyPrune(prodNum) 
  long prodNum;
  {  
   int i,n; 
   register char *cp1,*cp2;  
   register yyyRCT *rcp1,*rcp2,*rcp3;  
   long cycleSum = 0;
   long nNZrc = 0;
   yyyRCT *tempNextRCLspace;
   
   yyyDecorate();
   tempNextRCLspace = yyyNextRCLspace;
   yyyNextRCLspace = 
     (rcp1 = rcp2 = (yyyStackTop->oldestNode)->refCountList) + yyyNattrbs;
   rcp3 = (yyyStackTop->node)->refCountList; 
   while (rcp2 < rcp3) 
     if (*rcp2++) {cycleSum += *(rcp2 - 1); nNZrc++;} 
   if (nNZrc) 
      {
       fprintf(stderr,"\n\n\n----------\n");
       fprintf(stderr,
         "cycle detected during pruning of a subtree\n");
       fprintf(stderr,
         "  at whose root production %d is applied.\n",prodNum);
       yyyNextRCLspace = tempNextRCLspace; 
       fprintf(stderr,
         "prune aborted: searching subtree for %d unsolved instances:\n",
               nNZrc
              );
       yyyUnsolvedInstSearchTrav(yyyStackTop->node);
       return; 
      }
   for (i=0;i<yyyNattrbs;i++) rcp1[i] = rcp3[i]; 
   yyyNextCLspace = (yyyStackTop->oldestNode)->cL; 
   yyyNextNodeSpace = (char *)(yyyStackTop->oldestNode) + 
                      (n = yyyNdPrSz[yyyTypeNum]);
   cp1 = (char *)yyyStackTop->oldestNode; 
   cp2 = (char *)yyyStackTop->node; 
   for (i=0;i<n;i++) *cp1++ = *cp2++; 
   yyyStackTop->node = yyyStackTop->oldestNode; 
   (yyyStackTop->node)->refCountList = rcp1; 
   (yyyStackTop->node)->cL = yyyNextCLspace; 
  } 



void yyyGenLeaf(nAttrbs,typeNum,startP,stopP) 
  int nAttrbs,typeNum; 
  yyyWAT *startP,*stopP; 
  {
   if  (!(yyyTermBuffer.isEmpty)) yyyShift(); 
   yyyTermBuffer.isEmpty = 0;
   yyyTermBuffer.typeNum = typeNum; 
   yyyTermBuffer.nAttrbs = nAttrbs; 
   yyyTermBuffer.startP = startP; 
   yyyTermBuffer.stopP = stopP; 
   
  } 



void yyyerror()
  {yyyYok = 0; 
  } 



/* read the command line for changes in sizes of 
                  the evaluator's data structures */
void yyyCheckForResizes(argc,argv) 
  int argc; 
  char *argv[]; 
  {int i; 
   long dum; 
 
   if (!yyyPermitUserAlloc) return; 
   for (i=1;i<argc;i++) 
     { 
      if ((argv[i][0] != '-') || (argv[i][1] != 'Y')) continue; 
      if (strlen(argv[i]) < 4) goto yyyErrO1; 
      if (sscanf(argv[i]+3,"%d",&dum) != 1) goto yyyErrO1;
      if (dum < 2) dum = 2;
      switch (argv[i][2]) 
        {case yyyNSof:   yyyMaxNbytesNodeStg = dum; break; 
         case yyyRCof:   yyyMaxNrefCounts    = dum; break; 
         case yyyCLof:   yyyMaxNchildren     = dum; break; 
         case yyySof:    yyyMaxStackSize     = dum; break; 
         case yyySSALof: yyySSALspaceSize    = dum; break; 
         case yyyRSof:   yyyRSmaxSize        = dum; break; 
         case yyyTSof:   yyyTravStackMaxSize = dum; break; 
         default : goto yyyErrO1; 
        }
      continue;  
   yyyErrO1 : fprintf(stderr,"invalid command line option: %s\n",
                             argv[i] 
                     ); 
     } 
  } 
   
   
   


#define yyyLastProdNum 54


#define yyyNsorts 5


int yyyProdsInd[] = {
   0,
   0,   2,   3,   7,  13,  20,  29,  39,  41,  44,
  47,  51,  54,  58,  62,  67,  69,  72,  75,  78,
  81,  86,  91,  95,  97,  99, 104, 106, 109, 112,
 115, 118, 122, 126, 128, 130, 133, 136, 139, 143,
 146, 150, 153, 157, 161, 163, 168, 170, 175, 180,
 186, 188, 191, 194,
 198,
};


int yyyProds[][2] = {
{ 334,   0},{1013,   0},{1013,   0},{1013,   0},{1013,   0},
{  21,   0},{ 548,   0},{  21,   0},{ 619,   1},{ 396,   0},
{ 114,   2},{ 404,   0},{ 124,   0},{  21,   0},{ 619,   1},
{ 396,   0},{ 114,   2},{ 404,   0},{  63,   3},{ 124,   0},
{  21,   0},{ 619,   1},{1060,   0},{ 114,   2},{1076,   0},
{ 396,   0},{ 114,   2},{ 404,   0},{ 124,   0},{  21,   0},
{ 619,   1},{1060,   0},{ 114,   2},{1076,   0},{ 396,   0},
{ 114,   2},{ 404,   0},{  63,   3},{ 124,   0},{ 114,   2},
{ 619,   1},{ 114,   2},{ 821,   2},{ 619,   1},{ 821,   2},
{ 619,   1},{ 428,   0},{ 821,   2},{ 821,   2},{ 619,   1},
{ 428,   0},{  63,   3},{ 246,   3},{ 548,   0},{  63,   3},
{ 126,   4},{ 246,   3},{ 548,   0},{  63,   3},{  63,   3},
{ 246,   3},{ 548,   0},{  63,   3},{  63,   3},{ 126,   4},
{ 246,   3},{ 548,   0},{ 126,   4},{  12,   4},{ 126,   4},
{ 126,   4},{  12,   4},{  12,   4},{ 619,   1},{ 540,   0},
{ 246,   3},{ 838,   0},{ 430,   5},{ 246,   3},{ 762,   0},
{ 619,   1},{ 246,   3},{ 635,   0},{ 430,   5},{ 762,   0},
{ 619,   1},{ 246,   3},{ 933,   0},{ 619,   1},{ 564,   0},
{ 430,   5},{ 246,   3},{ 286,   5},{ 564,   0},{ 430,   5},
{ 246,   3},{ 997,   5},{ 286,   5},{ 619,   1},{ 286,   5},
{ 997,   5},{ 804,   0},{ 430,   5},{ 820,   0},{ 430,   5},
{ 997,   5},{ 430,   5},{ 231,   5},{ 997,   5},{ 430,   5},
{ 997,   5},{ 859,   5},{ 430,   5},{ 997,   5},{ 860,   5},
{ 430,   5},{ 997,   5},{ 861,   5},{ 430,   5},{ 997,   5},
{ 572,   0},{ 997,   5},{ 430,   5},{ 997,   5},{ 564,   0},
{ 997,   5},{ 231,   5},{1165,   0},{ 231,   5},{ 436,   0},
{ 231,   5},{ 231,   5},{1165,   0},{ 231,   5},{ 231,   5},
{ 436,   0},{ 859,   5},{ 420,   0},{ 997,   5},{ 859,   5},
{ 859,   5},{ 420,   0},{ 997,   5},{ 860,   5},{ 412,   0},
{ 997,   5},{ 860,   5},{ 860,   5},{ 412,   0},{ 997,   5},
{ 861,   5},{ 120,   0},{ 997,   5},{ 861,   5},{ 861,   5},
{ 120,   0},{ 997,   5},{ 997,   5},{ 396,   0},{ 430,   5},
{ 404,   0},{ 997,   5},{ 765,   0},{ 997,   5},{ 997,   5},
{ 804,   0},{ 430,   5},{ 820,   0},{ 997,   5},{ 619,   1},
{ 997,   5},{ 619,   1},{ 396,   0},{ 288,   5},{ 404,   0},
{ 997,   5},{ 619,   1},{1060,   0},{ 288,   5},{1076,   0},
{ 997,   5},{ 997,   5},{ 588,   0},{ 396,   0},{ 288,   5},
{ 404,   0},{ 288,   5},{ 430,   5},{ 288,   5},{ 994,   5},
{ 430,   5},{ 994,   5},{ 430,   5},{ 428,   0},{ 994,   5},
{ 994,   5},{ 430,   5},{ 428,   0},
};


int yyySortsInd[] = {
  0,
  0,  1,  2,  4,  5,
  6,
};


int yyySorts[] = {
  381,  146,  987, 1088,  766,  882,
};



char *yyyStringTab[] = {
"lists",0,0,0,0,
0,0,0,0,0,
0,0,"Labeldef",0,0,
0,0,0,0,0,
0,"Def",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"three",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"Stats",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"Pars",
0,0,0,0,0,
"AND",0,"y",0,"END",
0,"Labeldefs",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"pars",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"LABEL",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"NotOrMinusChain",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"Stat",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"Lexpr",0,"Exprs",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"Start",
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"name",0,0,0,
0,0,0,0,0,
0,0,"list_t",0,0,
0,"'('",0,0,"visibility",
0,0,0,0,"')'",
0,0,0,0,"empty",
0,0,"'*'",0,0,
0,"strdup",0,0,0,
"'+'",0,0,0,0,
0,0,"duplicate","','",0,
"Expr",0,0,0,0,
0,"'-'",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"':'",0,0,0,0,
0,0,0,"';'",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"'='",
0,0,0,0,0,
0,0,"'>'",0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"'@'",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"check",0,0,0,"ID",
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"IF",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"GOTO",0,0,
"NUM","labels",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"list",0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,"'['",
0,0,0,0,"node",
0,0,0,0,0,
0,0,0,0,0,
"']'","Parscsv",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"RETURN",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"VARIABLE",0,"Termaddsv",
"Termmulsv","Termandsv",0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"ids",0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"VAR",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,"in",0,0,
0,0,0,0,"Exprcsv",
0,0,"Term",0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,"Program",0,
0,0,0,0,0,
0,0,0,"yytext",0,
0,0,0,0,0,
0,0,0,0,"merge",
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"'{'",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,"'}'",0,0,0,
0,0,0,0,0,
0,0,0,"out",0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"add",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
"NOT",0,0,0,0,
0,0,0,0,0,
"visible",0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,0,0,0,0,
0,
};



#define yyySizeofProd(num) (yyyProdsInd[(num)+1] - yyyProdsInd[(num)])

#define yyyGSoccurStr(prodNum,symPos) \
   (yyyStringTab[yyyProds[yyyProdsInd[(prodNum)] + (symPos)][0]])

#define yyySizeofSort(num) (yyySortsInd[(num)+1] - yyySortsInd[(num)])

#define yyySortOf(prodNum,symPos) \
  (yyyProds[yyyProdsInd[(prodNum)] + (symPos)][1]) 

#define yyyAttrbStr(prodNum,symPos,attrbNum)                      \
  (yyyStringTab[yyySorts[yyySortsInd[yyySortOf(prodNum,symPos)] + \
                         (attrbNum)                               \
                        ]                                         \
               ]                                                  \
  )



void yyyShowProd(i)
  int i;
  {int j,nSyms;

   nSyms = yyySizeofProd(i);
   for (j=0; j<nSyms; j++)
     {
      fprintf(stderr,"%s",yyyGSoccurStr(i,j));
      if (j == 0) fprintf(stderr," : "); else fprintf(stderr," ");
     }
   fprintf(stderr,";\n");
  }



void yyyShowProds()
  {int i; for (i=1; i<=yyyLastProdNum; i++) yyyShowProd(i);}



void yyyShowSymsAndSorts()
  {int i; 

   for (i=1; i<=yyyLastProdNum; i++) 
     {int j, nSyms;

      fprintf(stderr,
              "\n\n\n---------------------------------- %3.1d\n",i);
      /* yyyShowProd(i); */ 
      nSyms = yyySizeofProd(i); 
      for (j=0; j<nSyms; j++) 
        {int k, sortSize;

         fprintf(stderr,"%s\n",yyyGSoccurStr(i,j));
         sortSize = yyySizeofSort(yyySortOf(i,j));
         for (k=0; k<sortSize; k++) 
            fprintf(stderr,"  %s\n",yyyAttrbStr(i,j,k));
         if (j == 0) fprintf(stderr,"->\n"); 
              else 
              fprintf(stderr,"\n"); 
        }
     }
  }



void yyyCheckNodeInstancesSolved(np)
  yyyGNT *np;
  {int mysort,sortSize,i,prodNum,symPos,inTerminalNode;
   int nUnsolvedInsts = 0;

   if (np->prodNum != 0)
     {inTerminalNode = 0;
      prodNum = np->prodNum;
      symPos = 0;
     }
   else
     {inTerminalNode = 1;
      prodNum = ((yyyGNT *)(np->parent))->prodNum;
      symPos = np->whichSym;
     }
   mysort = yyySortOf(prodNum,symPos);
   sortSize = yyySizeofSort(mysort);
   for (i=0; i<sortSize; i++)
     if ((np->refCountList)[i] != 0) nUnsolvedInsts += 1;
   if (nUnsolvedInsts)
     {fprintf(stderr,
      "\nFound node that has %d unsolved attribute instance(s).\n",
              nUnsolvedInsts
             );
      fprintf(stderr,"Node is labeled \"%s\".\n",
             yyyGSoccurStr(prodNum,symPos));
      if (inTerminalNode)
        {fprintf(stderr,
                 "Node is terminal.  Its parent production is:\n  ");
         yyyShowProd(prodNum);
        }
      else
        {fprintf(stderr,"Node is nonterminal.  ");
         if (((char *)(np->parent)) >= yyyNodeSpace)
           {fprintf(stderr,
                    "Node is %dth child in its parent production:\n  ",
                   np->whichSym
                  );
            yyyShowProd(((yyyGNT *)(np->parent))->prodNum);
           }
         fprintf(stderr,
                 "Node is on left hand side of this production:\n  ");
         yyyShowProd(np->prodNum);
        }
      fprintf(stderr,"The following instances are unsolved:\n");
      for (i=0; i<sortSize; i++)
        if ((np->refCountList)[i] != 0)
          fprintf(stderr,"     %-16s still has %1d dependencies.\n",
                  yyyAttrbStr(prodNum,symPos,i),(np->refCountList)[i]);
     }
  }



void yyyUnsolvedInstSearchTravAux(pNode)
  yyyGNT *pNode;
  {yyyGNT **yyyCLpdum;
   int i;
  
   yyyCheckNodeInstancesSolved(pNode); 
   yyyCLpdum = pNode->cL;
   while
     ((yyyCLpdum != yyyNextCLspace) && ((*yyyCLpdum)->parent == pNode))
     {
      yyyUnsolvedInstSearchTravAux(*yyyCLpdum);
      yyyCLpdum++;
     }
  }



void yyyUnsolvedInstSearchTrav(pNode)
  yyyGNT *pNode;
  {yyyGNT **yyyCLpdum;
   int i;
  
   yyyCLpdum = pNode->cL;
   while
     ((yyyCLpdum != yyyNextCLspace) && ((*yyyCLpdum)->parent == pNode))
     {
      yyyUnsolvedInstSearchTravAux(*yyyCLpdum);
      yyyCLpdum++;
     }
  }



