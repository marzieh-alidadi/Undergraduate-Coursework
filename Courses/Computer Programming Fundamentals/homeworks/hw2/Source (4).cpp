/*mokaab too mokaab mabani taklife1/2*/
#include<stdio.h>
int main()
{
	long double a,b,c,e,f,g,hold1,hold2;
	scanf("%Lf%Lf%Lf%Lf%Lf%Lf",&a,&b,&c,&e,&f,&g);
	long double a1[]={a,b,c};
	long double a2[]={e,f,g};
	for(int i=0;i<2;i++)
	{if(a1[i]>a1[i+1])
	{hold1=a1[i];
	a1[i]=a1[i+1];
	a1[i+1]=hold1;}
	if(a2[i]>a2[i+1])
	{hold2=a2[i];
	a2[i]=a2[i+1];
	a2[i+1]=hold2;}}
	if((a1[0]>=a2[0]&&a1[1]>=a2[1]&&a1[2]>=a2[2])||(a1[0]<=a2[0]&&a1[1]<=a2[1]&&a1[2]<=a2[2]))
		printf("YES");
	else
		printf("NO");
	return 0;
}