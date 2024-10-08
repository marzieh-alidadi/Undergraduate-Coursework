#include<iostream>
using namespace std;

class Tree
{
private:
	int *data;
	int hole;
	int cur;
public:
	Tree(int a);
	void setCur();
	void setZero();
	void insert(int x);
	int min();
};

Tree::Tree(int a)
{
	int n = 0;
	for (;;)
	{
		n += a;
		if (a == 1)
			break;
		a = (a + 1) / 2;
	}
	data = new int[n];
	cur = n - 1;
	hole = n - 1;
	int i = 0;
	for (i; i < n; i++)
		data[i] = 0;
}
void Tree::setCur()
{
	cur = hole;
}

void Tree::insert(int x)
{
	data[cur] = x;
	cur--;
}

void Tree::setZero()
{
	int i;
	for (i = 0; i<=hole; i++)
		data[i] = 0;
}


int Tree::min()
{
	int i, j;
	for (i = hole;; i = i - 2)
	{

		j = (i - 1) / 2;
		if (i > 0)
		{
			if (data[i] == 0 && data[i - 1] == 0)
				continue;
			else if (data[i] == 0)
				data[j] = data[i - 1];
			else if (data[i - 1] == 0)
				data[j] = data[i];
			else if (data[i] <= data[i - 1])
			{
				data[j] = data[i];
			}
			else if (data[i] > data[i - 1])
			{
				data[j] = data[i - 1];
			}
		}
		if (j == 0 )
			break;
	}
	return data[0];
}

int main()
{
	int a, **m, i = 0, j = 0, x, daste = 0;
	long int b;
	cin >> a >> b;
	m = new int*[a];
	Tree t(a);
	for (i = 0; i < a; i++)
	{
		m[i] = new int[10000];

		for (j = 0; j<10000; j++)
			m[i][j] = 0;
	}
	for (i = 0; i<a; i++)
	{
		for (j = 0; j<10000; j++)
		{
			cin >> x;
			if (x == 0)
				break;
			m[i][j] = x;
		}
		daste++;
		if (daste == a)
			break;
	}
	long int counter = 0;
	int data;
	while (1)
	{
		int r = 0;
		for (i = 0; i<a; i++)
		{

			for (j = 0; j<10000; j++)
			{
				if (m[i][j] == 0)
					continue;
				if (m[i][j] != 0)
				{
					t.insert(m[i][j]);
					//m[i][j] = 0;
					break;
				}
			}
			r++;
			if (r == daste)
				break;
		}
		counter++;
		data = t.min();
		int flag = 0;
		for (i = 0;; i++)
		{
			for (j = 0;; j++)
			{
				if (m[i][j] == data)
				{
					m[i][j] = 0;
					flag = 1;
					break;
				}
			}
			if (flag == 1)
				break;
		}
		t.setCur();
		t.setZero();
		if (counter == b)
		{
			cout << data;
			break;
		}
	}
	return 0;
}