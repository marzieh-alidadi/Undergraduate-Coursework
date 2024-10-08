%option noyywrap

/* Definition Section */
%{
    #include <stdio.h>
    #include <string.h>
	int line = 0, count = 0, flag = 0, functions_num, open_func = 0, close_func = 0;
	int main_flag = 0, func_flag = -1, c_block_open = 0, c_block_close = 0;
	char text[100][255];
	char functions[100][255];
%}

/* Rule Section */
%%
"run "	{
		int i = 0;
		char temp[255];
		while(1){
			if((text[line]+count+4+i)[0] != '('){
				temp[i] = (text[line]+count+4+i)[0];
			}
			else{
				temp[i] = '\0';
				break;				
			}
			i++;
		}
		char str[255];
		char str1[30];
		strcpy(str, "int flag;\nchan out_");
		strcpy(str1, " = [0] of {int};\nrun ");
		strcat(str,temp);
		strcat(str,str1);
		strcat(str,temp);
		strcpy(str1, "(out_\0");
		strcat(str,str1);
		strcat(str,temp);
		strcpy(str1, ");\nout_");
		strcat(str,str1);
		strcat(str,temp);
		strcpy(str1, " ? flag;");
		strcat(str,str1);
		int j = 0;
		while(str[j] != '\0'){
			(text[line]+count+j)[0] = str[j];
			j++;
		}
		(text[line]+count+j)[0] = '\n';
	}
"c_expr {" |
"c_code {"	{
			c_block_open++;
			int i=0;
			while(i<8){
				(text[line]+count+i)[0] = ' ';
				i++;
			}
		}
"{"	{
		if(c_block_open != 0){
			c_block_open++;
		}
	}
"}"	{
		if(c_block_open != 0){
			c_block_close++;
		}
		if(c_block_open == c_block_close){
			c_block_open = 0;
			c_block_close = 0;
			int i=0;
			while(i<2){
				(text[line]+count+i+8)[0] = ' ';
				i++;
			}
		}
	}
\n	{ line++; count = 0; }
.	{ if(count == 0 && flag == 1) { text[line][0] = '\0'; } count++; }
%%

/* Code Section */
int main(){
	FILE* f1 = fopen("Result-fifth.pml", "r");	
	int i = 0;
	char buffer[255];
	while(fgets(buffer, 255, f1)){
		strcpy(text[i],buffer);
		i++;
	}
	fclose(f1);

	f1 = fopen("Result-Functions-second.txt", "r");	
	i = 0;
	char buffer2[255];
	while(fgets(buffer2, 255, f1)){
		strcpy(functions[i],buffer2);
		i++;
	}
	fclose(f1);
	functions_num = i;

	f1 = fopen("Result-fifth.pml", "r");
	yyin = f1;
	yylex();
	fclose(f1);
	
	FILE * f2 = fopen("Result-sixth.pml", "w");
	for(int j=0; j<line+1; j++){
		fputs(text[j],f2);
	}
    return 0;
}
