#ifndef LAB_5_TREE_H
#define LAB_5_TREE_H

#define YELLOW  "\033[33m"
#define BLUE    "\033[34m"

#include <iostream>
#include <string>
#include "Node.h"

class Tree {
Node* root;
public:
    Tree(int data);
    Node* getRoot();

private:
    void build(Node* node, int data);
    void print(const std::string &prefix, Node* node, bool isLeftBranch);
    friend std::ostream& operator << (std::ostream& os, Tree &tree);
};



#endif //LAB_5_TREE_H
