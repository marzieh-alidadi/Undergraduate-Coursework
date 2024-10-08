/* az akhar be aval.taklif mabani 1/3 */
#include<stdio.h>
void barax(long long int n);//tabei ke az akhar chap mikone
int main()
{
	long long int n;//tedad adad
	scanf("%lld",&n);
	barax(n);
	return 0;
}//main
void barax(long long int n)
{
	long long int a;
	scanf("%lld",&a);
	if(n==1)
	{
		printf("%lld",a);
		return;//bar migarde avale tabe barax
	}
	else
	{
		n--;
		barax(n);
		printf(" --> ");
		printf("%lld",a);
	}
}// barax
