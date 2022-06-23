#include "Node.h"

Node::Node(int d): data(d), left(nullptr), right(nullptr) {};

Node* Node::getLeft() {
    return left;
}

Node* Node::getRight() {
    return right;
}

int Node::getData() {
    return data;
}

void Node::setLeft(Node* node) {
    left = node;
}

void Node::setRight(Node* node) {
    right = node;
}

