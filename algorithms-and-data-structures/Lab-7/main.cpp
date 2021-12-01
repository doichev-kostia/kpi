#include <iostream>

void forEach(char array[], int (*callback)(int, int));

char *filter(char array[], bool (*callback)(int, int));

int calcFirstArray(int item, int index);

int calcSecondArray(int item, int index);

bool filterThirdArray(int item, int index);

using namespace std;

const int ARRAY_LENGTH = 10;
const int MIN_COMMON_VALUE = 101;

int main() {
    char array1[ARRAY_LENGTH] = {};
    char array2[ARRAY_LENGTH] = {};
    char array3[ARRAY_LENGTH] = {};
    int filledIndex = 0;

    forEach(array1, calcFirstArray);
    forEach(array2, calcSecondArray);

    for (int i = 0; i < ARRAY_LENGTH; i++) {
        for (int j = 0; j < ARRAY_LENGTH; j++) {
            if ((int) array1[i] == (int) array2[j]) {
                array3[filledIndex] = array1[i];
                filledIndex++;
            }
        }
    }

    char *filteredArray = filter(array3, filterThirdArray);
    int sum = 0;
    for (int i = 0; i < ARRAY_LENGTH; i++) {
        sum += (int) filteredArray[i];
    }

    cout << "The sum is: " << sum << endl;

    return 0;
}

void forEach(char array[], int (*callback)(int, int)) {
    for (int i = 0; i < ARRAY_LENGTH; i++) {
        array[i] = (char) callback( (int) array[i], i);
    }
}

char *filter(char array[], bool (*callback)(int, int)) {
    char newArray[ARRAY_LENGTH] = {};
    int filledIndex = 0;
    for (int i = 0; i < ARRAY_LENGTH; i++) {
        bool res = callback( (int) array[i], i);
        if (res) {
            newArray[filledIndex] = array[i];
            filledIndex++;
        }
    }
    return newArray;
}

int calcFirstArray(int item, int index) {
    return 95 + index;
}

int calcSecondArray(int item, int index) {
    return 105 - index;
}

bool filterThirdArray(int item, int index) {
    return item > MIN_COMMON_VALUE;
}
