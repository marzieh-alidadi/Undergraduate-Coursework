#include<stdio.h>
int main()
{
	int n, i, j, c, counter[1000] = { 0 }, flag;
	char s[400];
	scanf("%d", &n);
	getchar();
	for (j = 0; j<n; j++)
	{
		gets(s);
		flag = 1;
		for (i = 0; flag == 1; i++)
			if (s[i] == NULL)
			{
				flag = 0;
				for (i - 1; s[i - 1] != ' ' && i >= 1; i--)
					if (s[i - 1] != '.' && s[i - 1] != ',' && s[i - 1] != ':' && s[i - 1] != '!' && s[i - 1] != '?')
					{
						counter[j]++;
						break;
					}
			}
			else if (s[i] == ' ')
				for (c = i - 1; s[c] != ' ' && c >= 0; c--)
				{
					if (s[c] != '.' && s[c] != ',' && s[c] != ':' && s[c] != '!' && s[c] != '?')
					{
						counter[j]++;
						break;
					}
				}
	}
	for (j = 0; j<n; j++)
		printf("%d\n", counter[j]);
	return 0;
}