%option noyywrap

/* Definition Section */
%{
    #include <stdio.h>
    #include <string.h>
	int line = 0, count = 0, flag = 0, functions_num = 0;
	char text[100][255];
	char functions[100][255];
%}

/* Rule Section */
%%
"proctype "	{	
			int i=0;
			while(1){
				if((text[line]+count+9+i)[0] != '('){
					functions[functions_num][i] = (text[line]+count+9+i)[0];
				}
				else{
					functions[functions_num][i] = '\0';
					functions_num++;
					break;				
				}
				i++;
			}
		}
\n	{ line++; count = 0; }
.	{ if(count == 0 && flag == 1) { text[line][0] = '\0'; } count++; }
%%

/* Code Section */
int main(){
	FILE* f1 = fopen("Result-first.pml", "r");	
	int i = 0;
	char buffer[255];
	while(fgets(buffer, 255, f1)){
		strcpy(text[i],buffer);
		i++;
	}
	fclose(f1);

	f1 = fopen("Result-first.pml", "r");
	yyin = f1;
	yylex();
	fclose(f1);
	
	FILE * f2 = fopen("Result-second.pml", "w");
	for(int j=0; j<line+1; j++){
		fputs(text[j],f2);
	}

	FILE * f3 = fopen("Result-Functions-second.txt", "w");
	for(int j=0; j<functions_num+1; j++){
		fputs(functions[j],f3);
		fputs("\n",f3);
	}
    return 0;
}
