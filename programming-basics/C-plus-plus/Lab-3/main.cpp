#include <iostream>
#include <cmath>

using namespace std;

unsigned int fact(unsigned int number) {
    if (number <= 1) {
        return 1;
    }

    return number * fact(number - 1);
}

int main() {
    float difference;
    float prevValue;
    float accuracy;
    int sinArgument;
    int iteration = 0;

    cout << "Enter sinus argument: ";
    cin >> sinArgument;

    cout << "Enter accuracy: ";
    cin >> accuracy;

    float sin = sinArgument;

    do {
        prevValue = sin;
        iteration += 1;
        float sinNumerator = pow(-1, iteration) * pow(sinArgument, 2 * iteration + 1);
        sin += (float) sinNumerator / fact(2 * iteration + 1);
        difference = abs(sin - prevValue);
    } while (difference > accuracy);

    cout << "The result is: " << sin << endl;

    return 0;
}
