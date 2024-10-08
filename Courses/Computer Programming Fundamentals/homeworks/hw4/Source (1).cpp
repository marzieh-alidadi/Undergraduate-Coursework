#include<stdio.h>
void sort(long long int *const aptr,long long int n);

int main()
{
	long long int n, i, a[100];
	scanf("%lld", &n);
	if (n == 0)
		return 0;
	for (i = 0; i < n; i++)
	{
		scanf("%lld", &a[i]);
	}

	if (n == 1)
	{
		printf("Numbers are in ascending order\nNumbers are in descending order\n");
		return 0;
	}
	 
	sort(a,n);

	return 0;
}
 
long long int ascending(long long int *aptr,long long int n)
{
	long long int flag,i;
	for (i = 0, aptr; i < n - 1; i++, aptr++)
	{
		if (*(aptr + 1) >= *aptr)
			flag = 1;
		else
		{
			flag = 0;
			return flag;
		}
	}
	return flag;
}

long long int descending(long long int *aptr, long long int n)
{
	long long int flag, i;
	for (i = 0, aptr; i < n - 1; i++, aptr++)
	{
		if (*(aptr + 1) <= *aptr)
			flag = 1;
		else
		{
			flag = 0;
			return flag;
		}
	}

	return flag;
}

long long int sabet(long long int *aptr, long long int n)
{
	long long int flag, i;
	for (i = 0, aptr; i < n - 1; i++, aptr++)
	{
		if (*(aptr + 1) == *aptr)
			flag = 1;
		else
		{
			flag = 0;
			return flag;
		}
	}

	return flag;

}

void change(long long int *aptr1,long long  int *aptr2)
{
	long long int hold;
	hold = *aptr2;
	*aptr2 = *aptr1;
	*aptr1 = hold;
}


void sort(long long int *const aptr,long long int n)
{
	long long int i, flag, j;

	//sabet
	flag = sabet(aptr, n);

	if (flag == 1)
	{
		printf("Numbers are in ascending order\nNumbers are in descending order\n");
		return;
	}
	
	else
	{

		//descending
		flag = descending(aptr, n);


		if (flag == 1)
		{
			printf("Numbers are in descending order\n");
			return;
		}


		else
		{
			//ascending
			flag = ascending(aptr, n);


			if (flag == 1)
			{
				printf("Numbers are in ascending order\n");
				return;
			}

		

			//moratab kardan
			else
			{

				for (j = 0; j < n - 1; j++)
				{
					for (i = 0; i < n - 1; i++)
					{
						if (aptr[i] > aptr[i + 1])
							change(&aptr[i], &aptr[i + 1]);
					}
				}
				for (i = 0; i < n; i++)
				{
					printf("%lld ", aptr[i]);
				}

			}
		}
		
	}//end of else
}//end of fun