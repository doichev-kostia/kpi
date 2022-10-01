#include <iostream>
#include <cmath>
#include <iomanip>

double calc(double m, double x);

const double MIN_VALUE = -0.8;
const int MAX_VALUE = 10;
const double STEP = 0.25;

using namespace std;

int main() {
    int elements = (int) ((float) (abs(MAX_VALUE) + abs(MIN_VALUE)) / STEP) + 1;

    int a, b;

    cout << "A: ";
    cin >> a;

    cout << "B: ";
    cin >> b;

    double result[44] = {};
    double xArray[44] = {};


    for (int i = 0; i < elements; i++) {
        if (i == 0) {
            xArray[i] = MIN_VALUE;
        } else {
            xArray[i] = xArray[i - 1] + STEP;
        }
    }

    for(int i = 0; i < elements; i++){
        double m = 0;
        double x = xArray[i];
        if (0 < x && x < 5.5){
            m = a + b * x;
        } else if (6.0 < x && x <= 7.0){
            m = log(x);
        } else if (x < 0 || x == 10.0){
            m = a - b * x;
        } else {
            m = a * b * x;
        }
        result[i] = calc(m, x);
    }

    for (int i = 0; i < 44; i++) {
        cout << setw(4) << "P: " << setw(4) << result[i] << endl;
    }


    return 0;
}

double calc(double m, double x) {
    return m * x;
}
