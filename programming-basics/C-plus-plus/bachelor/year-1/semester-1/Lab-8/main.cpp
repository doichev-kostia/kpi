#include <iostream>
#include <ctime>
#include <cstdlib>
#include <iomanip>
#include <string>

const int SIZE = 5;
const int MIN_VALUE = -1000;
const int MAX_VALUE = 1000;

typedef int Matrix[SIZE][SIZE];

using namespace std;

template<typename T>
void swapElements(T &a, T &b);

int randomizeValue(int min, int max);

void fillMatrix(Matrix matrix, int (*callback)(int, int, int));

int fillMatrixA(int item, int row, int column);

void fillMatrixB(Matrix matrixA, Matrix matrixB, int size);

void swapMatrixElements(Matrix matrix, int size);

void swapRowElements(int row[], int size, int index);

int findMiddleElement(Matrix matrix);

void printMatrix(string name, Matrix matrix, int rows, int columns);

string generateMatrixRow(int width, int columns, string content);

int main() {
    srand(time(NULL));

    Matrix A;
    Matrix B;

    fillMatrix(A, fillMatrixA);

    fillMatrixB(A, B, SIZE);
    int middleElement = findMiddleElement(A);
    cout << "Middle element: " << middleElement << endl;

    printMatrix("Matrix A", A, SIZE, SIZE);
    printMatrix("Matrix B", B, SIZE, SIZE);
    return 0;
}

int randomizeValue(int min, int max) {
    return (rand() % (max - min + 1) + min);
}

void fillMatrix(Matrix matrix, int (*callback)(int, int, int)) {
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            matrix[i][j] = callback(matrix[i][j], i, j);
        }
    }
}

int fillMatrixA(int item, int row, int column) {
    return randomizeValue(MIN_VALUE, MAX_VALUE);
}

void fillMatrixB(Matrix matrixA, Matrix matrixB, int size) {
    if (size % 2 == 0) {
        cout << "Matrix size value should be an odd number" << endl;
        return;
    }

    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            matrixB[i][j] = matrixA[i][j];
        }
    }

    swapMatrixElements(matrixB, size);
}

void swapMatrixElements(Matrix matrix, int size) {
    int middle = size / 2;
    for (int i = 0; i < size; i++) {
        if (i < middle) {
            for (int j = 0; j <= i; j++) {
                swapRowElements(matrix[i], size, j);
            }
        } else if (i >= middle) {
            for (int j = middle; j < size; j++) {
                swapRowElements(matrix[i], size, j);
            }
        }
    }
}

void swapRowElements(int row[], int size, int index) {
    int symmetricalIndex = size - index - 1;
    swapElements(row[index], row[symmetricalIndex]);
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

int findMiddleElement(Matrix matrix) {
    int middleIndex = (SIZE / 2);
    for (int i = 0; i < SIZE; i++) {
        for (int j = 0; j < SIZE; j++) {
            if (i == middleIndex && j == middleIndex) {
                return matrix[i][j];
            }
        }
    }
}

void printMatrix(string name, Matrix matrix, int rows, int columns) {
    cout << name << ": " << endl;
    const int CELL_WIDTH = 6;
    cout << generateMatrixRow(CELL_WIDTH, columns, "-") << endl;
    for (int i = 0; i < rows; i++) {
        cout << "|";
        for (int j = 0; j < columns; j++) {
            cout << setw(6) << matrix[i][j] << "|";
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
