#include <iostream>

using namespace std;

void f1(int n);

void f2(int m);

int main() {
    int i = 0;
    f1(i);
    cout << "i = " << i << endl;
    return 0;
}

void f1(int n) {
    int x = n + 1;
    f2(x);
    cout << "x = " << x << endl;
}

void f2(int m) {
    int y = m + 2;
    cout << "y = " << y << endl;
}