/*araye barax taklife6/2mabani*/
#include<stdio.h>
int main()
{
	long long int n,i;
	long long int ar[100000];
	scanf("%lld",&n);
	for(i=0;i<n;i++)
	{
		scanf("%lld",&ar[i]);
	}
	printf("%lld",ar[n-1]);
	for(i=n-2;i>=0;i--)
	{
		printf(" --> ");
		printf("%lld",ar[i]);
	}
	return 0;
}