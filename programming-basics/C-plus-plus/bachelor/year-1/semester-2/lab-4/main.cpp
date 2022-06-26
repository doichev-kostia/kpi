#include <iostream>
#include <vector>
#include "LinearEquation.h"
#include "QuadraticEquation.h"

using namespace std;

int main() {
    srand(time(NULL));
    int n, m;
    cout << "Number of linear equations: ";
    cin >> n;

    cout << "Number of quadratic equations: ";
    cin >> m;

    int minCoeff, maxCoeff;

    cout << "Minimal coefficient: ";
    cin >> minCoeff;

    cout << "Maximal coefficient: ";
    cin >> maxCoeff;


    vector<LinearEquation> linearEquations = LinearEquation::generateRandomEquation(minCoeff, maxCoeff, n);
    vector<QuadraticEquation> quadraticEquations = QuadraticEquation::generateRandomEquation(minCoeff, maxCoeff, m);

    for (int i = 0; i < n; i++) {
        cout << "\nLinear equation " << i + 1 << ": " << endl;
        linearEquations[i].print();
    }
    cout << '\n';

    for (int i = 0; i < m; i++) {
        cout << "\nQuadratic equation " << i + 1 << ": " << endl;
        quadraticEquations[i].print();
    }

    double linearSum = 0;
    for (int i = 0; i < linearEquations.size(); ++i) {
        linearSum += linearEquations[i].calculateRootsSum();
    }

    double quadraticSum = 0;
    for (int i = 0; i < quadraticEquations.size(); ++i) {
        quadraticSum += quadraticEquations[i].calculateRootsSum();
    }

    cout << endl;

    cout << "Linear equations sum: " << linearSum << endl;
    cout << "Quadratic equations sum: " << quadraticSum << endl;

    double possibleRoot = 0;
    cout << "Possible root: ";
    cin >> possibleRoot;

    char answer;
    cout << "Check linear equation? (y/n): ";
    cin >> answer;

    bool isLinear = answer == 'y';
    int equationIndex = 0;
    cout << "Equation index: ";
    cin >> equationIndex;

    bool isRootCorrect = false;

    if (isLinear) {
        for (int i = 0; i < linearEquations.size(); ++i) {
            if (i == equationIndex && linearEquations[i].isRoot(possibleRoot)) {
                isRootCorrect = true;
                break;
            }
        }
    } else {
        for (int i = 0; i < quadraticEquations.size(); ++i) {
            if (i == equationIndex && quadraticEquations[i].isRoot(possibleRoot)) {
                isRootCorrect = true;
                break;
            }
        }
    }

    cout << (isRootCorrect ? "Root is correct" : "Root is incorrect") << endl;

    return 0;
}
