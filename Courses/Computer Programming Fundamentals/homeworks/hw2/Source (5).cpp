/*taghire mabna bedoone bazgashti taklife2/2mabani*/
#include<stdio.h>
long long int pow(long long int x,long long int y);
int main()
{ 
	int m,r1,r2,r3=0,ten=10;
	long long int x=0,n,p,q,n1,i=0,j=0,z=0;
	scanf("%lld%d",&n,&m);
	n1=n;
	if(m==1)
	{printf("ERROR");
	return 0;}
	for(;n!=0;i++)
	{
		r1=n%10;
		q=pow(m,i);
		z+=(r1*q);
		n/=10;
	}
	for(;z!=0;j++)
	{
		r2=z%2;
		p=pow(ten,j);
		x+=r2*p;
		z/=2;
	}
	while(n1!=0)
	{
		r3=n1%10;
		if(r3>=m)
		{printf("ERROR");
		return 0;
		}
		n1=n1/10;
	}
		printf("%lld",x);
		return 0;
	}
long long int pow(long long int x,long long int y)
	{
		long long int z=1;
		for(int counter=1;counter<=y;counter++)
		{
			z*=x;
		}
		return z;
}