%{
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "calculator.tab.h"
%}

floats ([0-9])+[.]([0-9])+
ints ([1-9])+([0-9])*

%%
[a-z]+ {strcpy(yylval.sval,yytext); return ID;}
{floats} {yylval.fval = atof(yytext); return FLOAT;}
{ints} {yylval.ival = atoi(yytext); return INT;}
"*" {return '*';}
"+" {return '+';}
"-" {return '-';}
"/" {return '/';}
"^" {return '^';}
"=" {return EQ;}
\n {return ENTER;}
"(" {return '(';}
")" {return ')';}
("sin")|("SIN")	{return SIN;}
("cos")|("COS")	{return COS;}
("tan")|("TAN")	{return TAN;}
[ ] {}
%%

int yywrap(){}