#include <iostream>

using namespace std;

int main() {
    int n;
    cout << "n: ";
    cin >> n;


    for (int i = 1; i < n; i++) {
        bool haveSameDivisor = false;
        bool haveDifferentDivisor = false;

        // the loop starts from 2 as every number can be divided by 1
        for (int j = 2; j <= i; j++) {
            if (i % j == 0) {
                if (n % j == 0) {
                    haveSameDivisor = true;
                } else {
                    haveDifferentDivisor = true;
                }
            }
        }

        if (!haveSameDivisor && haveDifferentDivisor) {
            cout << i << endl;
            // 1 is co-prime number with any other number
        } else if (i == 1) {
            cout << i << endl;
        }
    }

    return 0;
}
