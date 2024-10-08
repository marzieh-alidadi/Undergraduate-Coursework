%option noyywrap

/* Definition Section */
%{
    #include <stdio.h>
    #include <string.h>
	int line = 0, count = 0, flag = 0, functions_num;
	char text[100][255];
	char functions[100][255];
%}

/* Rule Section */
%%
"->"	{	
		int i = 0;
		while(i < functions_num){
			int j = 0;
			while(functions[i][j] != '\0'){	
				j++;
			}
			int func_num_len = j;
			int z = 0;
			char temp[255];
			while(j > 1){
				temp[z] = (text[line]+count-j+1)[0];
				j--;
				z++;
			}
			temp[z] = '\0';
			int flag = 1;
			j = 0;
			while(temp[j] != '\0'){
				if(functions[i][j] != temp[j] || strlen(temp) != (strlen(functions[i]))-1){
					flag = 0;
					break;
				}
				j++;
			}
			if(flag == 1 && strlen(temp) != 0){
				j = -2;
				while(j < func_num_len){
					(text[line]+count-j-1)[0] = ' ';
					j++;
				}
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
	FILE* f1 = fopen("Result-second.pml", "r");	
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

	f1 = fopen("Result-second.pml", "r");
	yyin = f1;
	yylex();
	fclose(f1);
	
	FILE * f2 = fopen("Result-third.pml", "w");
	for(int j=0; j<line+1; j++){
		fputs(text[j],f2);
	}
    return 0;
}
