/*prefix*/
#include<stdio.h>
#include<stdlib.h>
#include<math.h>
int main()
{
	char s[10000] , c[100], d[100];
	long long int i, j;
	long int a = 1, b = 1, result;
	int flag;
	gets_s(s);
	for (i = 0; s[i] != '\0'; i++)
	{
		if (s[i + 1] == ' ')
		{
			switch (s[i])
			{
			case '-':flag = 1;
				break;
			case '+':flag = 2;
				break;
			case '*':flag = 3;
				break;
			case'/':flag = 4;
				break;
			case'^':flag = 5;
				break;
			default:flag = 0;
				break;
			}
		}
		if(flag)
		{
			for (i = i + 2, j = 0; s[i] != ' ' ; i++, j++)
			{
				c[j] = s[i];
			}

			for (i = i + 1, j = 0; s[i] != ' ' && s[i] != NULL; i++, j++)
			{
				d[j] = s[i];
			}
			a = atol(c);
			b = atol(d);
			switch (flag)
			{
			case 1:result = a - b;
 				break;
			case 2:result = a + b;
				break;
			case 3:result = a*b;
				break;
			case 4:result = a / b;
				break;
			case 5:result = pow(a, b);
				break;
			}
			printf("%ld", result);
		}

	}

}