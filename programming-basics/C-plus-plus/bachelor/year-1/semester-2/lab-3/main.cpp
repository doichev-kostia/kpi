#include <iostream>
#include "Numeral_8.h"

using namespace std;

int main() {
    int assignmentNumber = 0;
    cout << "Enter assignment number in decimal: ";
    cin >> assignmentNumber;

    cout << "INIT" << endl;
    Numeral_8 n1(10);
    Numeral_8 n2("100");
    Numeral_8 n3(10, 10);

    cout << "N1: " << n1.getNumber() << endl;
    cout << "N2: " << n2.getNumber() << endl;
    cout << "N3: " << n3.getNumber() << endl;
    cout << "INIT END\n\n" << endl;

    cout << "INCREMENT" << endl;
    ++n1;
    cout << "Result: " << n1.getNumber() << endl;

    cout << "\n\nADD" << endl;
    n2 += assignmentNumber;
    cout << "Result: " << n2.getNumber() << endl;

    cout << "\n\nADD TWO OCTALS" << endl;
    n3 = n1 + n2;
    cout << "Result: " << n3.getNumber() << endl;

    return 0;
}
