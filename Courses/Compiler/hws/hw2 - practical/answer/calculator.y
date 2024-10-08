%{
#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
extern int yylex();
extern FILE* yyin;
float ans=0;

struct var
{
	char name[10];
	float num;
};

int count = 0;
struct var var_arr[100];
float find_var;
int flag;
int yyparse();
int findvar(char vname[10]);
void yyerror(const char *s);
%}

%union{
	int ival;
	float fval;
	char cval;
	char sval[10];
}

%token <ival> INT
%token <fval> FLOAT
%token <sval> ID
%left <cval> '+' '-'
%left <cval> '*' '/'
%token SIN COS TAN
%right <cval> '^'
%token '(' ')'
%token ENTER

%token <cval> EQ
%type <fval> a

%%
s : s p | p;
p : a ENTER {
            char str[10]; 
            if($1 == atoi(itoa($1,str,10))) 
                printf("%d\n",atoi(itoa($1,str,10)));
            else 
                printf("%.2f\n",$1);
            }
    | ID EQ a ENTER {
                    char str[10]; 
                    int c =findvar($1); 
                    if(c!=-1){var_arr[c].num=$3;}
                    else{ strcpy(var_arr[count].name,$1); var_arr[count].num= $3; count = count + 1; }
                    }
    | ID ENTER {
                if(findvar($1)!=-1) {  
                                    char str[10]; 
                                    if (find_var== atoi(itoa(find_var,str,10)))
                                        printf("%d\n",atoi(itoa(find_var,str,10))); 
                                    else 
                                        printf("%f\n",find_var);
                                    } 
                else printf("Var doesn't exist!\n");
                }
;
a :  a  '*' a {$$ = $1 * $3;}
    | a  '/' a {$$ = $1 / $3;}
    | a '+' a {$$ = $1 + $3;}
    | a '-' a {$$ = $1 - $3;}
    | a '^' a {$$ = pow($1, $3);}
    | FLOAT { $$ = $1;}
    | '-' FLOAT {$$ = -1*$2;}
    | INT {$$ = $1;}
    | '-' INT {$$ = -1*$2;}
    | ID {if(findvar($1)!=-1) $$=find_var;}
    | function '(' a ')' {
                          if(flag==1) $$= sin($3);
                          else if(flag==2) $$= cos($3); 
                          else if(flag==3) $$= tan($3); 
                         }   
;
function : SIN {flag=1;}
            | COS {flag=2;} 
            | TAN {flag=3;};
/*
trig_function: SIN a {$$ = sin($2);}
		        | COS a {$$ = cos($2);}
		        | TAN a {$$ = tan($2);}
                | COT a {$$ = cot($2);}
*/
;
%%

int main()
{
    yyparse();
    return 0;
}

void yyerror(const char *s)
{
	printf("-Error-");
}

int findvar(char vname[10])
{
	for(int i =0;i<count;i++)
	{
		if(strcmp(vname,var_arr[i].name)==0)
		{
			find_var = var_arr[i].num;
			return i;
		}
	}
return -1;
}