#ifndef LAB_4_QUADRATICEQUATION_H
#define LAB_4_QUADRATICEQUATION_H

#include "TEquation.h"
#include <cmath>


class QuadraticEquation: public TEquation {
public:
    QuadraticEquation();
    QuadraticEquation(std::vector<double> coeffs);
    std::vector<double> findRoots() override;
    static std::vector<QuadraticEquation> generateRandomEquation(int minCoeff, int maxCoeff, int numberOfInstances);
};


#endif //LAB_4_QUADRATICEQUATION_H
