#ifndef LAB_2_PHONENUMBER_H
#define LAB_2_PHONENUMBER_H

#include <iostream>
#include <string>
#include <vector>

class PhoneNumber {
public:
    std::string number;
    PhoneNumber(std::string number);
    bool isValid();
    int getDigitsSum();
};


#endif //LAB_2_PHONENUMBER_H
