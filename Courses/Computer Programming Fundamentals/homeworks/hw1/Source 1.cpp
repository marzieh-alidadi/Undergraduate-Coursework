#include<stdio.h>
int main()
{
	long  long
		x,y,r,majmoo=0;
	while(1)
	{
	scanf("%lld",x);
	if(x<=0)
		break;
	y=x/2;
	while(y>0)
	{
		r=x%y;
		if(r==0)
			majmoo+=y;
		y--;
	}//akhare while koochike
	if(x==majmoo)
		printf("YES");
	else
		printf("NO");
}//akhare while bozorge
		return 0;
}