#include<iostream>
using namespace std;
#include<vector>

struct Skip_Node {
	int key;
	string value;
	vector<Skip_Node*> forward;
	Skip_Node(int k, const string& v, int level);
};

class Skip_list {
public:
	Skip_list();
	~Skip_list();
	Skip_Node* find(int searchKey);
	void insert(int searchKey, string newValue);
	void erase(int searchKey);
private:
	Skip_Node* head;
	Skip_Node* NIL;
	int randomLevel();
	int nodeLevel(const vector<Skip_Node*>& v);
	Skip_Node* makeNode(int key, string val, int level);
	float probability;
	int maxLevel;
};

Skip_Node::Skip_Node(int k, const string& v, int level)
	: key(k), value(v)
{
	for (int i = 0; i < level; ++i) forward.emplace_back(nullptr);
}

Skip_list::Skip_list()
	: probability(0.5), maxLevel(16)
{
	int headKey = std::numeric_limits<int>::min();
	head = new Skip_Node(headKey, "head", maxLevel);
	int nilKey = std::numeric_limits<int>::max();
	NIL = new Skip_Node(nilKey, "NIL", maxLevel);
	for (size_t i = 0; i < head->forward.size(); ++i) {
		head->forward[i] = NIL;
	}
}

Skip_list::~Skip_list() {
	delete head;
	delete NIL;
}

int Skip_list::randomLevel() {
	int v = 1;

	while ((((double)std::rand() / RAND_MAX)) < probability &&
		std::abs(v) < maxLevel) {

		v += 1;
	}
	return abs(v);
}

int Skip_list::nodeLevel(const std::vector<Skip_Node*>& v) {
	int currentLevel = 1;
	int nilKey = std::numeric_limits<int>::max();

	if (v[0]->key == nilKey) {
		return currentLevel;
	}

	for (size_t i = 0; i < v.size(); ++i) {

		if (v[i] != nullptr && v[i]->key != nilKey) {
			++currentLevel;
		}
		else {
			break;
		}
	}
	return currentLevel;
}


Skip_Node* Skip_list::find(int searchKey) {
	Skip_Node* x = head;
	unsigned int currentMaximum = nodeLevel(head->forward);

	for (unsigned int i = currentMaximum; i-- > 0;) {
		while (x->forward[i] != nullptr && x->forward[i]->key < searchKey) {
			x = x->forward[i];
		}
	}
	x = x->forward[0];

	if (x->key == searchKey) {
		return x;
	}
	else {
		return nullptr;
	}
}

Skip_Node* Skip_list::makeNode(int key, std::string val, int level) {
	return new Skip_Node(key, val, level);
}

void Skip_list::insert(int searchKey, std::string newValue) {
	Skip_Node* x = nullptr;
	x = find(searchKey);
	if (x) {
		x->value = newValue;
		return;
	}

	std::vector<Skip_Node*> update(head->forward);
	unsigned int currentMaximum = nodeLevel(head->forward);
	x = head;

	for (unsigned int i = currentMaximum; i-- > 0;) {

		while (x->forward[i] != nullptr && x->forward[i]->key < searchKey) {

			x = x->forward[i];
		}
		update[i] = x;
	}
	x = x->forward[0];
	int newNodeLevel = 1;
	if (x->key != searchKey) {

		newNodeLevel = randomLevel();
		int currentLevel = nodeLevel(update);

		if (newNodeLevel > currentLevel) {

			for (int i = currentLevel + 1; i < newNodeLevel; ++i) {

				update[i] = head;
			}
		}
		x = makeNode(searchKey, newValue, newNodeLevel);
	}
	for (int i = 0; i < newNodeLevel; ++i) {

		x->forward[i] = update[i]->forward[i];
		update[i]->forward[i] = x;
	}
}

void Skip_list::erase(int searchKey) {
	std::vector<Skip_Node*> update(head->forward);
	Skip_Node* x = head;
	unsigned int currentMaximum = nodeLevel(head->forward);
	for (unsigned int i = currentMaximum; i-- > 0;) {

		while (x->forward[i] != nullptr && x->forward[i]->key < searchKey) {

			x = x->forward[i];
		}
		update[i] = x;
	}
	x = x->forward[0];
	if (x->key == searchKey) {
		for (size_t i = 0; i < update.size(); ++i) {

			if (update[i]->forward[i] != x) {

				break;
			}
			update[i]->forward[i] = x->forward[i];
		}
		delete x;
	}
}



int main()
{
//
	return 0;
}