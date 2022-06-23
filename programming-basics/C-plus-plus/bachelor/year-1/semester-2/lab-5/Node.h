#ifndef LAB_5_NODE_H
#define LAB_5_NODE_H

class Node {
private:
    Node* left;
    Node* right;
    int data;
public:
    Node(int d);
    Node* getLeft();
    Node* getRight();
    int getData();
    void setLeft(Node* node);
    void setRight(Node* node);
};


#endif //LAB_5_NODE_H
