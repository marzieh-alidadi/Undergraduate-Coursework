#include<stdio.h>    

/* It's a test comment
to check the .lex code */
int main()
{    
    int n1=0,n2=1,n3,i,number;    
    printf("Enter the number of elements:");    
    scanf("%d",&number);    
    printf("\n%d %d",n1,n2);//printing 0 and 1    
    for(i=2;i<number;++i)//loop starts from 2 because 0 and 1 are already printed    
    {    /* /* It's the second test // comment
         to check the .lex code */
        n3=n1+n2;    
        printf(" %d",n3);    
        n1=n2;    
        n2=n3;    
    }  
    return 0;  
}    
//the end     /*the last 
                 test comment*/