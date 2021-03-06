#include <iostream>
#include <iomanip>
#include <cstdlib>
#include <ctime>
#include <cmath>

using namespace std;
const int ROWS = 6;
const int COLUMNS = 4;
const int MIN_VALUE = -100;
const int MAX_VALUE = 100;
typedef int Matrix[ROWS][COLUMNS];

int randomizeValue(int min, int max);

void fillMatrix(Matrix matrix, int (*callback)(int));

int fillMatrixCallback(int item);

void fillArray(int array[], Matrix matrix);

void insertionSort(int array[], int length);

template<typename T>
void printArray(T array[], int size);

string generateMatrixRow(int width, int columns, string content);

void printMatrix(Matrix matrix, int columns, int rows);


int main() {
    srand(time(NULL));

    Matrix matrix;
    int result[ROWS];

    fillMatrix(matrix, fillMatrixCallback);
    fillArray(result, matrix);
    size_t size = sizeof(result) / sizeof(result[0]);
    printArray(result, size);
    insertionSort(result, (int) size);

    cout << "Matrix: " << endl;
    printMatrix(matrix, COLUMNS, ROWS);
    printArray(result, size);
    return 0;
}

int randomizeValue(int min, int max) {
    return (rand() % (max - min + 1) + min);
}


void fillMatrix(Matrix matrix, int (*callback)(int)) {
    for (int i = 0; i < ROWS; i++) {
        for (int j = 0; j < COLUMNS; j++) {
            matrix[i][j] = callback(matrix[i][j]);
        }
    }
}

void fillArray(int array[], Matrix matrix) {
    for (int i = 0; i < ROWS; i++) {
        int max = matrix[i][0];
        for (int j = 0; j < COLUMNS; j++) {
            if (matrix[i][j] > max) {
                max = matrix[i][j];
            }
        }
        array[i] = max;
    }
}

void insertionSort(int array[], int length) {
    int i, j, currentValue;
    for (i = 0; i < length; i++) {
        currentValue = array[i];
        j = i - 1;
        while (j >= 0 && array[j] < currentValue) {
            array[j + 1] = array[j];
            j--;
        }
        array[j + 1] = currentValue;
    }
}

int fillMatrixCallback(int item) {
    return randomizeValue(MIN_VALUE, MAX_VALUE);
}

template<typename T>
void printArray(T *array, int size) {
    int maxValueLength = (int) log10(MAX_VALUE) + 1;
    int minValueLength = (int) log10(MAX_VALUE) + 1;
    int longest = maxValueLength > minValueLength ? maxValueLength : minValueLength;

    cout << "Result: [";
    for (int i = 0; i < size; i++) {
        bool isLast = i + 1 == size;
        string separator = isLast ? "" : ", ";
        cout << setw(longest + 1) << array[i] << separator;
    }
    cout << "]" << endl;
}

void printMatrix(Matrix matrix, int columns, int rows) {
    int maxValueLength = (int) log10(MAX_VALUE) + 1;
    int minValueLength = (int) log10(MAX_VALUE) + 1;
    int longest = maxValueLength > minValueLength ? maxValueLength : minValueLength;

    const int CELL_WIDTH = longest + 1;
    cout << generateMatrixRow(CELL_WIDTH, columns, "-") << endl;
    for (int i = 0; i < rows; i++) {
        cout << "|";
        for (int j = 0; j < columns; j++) {
            cout << setw(CELL_WIDTH) << matrix[i][j] << "|";
        }
        cout << endl;
        cout << generateMatrixRow(CELL_WIDTH, columns, "-") << endl;
    }
}

string generateMatrixRow(int width, int columns, string content) {
    string res = "|";
    for (int i = 0; i < columns; i++) {
        for (int j = 0; j < width; j++) {
            res += content;
        }
        res += "|";
    }
    return res;
}

