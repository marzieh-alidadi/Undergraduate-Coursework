%option noyywrap

/* Definition Section */
%{
    #include <stdio.h>
    #include <string.h>
	int line = 0, count = 0, flag = 0;
	char text[100][255];
%}

/* Rule Section */
%%
"active proctype "	{	
				char temp[6];
				int i=0;
				while(i<6){
					temp[i] = (text[line]+count+16+i)[0];
					i++;
				}
				if(strcmp(temp,"p_main")){
					i=0;
					while(i<7){
						(text[line]+i)[0] = ' ';
						i++;
					}	
				}
			}

\n	{ line++; count = 0; }
.	{ if(count == 0 && flag == 1) { text[line][0] = '\0'; } count++; }
%%

/* Code Section */
int main(){
	FILE* f1 = fopen("model", "r");	
	int i = 0;
	char buffer[255];
	while(fgets(buffer, 255, f1)){
		strcpy(text[i],buffer);
		i++;
	}
	fclose(f1);

	f1 = fopen("model", "r");
	yyin = f1;
	yylex();
	fclose(f1);
	
	FILE * f2 = fopen("Result-first.pml", "w");
	for(int j=0; j<line+1; j++){
		fputs(text[j],f2);
	}
    return 0;
}
