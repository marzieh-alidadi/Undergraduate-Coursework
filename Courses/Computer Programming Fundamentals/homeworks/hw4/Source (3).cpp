#include<stdio.h>
int main()
{
	int i, j;
	double a[7][7];
	for (j = 0; j < 7; j++)
		for (i = 0; i < 7; i++)
			scanf("%lf", &a[i][j]);
	for (i = 0; i < 7; i++)
	{
		a[i][3] = a[i][i] + a[i][6 - i];
	}
	for (i = 0; i < 7; i++)
	{
		for (j = 0; j < 7; j++)
			printf("%.2f ", a[i][j]);
		printf("\n");
	}
	return 0;
}