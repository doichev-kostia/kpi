#include <iostream>
#include "Tree.h"

using namespace std;

int main() {
    int rootNumber = 0;
    bool isValid = false;
    while (!isValid) {
        try {
            cout << "Enter the root number (an integer > 1): ";
            cin >> rootNumber;
            if (rootNumber > 1) {
                isValid = true;
            }
        } catch (exception &e) {
            cout << "Invalid input. Try again." << e.what() << endl;
        }
    }

    cout << "Building the tree... " << endl;

    cout << "Tree: (left branch is blue, right branch is yellow)\n\n" << endl;

    Tree tree(rootNumber);
    cout << tree << endl;


    return 0;
}
