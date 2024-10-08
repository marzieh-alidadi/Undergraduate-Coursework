%option noyywrap

/* Definition Section */
%{
    #include <stdio.h>
    #include <string.h>
	int line = 0, count = 0, flag = 0, functions_num, open_func = 0, close_func = 0, main_flag = 0, func_flag = -1;
	char text[100][255];
	char functions[100][255];
%}

/* Rule Section */
%%
"proctype "	{
			int i = 0;
			char temp[255];
			while(1){
				if((text[line]+count+9+i)[0] != '('){
					temp[i] = (text[line]+count+9+i)[0];
				}
				else{
					temp[i] = '\0';
					break;				
				}
				i++;
			}
			if(strcmp(temp,"p_main")){
				int j = 0;
				while((text[line]+count+strlen(temp)+9+j)[0] != '\n'){
					(text[line]+count+strlen(temp)+9+j)[0] = ' ';
					j++;
				}
				char str[255];
				char str1[255];
				strcpy(str, "(chan out_");
				strcpy(str1, ")");
				strcat(str,temp);
				strcat(str,str1);
				j = 0;
				while(str[j] != '\0'){
					(text[line]+count+strlen(temp)+9+j)[0] = str[j];
					j++;
				}
				(text[line]+count+strlen(temp)+9+j)[0] = '\n';	
			}
			else{
				main_flag = 1;
			}
			int j = 0;
			while(j < functions_num){
				char temp2[255];
				int z = 0;
				while(functions[j][z] != '\n'){
					temp2[z] = functions[j][z];
					z++;
				}
				temp2[z] = '\0';
				if(!strcmp(temp,temp2)){
					func_flag = j;
					break;
				}
				j++;
			}
		}
"{"	{
		open_func++;
	}
"}"	{
		close_func++;
		if(open_func == close_func){
			open_func = 0;
			close_func = 0;
			if(main_flag == 0){
				int i=0;
				while(i<1){
					(text[line]+count+i)[0] = ' ';
					i++;
				}
				char str[255];
				char str1[255];
				strcpy(str, "out_");
				strcpy(str1, " ! 1;\n}");
				char temp[255];
				int j = 0;
				while(functions[func_flag][j] != '\n'){
					temp[j] = functions[func_flag][j];
					j++;
				}
				strcat(str,temp);
				strcat(str,str1);
				j = 0;
				while(str[j] != '\0'){
					(text[line]+count+j)[0] = str[j];
					j++;
				}
				(text[line]+count+j)[0] = '\n';
			}
			else{
				main_flag = 0;
			}
		}
	}
\n	{ line++; count = 0; }
.	{ if(count == 0 && flag == 1) { text[line][0] = '\0'; } count++; }
%%

/* Code Section */
int main(){
	FILE* f1 = fopen("Result-fourth.pml", "r");	
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

	f1 = fopen("Result-fourth.pml", "r");
	yyin = f1;
	yylex();
	fclose(f1);
	
	FILE * f2 = fopen("Result-fifth.pml", "w");
	for(int j=0; j<line+1; j++){
		fputs(text[j],f2);
	}
    return 0;
}
