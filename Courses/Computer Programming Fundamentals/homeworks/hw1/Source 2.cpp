#include <stdio.h>
#include <math.h>
int main()
{
	int a=0;
	long long n, p = 0, r= 0, cnt = 0;
	scanf("%lld", &n);
	while (n > 0)
	{
		a = n % 10;
		n = n / 10;
		if (a % 2 != 0)
			p= p* 10 + a;
		else
		{
			r = r + pow(10, cnt)*a;
			cnt++;
		}
	}
	if (p == 0)
	{
		printf("%lld\n", r);
		printf("oPs");
	}
	else if (r == 0)
	{
		printf("oPs\n");
		printf("%lld", p);
	}
	else
		printf("%lld\n%lld", r, p);
	return 0;
}