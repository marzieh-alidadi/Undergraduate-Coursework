#include<iostream>
using namespace std;

static int i, j;

class Queue;

class QueueNode
{
	friend class Queue;
private:
	int data1;
	int data2;
	QueueNode *link;
	QueueNode(int d1 = 0,int d2=0, QueueNode *l = 0) :data1(d1), data2(d2), link(l) {};
};

class Queue
{
public:
	Queue() { front = rear = 0; }
	bool add(const int,const int);
	void remove();
	QueueNode* getFront() { return front; }
private:
	QueueNode *rear;
	QueueNode *front;
};

bool Queue::add(const int x, const int y)
{
	if (front == 0)
	{
		front = rear = new QueueNode(x, y, front);
		j = 0;
		return true;
	}
	else
	{
		if ((front->data1 == y))
		{
			QueueNode *n = front;
			front = new QueueNode(x, y, n);
			rear->link = front;
			j = i;
			return true;
		}
		if ((this->rear->data2) == x)
		{
			rear = rear->link = new QueueNode(x, y, front);
			return true;
		}
		else
			return false;
	}
}

void Queue::remove()
{
	if (front == 0);
	QueueNode *x = front;
	front = x->link;
	delete x;
}

int main()
{
	int n,a[2],flag=0;
	cin >> n;
	Queue q;
	for ( i; i < n; i++)
	{
		cin >> a[0] >> a[1];
		if (!q.add(a[0], a[1]))
		{
			flag = 1;
			cout << "There's no way the probe could make this trip!";
				break;
		}
	}
	if (flag == 0)
	{
		cout << "You should start at " << j << "!";
	}

	return 0;
}