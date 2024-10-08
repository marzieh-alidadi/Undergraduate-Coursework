#include<iostream>
using namespace std;

int main()
{
	int n, a[100000],m=0;
	for (int i = 0; i < 100000; i++)
		a[i] = 0;
	cin >> n;
	for (int i = 1; i <= n; i++)
		a[i] = 1;
	int x, y;
	for (int i=0;cin >> x >> y && (x || y);i++)
	{
		if (a[x] == 0 && a[y]==1)
		{
			a[y] = 0;
			n--;
		}
		else if (a[x] == 1 && a[y] == 0)
		{
			a[x] = 0;
			n--;
		}
		else if (a[x] == 1 || a[y] == 1)
		{
			a[x] = 0;
			a[y] = 0;
			n=n-2;
			m++;
		}
	}
	cout << (m + n);

	return 0;
}