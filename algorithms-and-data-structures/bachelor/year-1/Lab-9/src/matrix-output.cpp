//
// Created by Kostia  on 21.12.2021.
//

#include "matrix-output.h"

/**
 *
 * @tparam T
 * @tparam rows - matrix row length
 * @tparam columns - matrix column length
 * @param matrix
 */
template<typename T, size_t rows, size_t columns>
void printMatrix(T (&matrix)[rows][columns]) {
    const int CELL_WIDTH = 6;
    std::cout << generateMatrixRow(CELL_WIDTH, columns, "-") << std::endl;
    for (int i = 0; i < rows; i++) {
        std::cout << "|";
        for (int j = 0; j < columns; j++) {
            std::cout << std::setw(6) << matrix[i][j] << "|";
        }
        std::cout << std::endl;
        std::cout << generateMatrixRow(CELL_WIDTH, columns, "-") << std::endl;
    }
}

/**
 *
 * @param width - cell width
 * @param columns - number of columns
 * @param content - character that should be displayed
 * @return divider
 */
std::string generateMatrixRow(int width, int columns, std::string content) {
    std::string res = "|";
    for (int i = 0; i < columns; i++) {
        for (int j = 0; j < width; j++) {
            res += content;
        }
        res += "|";
    }
    return res;
}