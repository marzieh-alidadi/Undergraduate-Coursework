/*taghire mabna bazgashti taklife3/2mabani*/
#include<stdio.h>
long long int pow(long long int x,long long int y);
long long int mabnaDah(long long int n,int m);
long long int mabnaDo(long long int z);
int main()
{ 
	int m,r3=0;
	long long int x,n,n1,z;
	scanf("%lld%d",&n,&m);
	n1=n;
	if(m==1)
	{printf("ERROR");
		return 0;}
	z=mabnaDah(n,m);
	x=mabnaDo(z);
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
long long int mabnaDah(long long int n,int m)
{
	long long int z,q;
	int r1;
	static int i=-1;
	i++;
	r1=n%10;
	q=pow(m,i);
	z=(r1*q);
	n/=10;
	if(n!=0)
		return z=z+mabnaDah(n,m);
	else
		return z;
}
long long int mabnaDo(long long int z)
{
	long long int x,p;
	int r2,ten=10;
	static int j=-1;
	j++;
	r2=z%2;
	p=pow(ten,j);
	x=r2*p;
	z/=2;
	if(z!=0)
		return x=x+mabnaDo(z);
	else
		return x;
}