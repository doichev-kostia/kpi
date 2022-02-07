#include <iostream>
#include <cmath>

using namespace std;

unsigned long long int fact(unsigned int number) {
    if (number <= 1) {
        return 1;
    }

    return number * fact(number - 1);
}

int main() {
    long double difference;
    long double prevValue;
    float accuracy;
    float sinArgument;
    int iteration = 0;

    cout << "Enter sinus argument: ";
    cin >> sinArgument;

    cout << "Enter accuracy: ";
    cin >> accuracy;

    long double sin = sinArgument;
    // sinus recursion formula: sin(x) = (-1)**n * x ** 2n + 1 / (2n + 1)!, where n goes from 0 to infinity

    do {
        prevValue = sin;
        iteration += 1;
        long double sinNumerator = pow(-1, iteration) * pow(sinArgument, 2 * iteration + 1);
        sin += (long double) sinNumerator / fact(2 * iteration + 1);
        difference = abs(sin - prevValue);
    } while (difference > accuracy);

    cout << "The result is: " << sin << endl;

    return 0;
}
