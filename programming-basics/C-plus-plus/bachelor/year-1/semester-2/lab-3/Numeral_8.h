#ifndef LAB_3_NUMERAL_8_H
#define LAB_3_NUMERAL_8_H

#include <iostream>
#include <cmath>
#include <string>

class Numeral_8 {
    int number;
public:
    Numeral_8(int);
    Numeral_8(std::string);
    /**
     * @param {int} number
     * @param {8 | 10} base
     */
    Numeral_8(int, int);
    int getNumber();
    int getDecimal();
    static int convertDecimalToOctal(int);


    Numeral_8* operator++();
    Numeral_8* operator+=(int);
    Numeral_8* operator+=(Numeral_8);
    Numeral_8 operator+(Numeral_8);
};


#endif //LAB_3_NUMERAL_8_H
