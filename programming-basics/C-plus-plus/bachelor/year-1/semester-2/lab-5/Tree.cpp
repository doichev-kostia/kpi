#include "Tree.h"

using namespace std;

Tree::Tree(int data) {
    this->root = new Node(data);
    this->build(this->root, data - 1);
}

void Tree::build(Node *node, int data) {
    node->setLeft(new Node(data));
    node->setRight(new Node(data));

    if (data == 1) {
        return;
    }

    this->build(node->getLeft(), data - 1);
    this->build(node->getRight(), data - 1);
}

Node *Tree::getRoot() {
    return this->root;
}

void Tree::print(const string &prefix, Node *node, bool isLeftBranch) {
    if (node == nullptr) {
        return;
    }

    cout << prefix;
    cout << (isLeftBranch ? "├──" : "└──");

    cout << node->getData() << endl;
    string newPrefix = prefix + (isLeftBranch ? "│   " : "    ");
    this->print(BLUE + newPrefix, node->getLeft(), true);
    this->print(YELLOW + newPrefix, node->getRight(), false);
}

ostream &operator<<(ostream &os, Tree &tree) {
    tree.print("", tree.getRoot(), false);
    return os;
}