#include <iostream>
#include "Numeral_8.h"

using namespace std;

int main() {
    int assignmentNumber = 0;
    cout << "Enter assignment number: ";
    cin >> assignmentNumber;

    Numeral_8 n1(10);
    Numeral_8 n2("100");
    Numeral_8 n3(10, 10);

    cout << "INIT" << endl;
    cout << n1.getNumber() << endl;
    cout << n2.getNumber() << endl;
    cout << n3.getNumber() << endl;
    cout << "INIT END" << endl;

    ++n1;
    cout << "INCREMENT" << endl;
    cout << n1.getNumber() << endl;

    n2 += assignmentNumber;
    cout << "ADD" << endl;
    cout << n2.getNumber() << endl;

    n3 = n1 + n2;
    cout << "ADD TWO OCTALS" << endl;
    cout << n3.getNumber() << endl;

    return 0;
}
