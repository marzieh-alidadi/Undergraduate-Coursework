/*bakhshpaziri*/
#include<stdio.h>
int kmm(int a,int b);
int main()
{
	int n,a,helpKmm=1,r,bmm,counter=0;
	scanf("%d",&n);
	if(n==0)
	{printf("1000");
	return 0;}
	for(n;n>0;n--)
	{
		scanf("%d",&a);
		helpKmm=kmm(a,helpKmm);}
		for(int zarib=1;zarib*helpKmm<=1000;zarib++)
		{counter++;}
	if(counter==0)
	{printf("WOOW");}
	else
	{printf("%d",counter);}
		return 0;
	}
	int kmm(int a,int b)
	{
		int r,bmm,kmm,a1,b1;
		a1=a;
		b1=b;
		for(r=a%b;r!=0;r=a%b)
		{
		a=b;
		b=r;
		}
		bmm=b;
		kmm=a1*b1/bmm;
		return kmm;
	}