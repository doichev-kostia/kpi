#include <iostream>
#include <cmath>

#define _USE_MATH_DEFINES

using namespace std;

double calculateStep(double a, double b, int n);

double calculateIntegral(double a, double b, int n);

double calculateArctg(double a, double b, int n);

double calculateSin(double a, double b, int n);

int main() {
    int a, b, n;

    cout << "Enter a: ";
    cin >> a;

    cout << "Enter b: ";
    cin >> b;

    do {
        cout << "Enter natural n: ";
        cin >> n;
    } while (n <= 0);

    double res = calculateIntegral(a, b, n);

    cout << "The result is: " << res << endl;

    return 0;
}

double calculateStep(double a, double b, int n) {
    return (b - a) / n;
}

double calculateIntegral(double a, double b, int n) {
    return calculateArctg(a, b, n) + calculateSin(0, M_PI, n);
}

double calculateArctg(double a, double b, int n) {
    double h = calculateStep(a, b, n);
    double sum = 0;
    for (int i = 1; i <= n - 1; i++) {
        sum += pow(atan(a + i * h), 2);
    }

    double functionSum = pow(atan(a), 2) + pow(atan(b), 2);
    return h * (functionSum / 2 + sum);
}

double calculateSin(double a, double b, int n) {
    double h = calculateStep(a, b, n);
    double sum = 0;
    for (int i = 1; i <= n - 1; i++) {
        double exponent = 10 * (a + i * h);
        sum += sin(pow(M_E, exponent));
    }

    double functionSum = sin(pow(M_E, 10 * a)) + sin(pow(M_E, 10 * b));
    return h * (functionSum / 2 + sum);
}