#include "QuadraticEquation.h"

QuadraticEquation::QuadraticEquation() {
    this->numberOfCoefficients = 3;
}

QuadraticEquation::QuadraticEquation(std::vector<double> coeffs) : TEquation(coeffs, 3) {
    this->numberOfCoefficients = 3;
    this->findRoots();
};

std::vector<double> QuadraticEquation::findRoots() {
    auto coeffs = this->getCoefficients();
    double a = coeffs[0];
    double b = coeffs[1];
    double c = coeffs[2];
    double discriminant = pow(b, 2) - 4 * a * c;

    if (discriminant < 0) {
        std::vector<double> root = {};
        this->roots = root;
    } else if (discriminant == 0) {
        std::vector<double> root = {-b / (2 * a)};
        this->roots = root;
    } else {
        double root1 = (-b + sqrt(discriminant)) / (2 * a);
        double root2 = (-b - sqrt(discriminant)) / (2 * a);
        std::vector<double> root = {root1, root2};
        this->roots = root;
    }
    return this->roots;
}

std::vector<QuadraticEquation>
QuadraticEquation::generateRandomEquation(int minCoeff, int maxCoeff, int numberOfInstances) {
    std::vector<QuadraticEquation> equations;
    int numberOfCoefficients = 3;
    for (int i = 0; i < numberOfInstances; i++) {
        try {
            std::vector<double> coefficients;
            for (int j = 0; j < numberOfCoefficients; j++) {
                coefficients.push_back((rand() % (maxCoeff - minCoeff + 1) + minCoeff));
            }
            auto eq = QuadraticEquation(coefficients);
            equations.push_back(eq);
        } catch (const char *msg) {
            std::cout << msg << std::endl;
        }
    }

    return equations;
}