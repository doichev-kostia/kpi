//
// Created by Kostia  on 21.12.2021.
//

#ifndef LAB_9_MATRIX_OUTPUT_H
#define LAB_9_MATRIX_OUTPUT_H
#include <iostream>
#include <iomanip>

#endif //LAB_9_MATRIX_OUTPUT_H

template<typename T, size_t rows, size_t columns>
void printMatrix(T (&matrix)[rows][columns]);

std::string generateMatrixRow(int width, int columns, std::string content);
