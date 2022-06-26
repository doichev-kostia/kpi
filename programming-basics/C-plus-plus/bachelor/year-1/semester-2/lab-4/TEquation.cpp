#include "TEquation.h"

TEquation::TEquation(): coefficients(std::vector<double>()) {}

TEquation::TEquation(std::vector<double> coeff, int coeffsNum) {
    if (this->areCoefficientsValid(coeff, coeffsNum)) {
        this->coefficients = coeff;
    } else {
        throw "Invalid coefficients";
    }
}

bool TEquation::areCoefficientsValid(std::vector<double> coeffs) {
    bool isValidLength = coeffs.size() == this->getNumberOfCoefficients();
    return isValidLength && coefficients[0] != 0;
}

bool TEquation::areCoefficientsValid(std::vector<double> coeffs, int coeffsNum) {
    bool isFirstValid = coeffs[0] != 0;
    bool isValidLength = coeffs.size() == coeffsNum;
    return isValidLength && isFirstValid;
}

std::vector<double> TEquation::findRoots() {
    return std::vector<double>();
}

std::vector<double> TEquation::getRoots() {
    return this->roots;
}

std::vector<double> TEquation::getCoefficients() {
    return this->coefficients;
}

int TEquation::getNumberOfCoefficients() {
    return this->numberOfCoefficients;
}

bool TEquation::isRoot(double root) {
    if (this->roots.size() == 0) {
        return false;
    }

    for (auto r : this->roots) {
        if (r == root) {
            return true;
        }
    }
    return false;
}

double TEquation::calculateRootsSum() {
    double sum = 0;
    for (auto r : this->roots) {
        sum += r;
    }
    return sum;
}

void TEquation::print() {
    std::cout << "Coefficients: [";
    for (auto c: this->coefficients) {
        std::cout << c << " ";
    }
    std::cout << "]" << std::endl;

    std::cout << "Roots: [";
    for (auto r: this->roots) {
        std::cout << r << " ";
    }
    std::cout << "]" << std::endl;
};
