#ifndef LAB_4_LINEAREQUATION_H
#define LAB_4_LINEAREQUATION_H

#include "TEquation.h"

class LinearEquation: public TEquation {
public:
    LinearEquation();
    explicit LinearEquation(std::vector<double> coefficients);
    std::vector<double> findRoots() override;
    static std::vector<LinearEquation> generateRandomEquation(int minCoeff, int maxCoeff, int numberOfInstances);
};


#endif //LAB_4_LINEAREQUATION_H
