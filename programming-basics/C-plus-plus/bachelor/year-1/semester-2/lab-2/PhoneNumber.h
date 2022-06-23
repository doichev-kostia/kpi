#ifndef LAB_2_PHONENUMBER_H
#define LAB_2_PHONENUMBER_H

#include <iostream>
#include <string>
#include <vector>

class PhoneNumber {
    std::string number;
public:
    PhoneNumber();
    PhoneNumber(std::string number);

    std::string getNumber();

private:
    bool isValid();
};


#endif //LAB_2_PHONENUMBER_H
