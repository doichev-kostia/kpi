#define _USE_MATH_DEFINES
#include <iostream>
#include <cmath>

double calculateNegativeArithmeticSum(double initialValue, double step, double finalValue, double sum);

using namespace std;

int main() {
    double initialValue = 3 * M_PI;
    double step = M_PI_2;
    double finalValue = -4 * M_PI;
    double sum = 0;
    sum = calculateNegativeArithmeticSum(initialValue, step, finalValue, sum);
    cout << "Sum: " <<  sum << endl;
    return 0;
}

double calculateNegativeArithmeticSum(double initialValue, double step, double finalValue, double sum) {
    if (initialValue == finalValue) {
        sum = initialValue;
    } else {
        sum = initialValue + calculateNegativeArithmeticSum(initialValue - step, step, finalValue, sum);
    }
    return sum;
}
