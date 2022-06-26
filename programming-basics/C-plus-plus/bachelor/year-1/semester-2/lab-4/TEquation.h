#ifndef LAB_4_TEQUATION_H
#define LAB_4_TEQUATION_H

#include <iostream>
#include <vector>

class TEquation {
public:
    TEquation();
    TEquation(std::vector<double> coefficients, int coeffsNum);
    std::vector<double> getCoefficients();
    virtual std::vector<double> findRoots();
    std::vector<double> getRoots();
    int getNumberOfCoefficients();
    bool isRoot(double root);
    double calculateRootsSum();
    void print();
protected:
    std::vector<double> roots;
    int numberOfCoefficients{0};
    bool areCoefficientsValid(std::vector<double> coefficients);
    bool areCoefficientsValid(std::vector<double> coeffs, int coeffsNum);
private:
    std::vector<double> coefficients;

};


#endif //LAB_4_TEQUATION_H
