#include <iostream>
#include <cstdlib>
#include <ctime>
#include <iomanip>

using namespace std;

int randomize(int min, int max);

int arrayCallback(int item, int index);

template<typename T>
void fill(T array[], int length, T(*callback)(T, int));

template<typename T>
void swapElements(T &a, T &b);

void fillArrayD(int arrayD[], const int arrayA[], const int arrayC[], int length);

const int MIN_VALUE = -1000;
const int MAX_VALUE = 1000;

int main() {
    srand(time(NULL));

    const int LENGTH = 10;
    int arrayA[LENGTH] = {};
    int arrayC[LENGTH] = {};
    int arrayD[LENGTH] = {};

    fill(arrayA, LENGTH, arrayCallback);
    fill(arrayC, LENGTH, arrayCallback);

    fillArrayD(arrayD, arrayA, arrayC, LENGTH);

    int min = arrayD[0];

    for (int i: arrayD) {
        if (i < min) {
            min = i;
        }
    }

    int lastElem = arrayD[LENGTH - 1];


    cout << "Min: " << setw(5) << min << " | Last: " << setw(5) << lastElem << endl;
    swapElements(min, lastElem);
    cout << "Min: " << setw(5) << min << " | Last: " << setw(5) << lastElem << endl;

    return 0;
}

/**
 * @param  min - min value
 * @param  max  - max value
 * @return random value
 */
int randomize(int min, int max) {
    return (rand() % (max - min + 1) + min);
}

/**
 * This function fills the initial array with the return value of callbacks
 * @tparam T
 * @param array
 * @param callback
 * @return
 */
template<typename T>
void fill(T array[], int length, T(*callback)(T, int)) {
    for (int i = 0; i < length; i++) {
        array[i] = callback(array[i], i);
    }
}

int arrayCallback(int item, int index) {
    return randomize(MIN_VALUE, MAX_VALUE);
}

/**
 * This function swap two values
 * @tparam T
 * @param a - first value
 * @param b - second value
 */
template<typename T>
void swapElements(T &a, T &b) {
    T tmp = a;
    a = b;
    b = tmp;
}

void fillArrayD(int arrayD[], const int arrayA[], const int arrayC[], int length) {
    for (int i = 0; i < length; i++) {
        int arrayAElem = arrayA[i];
        int arrayCElem = arrayC[i];
        int value;
        if (arrayAElem > arrayCElem) {
            value = arrayAElem;
        } else if (arrayAElem < arrayCElem) {
            value = arrayCElem;
        } else {
            value = 0;
        }

        arrayD[i] = value;
    }
}