#include <iostream>

using namespace std;

int main() {
    int n;
    cout << "n: ";
    cin >> n;

    for (int i = 2; i < n; i++) {
        bool haveSameDivisor = false;
        bool haveDifferentDivisor = false;
        for (int j = 2; j <= i; j++) {
            if (i % j == 0) {
                if (n % j == 0 ) {
                    haveSameDivisor = true;
                } else {
                    haveDifferentDivisor = true;
                }
            }
        }

        if (!haveSameDivisor && haveDifferentDivisor){
            cout << i << endl;
        }
    }

    return 0;
}
