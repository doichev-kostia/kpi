//
// Created by Kostia  on 21.12.2021.
//
#include <cstdlib>
#include "utils.h"

/**
 * This function generates a random number between min and max value
 * @param min - min value
 * @param max - max value
 * @return
 */
int randomizeValue(int min, int max){
    return rand() % (max - min + 1) + min;
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
