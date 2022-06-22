//
// Created by Panenco on 14.05.2022.
//

#include "PhoneNumber.h"
#include "StringUtilities.h"


PhoneNumber::PhoneNumber(std::string number) {
    this->number = number;
}

bool PhoneNumber::isValid() {
    if (number.length() != 13) {
        return false;
    }
    std::vector<std::string> parts = StringUtilities::split(number, "-");
    if (parts.size() != 4){
        return false;
    }

    /**
     * @description: i < 4 as the we have already checked that length
     */
    for (int i = 0; i < 4; i++){
        size_t partLength = parts[i].length();
        if (i <= 1 && partLength != 3){
            return false;
        } else if (i > 1 && partLength != 2){
            return false;
        }
    }
    return true;
}

int PhoneNumber::getDigitsSum() {
    if (!isValid()) {
        throw std::invalid_argument("Invalid phone number");
    }
    std::vector<std::string> parts = StringUtilities::split(number, "-");
    int sum = 0;
    for (const std::string& part : parts){
        for (char c : part){
            /**
             * @description c - '0' is to cast char to int. a - '0' is equivalent to ((int)a) - ((int)'0')
             */
            sum += c - '0';
        }
    }
    return sum;
}