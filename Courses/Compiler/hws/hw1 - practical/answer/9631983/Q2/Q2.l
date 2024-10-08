%option noyywrap

/* Definition Section */
%{
    #include <stdio.h>
    #include <string.h>
	int line_count = 1, letter_count = 0, hello_count = 0;
	char text[100][2];
%}

/* Rule Section */
%%
\n          {letter_count = 0; line_count++;}
"hello"     {letter_count++; hello_count++; text[hello_count-1][0] = line_count; text[hello_count-1][1] = letter_count; letter_count = letter_count + 4;}
.           {letter_count++;}
%%

/* Code Section */
int main(){
    yyin = fopen("sample_text.txt", "r");
    yylex();
    for(int i=0; i<hello_count; i++){
        printf("%d : %d\n", text[i][0], text[i][1]);
    }
    return 0;
}