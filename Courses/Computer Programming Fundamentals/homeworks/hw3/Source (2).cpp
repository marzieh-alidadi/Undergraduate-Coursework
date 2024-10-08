/*bozorgtarin kalame*/
#include<stdio.h>
int main()
{
	int n, i, i1, j, c, counter[300] = { 0 }, bigCount = 0, bigChar[100] = {0},character[100];
	char s[400];
	scanf("%d", &n);
	getchar();
	for (j = 0; j < n; j++)
	{
		gets(s);
		for (i = 0; s[i] != NULL; i++)
		{
			i1 = i;
			for (c = 0, i1; s[i] != ' '; c++, i1++)
			{
				counter[c]++;
				character[i] = s[i];
			}
			for (i1, c = 0;; i++, c++)
			{
				if (counter[c] > bigCount)
				{
					bigCount = counter[c];
					bigChar[c] = character[i1];
				}
			}
		}
	}
	for (j = 0; j<n; j++)
		for(i=0;;i++)
		printf("%d %d\n",bigChar[i],bigCount );
	return 0;
}