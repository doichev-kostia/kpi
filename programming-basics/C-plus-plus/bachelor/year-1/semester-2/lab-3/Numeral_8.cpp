#include "Numeral_8.h"

using namespace std;

Numeral_8::Numeral_8(int number) {
    this->number = number;
}

Numeral_8::Numeral_8(std::string number) {
    this->number = stoi(number);
}

Numeral_8::Numeral_8(int number, int base) {
    if (base == 8) {
        this->number = number;
    } else {
        this->number = Numeral_8::convertDecimalToOctal(number);
    }
}

int Numeral_8::getNumber() {
    return this->number;
}

int Numeral_8::getDecimal() {
    int decimal = 0;
    int octal = this->number;
    int octalLength = (int) log10(octal) + 1;
    /**
     * Convert the whole part of the octalWhole number to decimal
     */
    for (int i = 0; i < octalLength; i++) {
        decimal += (int) pow(8, i) * (octal % 10);
        octal /= 10;
    }
    cout << this->number << " (base 8) = " << decimal << " (base 10)" << endl;
    return decimal;
}

int Numeral_8::convertDecimalToOctal(int decimal) {
    int decimalMutable = decimal;
    int remainder;
    int octal = 0;
    int decimalPlace = 1;

    while (decimalMutable != 0) {
        remainder = decimalMutable % 8;
        decimalMutable = decimalMutable / 8;
        octal = octal + (remainder * decimalPlace);
        decimalPlace *= 10;
    }

    cout << decimal << " (base 10) = " << octal << " (base 8)" << endl;
    return octal;
}

Numeral_8 *Numeral_8::operator++() {
    int decimal = this->getDecimal();
    decimal++;
    this->number = Numeral_8::convertDecimalToOctal(decimal);
    return this;
}

Numeral_8 *Numeral_8::operator+=(int number) {
    int decimal = this->getDecimal();
    decimal += number;
    this->number = Numeral_8::convertDecimalToOctal(decimal);
    return this;
}

Numeral_8 *Numeral_8::operator+=(Numeral_8 n) {
    int decimal = this->getDecimal() + n.getDecimal();
    this->number = Numeral_8::convertDecimalToOctal(decimal);
    return this;
}

Numeral_8 Numeral_8::operator+(Numeral_8 number) {
    int decimal = this->getDecimal();
    decimal += number.getDecimal();
    return Numeral_8(decimal, 10);
}