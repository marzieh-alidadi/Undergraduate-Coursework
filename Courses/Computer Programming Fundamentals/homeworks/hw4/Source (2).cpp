#include<stdio.h>
int main()
{
	int i, j, a[7][7], hold;
	for (i = 0; i < 7; i++)
		for (j = 0; j < 7; j++)
			scanf("%d", &a[i][j]);
	for (j = 0; j < 3; j++)
		for (i=j+1; i <6-j; i++)
		{
			hold = a[i][j];
			a[i][j] = a[i][6 - j];
			a[i][6-j] = hold;

			hold = a[j][i];
			a[j][i] = a[6 - j][i];
			a[6 - j][i] = hold;	
		}
	for (i = 0; i < 7; i++)
	{
		for (j = 0; j < 7; j++)
			printf("%d ", a[i][j]);
		printf("\n");
	}
	return 0;
}