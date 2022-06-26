#include "LinearEquation.h"

LinearEquation::LinearEquation() {
    this->numberOfCoefficients = 2;
};

LinearEquation::LinearEquation(std::vector<double> coeffs) : TEquation(coeffs, 2) {
    this->numberOfCoefficients = 2;
    this->findRoots();
};

std::vector<double> LinearEquation::findRoots() {
    auto coeffs = this->getCoefficients();
    double a = coeffs[0];
    double b = coeffs[1];
    std::vector<double> root = {-b / a};
    this->roots = root;
    return this->roots;
}

std::vector<LinearEquation> LinearEquation::generateRandomEquation(int minCoeff, int maxCoeff, int numberOfInstances) {
    std::vector<LinearEquation> equations;
    int numberOfCoefficients = 2;
    for (int i = 0; i < numberOfInstances; i++) {
        try {
            std::vector<double> coefficients;
            for (int j = 0; j < numberOfCoefficients; j++) {
                coefficients.push_back((rand() % (maxCoeff - minCoeff + 1) + minCoeff));
            }
            auto eq = LinearEquation(coefficients);
            equations.push_back(eq);
        } catch (const char *msg) {
            std::cout << msg << std::endl;
        }
    }

    return equations;
}


