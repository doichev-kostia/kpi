//
// Created by Panenco on 15.05.2022.
//

#ifndef LAB_2_SUBSCRIBER_H
#define LAB_2_SUBSCRIBER_H
#include <string>
#include "PhoneNumber.h"

class Subscriber {
public:
    std::string fullName;
    std::string address;
    PhoneNumber phoneNumber;
    Subscriber(std::string fullName, std::string address, std::string phoneNumber);
};


#endif //LAB_2_SUBSCRIBER_H
