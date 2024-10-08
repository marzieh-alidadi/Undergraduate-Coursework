#include<iostream>>
using namespace std;


class Tree;
class Node
{
	friend Tree;
private:
	Node *rT;
	Node *lT;
	int data;
public:
	Node();
};

Node::Node()
{
	rT= NULL;
	lT = NULL;
}


class Tree
{
private:
	Node *root;
	//int maxN;
public:
	Tree();
	void writePreOrder(Node *c, int a);
	void writePreOrder(int a);
	void readPostOrder();
	void readPostOrder(Node *c);
};

Tree::Tree()
{
	//maxN = n;
	root = NULL;
}

void Tree::writePreOrder(int a)
{
	writePreOrder(root,a);
}

void Tree::writePreOrder( Node *cN,int a)
{
	if (cN == NULL)
	{
		cN = new Node;
		cN->data = a;
		root = cN;
		return;
	}
	Node *node = new Node;
	node = cN;
	int flag = 1;
	for (; node->data > a;)
	{
		if (node->lT)
			node = node->lT;
		else
		{
			flag = 0;
			break;
		}
	}
	if (flag==0)
	{
		Node *node2 = new Node;
		node2->data = a;
		node->lT = node2;
		return;
	}
	for (; node->data < a;)
	{
		if (node->rT == NULL)
		{
			Node *node2 = new Node;
			node2->data = a;
			node->rT = node2;
			return;
		}
		node = node->rT;
		writePreOrder(node,a);
		//node = node->rT;
		//if(node==NULL)
		return;
	}
	//node = new Node;
	//node->data = a;
	//return;
}

void Tree::readPostOrder()
{
	readPostOrder(root);
}
void Tree::readPostOrder(Node *c)
{
	if (c)
	{
		readPostOrder(c->lT);
		readPostOrder(c->rT);
		cout<<c->data<<endl;
	}
}

int main()
{
	Tree binT;
	int n = 0, a[10000];
	for (n; cin >> a[n]; n++)
	{
		binT.writePreOrder(a[n]);
	}
	binT.readPostOrder();




	return 0;
}