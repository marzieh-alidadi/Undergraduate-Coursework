#include<iostream>
using namespace std;

class Queue
{
private:
	int front, rear;
	int *queue;
	int maxSize;
public:
	Queue(int);
	void add(const int item);
	int remove();
	bool isFull();
};

Queue::Queue(int max) :maxSize(max)
{
	queue = new int[maxSize];
	front = rear= - 1;
}

void Queue::add(const int x)
{
	queue[++rear] = x;
}

int Queue::remove()
{
	int x;
	x = queue[++front];
	return x;
}

bool Queue::isFull()
{
	if ((rear-front) == maxSize)return true;
	else return false;
}

int main()


{
	int a;
	cin >> a;
	Queue q(a);
	int b, c[1000],count=0;
	for (int i = 0; i < 1000; i++)
		c[i] = 0;
	while (cin >> b)
	{
		if (c[b] == 0)
		{
			count++;
			if (q.isFull())
			{
				int x;
				x=q.remove();
				c[x]--;
			}
			q.add(b);
			c[b]++;
		}
	}
	cout<<count;
	return 0;
}