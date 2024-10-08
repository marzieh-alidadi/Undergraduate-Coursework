/*chandomin koochak taklife5/2mabani*/
#include<stdio.h>
int main()
{
	double ar[100000],hold,chandomin;
	long long int n,k,i,j;
	scanf("%lld",&n);
	if(n==0)
		return 0;
	for(i=0;i<n;i++)
	{
		scanf("%lf",&ar[i]);
	}
	scanf("%lld",&k);
	for(i=0;i<n-1;i++)
	{
		for(j=1;j<n;j++)
		{
		if(j>i && ar[i]>ar[j])
		{
			hold=ar[i];
			ar[i]=ar[j];
			ar[j]=hold;
		}
		}
	}
	chandomin=ar[k-1];
	printf("%f",chandomin);
	return 0;
}