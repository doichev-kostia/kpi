#include <iostream>
#include <ctime>
#include <cstdlib>
#include <string>
#include "utils.cpp"
#include "matrix-output.cpp"

typedef struct {
    float value;
    int row;
    int column;
} Min;

template<typename T, size_t rows, size_t columns>
void fillMatrix(T (&matrix)[rows][columns], T (*callback)(T));

float fillMatrixCallback(float element);

template<typename T, size_t rows, size_t columns>
void findMinElement(T (&matrix)[rows][columns], Min &minElement);

void defineMinElement(float currentValue, int row, int column, Min &minElement);

int main() {
    srand(time(NULL));

    const int ROWS = 5;
    const int COLUMNS = 4;
    float matrix[ROWS][COLUMNS];

    fillMatrix(matrix, fillMatrixCallback);
    std::cout << "Matrix" << std::endl;
    printMatrix(matrix);

    Min minElement;
    minElement.value = matrix[0][0];
    minElement.row = 0;
    minElement.column = 0;
    findMinElement(matrix, minElement);
    std::cout << "Min element: " << minElement.value << std::endl;
    swapElements(matrix[0][0], matrix[minElement.row][minElement.column]);
    std::cout << "Matrix" << std::endl;
    printMatrix(matrix);

    return 0;
}


/**
 *
 * @tparam T
 * @tparam rows - matrix row length
 * @tparam columns - matrix column length
 * @param matrix
 * @param callback - function that will be called at iteration
 */
template<typename T, size_t rows, size_t columns>
void fillMatrix(T (&matrix)[rows][columns], T (*callback)(T)) {
    for (int row = 0; row < rows; row++) {
        for (int column = 0; column < columns; column++) {
            matrix[row][column] = callback(matrix[row][column]);
        }
    }
}

float fillMatrixCallback(float element) {
    const int MIN_VALUE = -1000;
    const int MAX_VALUE = 1000;
    return randomizeValue(MIN_VALUE, MAX_VALUE) / 10.0;
}

/**
 *
 * @tparam T
 * @tparam rows - matrix row length
 * @tparam columns - matrix column length
 * @param matrix
 * @param minElement - min element structure
 */
template<typename T, size_t rows, size_t columns>
void findMinElement(T (&matrix)[rows][columns], Min &minElement) {
    /**
     * @description if direction is > 0, the algorithm will go from top to bottom
     * else if direction is < 0, the algorithm will go from bottom to top
     */
    int direction = 1;
    for (int column = 0; column < columns; column++) {
        if (direction > 0) {
            for (int row = 0; row < rows; row++) {
                float currentElement = matrix[row][column];
                defineMinElement(currentElement, row, column, minElement);
            }
        } else if (direction < 0) {
            for (int row = rows - 1; row >= 0; row--) {
                float currentElement = matrix[row][column];
                defineMinElement(currentElement, row, column, minElement);
            }
        }
        direction *= -1;
    }
}

void defineMinElement(float currentValue, int row, int column, Min &minElement) {
    if (currentValue <= minElement.value) {
        minElement.value = currentValue;
        minElement.row = row;
        minElement.column = column;
    }
}
