%option noyywrap

/* Definition Section */
%{
    #include <stdio.h>
    #include <string.h>
	int line_count = 1, flag = 0, number = 0, pointer = 0, length, not_blank = 0, operation;
	char text[255];
    int operands[3];
%}

/* Rule Section */
%%
[\n]            {   if((flag==-1 || !(flag==1 && number==3)) && not_blank==1){
                        printf("line %d: ", line_count);
                        for(int i=0;i<pointer;i++){
                            printf("%c", text[i]);
                        }
                        printf("\n");
                        pointer = 0;
                    }else if(operation==1 && not_blank==1){
                        if(operands[0]+operands[1] != operands[2]){
                            printf("line %d: ", line_count);
                            for(int i=0;i<pointer;i++){
                                printf("%c", text[i]);
                            }
                            printf("\n");
                            pointer = 0;
                        }
                    }else if(operation==2 && not_blank==1){
                        if(operands[0]-operands[1] != operands[2]){
                            printf("line %d: ", line_count);
                            for(int i=0;i<pointer;i++){
                                printf("%c", text[i]);
                            }
                            printf("\n");
                            pointer = 0;
                        }
                    }else if(operation==3 && not_blank==1){
                        if(operands[0]*operands[1] != operands[2]){
                            printf("line %d: ", line_count);
                            for(int i=0;i<pointer;i++){
                                printf("%c", text[i]);
                            }
                            printf("\n");
                            pointer = 0;
                        }
                    }else if(operation==4 && not_blank==1){
                        if(operands[0]/operands[1] != operands[2]){
                            printf("line %d: ", line_count);
                            for(int i=0;i<pointer;i++){
                                printf("%c", text[i]);
                            }
                            printf("\n");
                            pointer = 0;
                        }
                    }
                    line_count++; flag = 0; pointer = 0; not_blank = 0;
                }
[0-9]+          {   if(flag==0){
                        flag = 1; number=1; operands[0] = atoi(yytext);
                    }else if(flag==1){
                        flag=-1;
                    }else if(flag==2 || flag==3 || flag==4 || flag==5){
                        flag=1; number=2; operands[1] = atoi(yytext);
                    }else if(flag==6){
                        flag=1; number=3; operands[2] = atoi(yytext);
                    } 
                    length=strlen(yytext);
                    int final = pointer+length;
                    int i = 0;
                    for(pointer,i;pointer<final;pointer++,i++){
                        text[pointer] = yytext[i];
                    }
                    not_blank = 1;
                }
"+"             {   
                    if(flag==0){
                        flag=-1;
                    }else if(flag==1 && number==1){
                        flag=2;
                    }else if(flag==1 && number==2){
                        flag=-1;
                    }else if(flag==1 && number==3){
                        flag=-1;
                    }else if(flag==2 || flag==3 || flag==4 || flag==5 || flag==6){
                        flag=-1;
                    }
                    length=strlen(yytext);
                    int final = pointer+length;
                    int i = 0;
                    for(pointer,i;pointer<final;pointer++,i++){
                        text[pointer] = yytext[i];
                    }
                    not_blank = 1; operation = 1;
                }
"-"             {
                    if(flag==0){
                        flag = -1;
                    }else if(flag==1 && number==1){
                        flag=3;
                    }else if(flag==1 && number==2){
                        flag=-1;
                    }else if(flag==1 && number==3){
                        flag=-1;
                    }else if(flag==2 || flag==3 || flag==4 || flag==5 || flag==6){
                        flag=-1;
                    }
                    length=strlen(yytext);
                    int final = pointer+length;
                    int i = 0;
                    for(pointer,i;pointer<final;pointer++,i++){
                        text[pointer] = yytext[i];
                    }
                    not_blank = 1; operation = 2;
                }
"*"             {
                    if(flag==0){
                        flag = -1;
                    }else if(flag==1 && number==1){
                        flag=4;
                    }else if(flag==1 && number==2){
                        flag=-1;
                    }else if(flag==1 && number==3){
                        flag=-1;
                    }else if(flag==2 || flag==3 || flag==4 || flag==5 || flag==6){
                        flag=-1;
                    }
                    length=strlen(yytext);
                    int final = pointer+length;
                    int i = 0;
                    for(pointer,i;pointer<final;pointer++,i++){
                        text[pointer] = yytext[i];
                    }
                    not_blank = 1; operation = 3;
                }
"/"             {
                    if(flag==0){
                        flag = -1;
                    }else if(flag==1 && number==1){
                        flag=5;
                    }else if(flag==1 && number==2){
                        flag=-1;
                    }else if(flag==1 && number==3){
                        flag=-1;
                    }else if(flag==2 || flag==3 || flag==4 || flag==5 || flag==6){
                        flag=-1;
                    }
                    length=strlen(yytext);
                    int final = pointer+length;
                    int i = 0;
                    for(pointer,i;pointer<final;pointer++,i++){
                        text[pointer] = yytext[i];
                    }
                    not_blank = 1; operation = 4;
                }
"="             {
                    if(flag==0){
                        flag = -1;
                    }else if(flag==1 && number==1){
                        flag=-1;
                    }else if(flag==1 && number==2){
                        flag=6;
                    }else if(flag==1 && number==3){
                        flag=-1;
                    }else if(flag==2 || flag==3 || flag==4 || flag==5 || flag==6){
                        flag=-1;
                    }
                    length=strlen(yytext);
                    int final = pointer+length;
                    int i = 0;
                    for(pointer,i;pointer<final;pointer++,i++){
                        text[pointer] = yytext[i];
                    }
                    not_blank = 1;
                }
" "             {
                    length=strlen(yytext);
                    int final = pointer+length;
                    int i = 0;
                    for(pointer,i;pointer<final;pointer++,i++){
                        text[pointer] = yytext[i];
                    }
                }
.               {
                    flag = -1;
                    length=strlen(yytext);
                    int final = pointer+length;
                    int i = 0;
                    for(pointer,i;pointer<final;pointer++,i++){
                        text[pointer] = yytext[i];
                    }
                    not_blank = 1;
                }
%%

/* Code Section */
int main(){
    FILE* f = fopen("sample_propositions.txt", "a");	
	fputs("\n", f);
    fclose(f);

    yyin = fopen("sample_propositions.txt", "r");
    yylex();
    return 0;
}


