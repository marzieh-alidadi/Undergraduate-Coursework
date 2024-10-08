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
"//"        { (text[line]+count+1)[0] = '\0'; (text[line]+count)[0] = '\n'; }
"/*"        { flag = 1; (text[line]+count+1)[0] = '\0'; (text[line]+count)[0] = '\n'; }
"*/"        { if(flag == 1) {flag = 0 ; strcpy(text[line] , text[line]+count+2); } }
\n	        { line++; count=0; }
.           { if(count == 0 && flag == 1) { text[line][0] = '\0'; } count++; }
%%

/* Code Section */
int main(){
	FILE* f1 = fopen("example.cpp", "r");	
	int i = 0;
	char buffer[255];
	while(fgets(buffer, 255, f1)){
		strcpy(text[i],buffer);
		i++;
	}
	fclose(f1);

	f1 = fopen("example.cpp", "r");
	yyin = f1;
	yylex();
	fclose(f1);
	
	FILE * f2 = fopen("noComm_example.cpp", "w");
	for(int j=0; j<line+1; j++){
		fputs(text[j],f2);
	}
    return 0;
}