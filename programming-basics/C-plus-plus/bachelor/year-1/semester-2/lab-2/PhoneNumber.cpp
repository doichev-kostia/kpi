#include "PhoneNumber.h"
#include "StringUtilities.h"


PhoneNumber::PhoneNumber() {
    this->number = "000-00-00-00";
}

PhoneNumber::PhoneNumber(std::string number) {
    this->number = number;
    if (!this->isValid()) {
        throw std::invalid_argument(
                number + " is not a valid phone number. Make sure you match the format XXX-XXX-XX-XX");
    }
}

bool PhoneNumber::isValid() {
    if (this->number.length() != 13) {
        return false;
    }
    std::vector<std::string> parts = StringUtilities::split(this->number, "-");
    if (parts.size() != 4) {
        return false;
    }

    /**
     * @description: i < 4 as the we have already checked that length
     */
    for (int i = 0; i < 4; i++) {
        size_t partLength = parts[i].length();
        if (i <= 1 && partLength != 3) {
            return false;
        } else if (i > 1 && partLength != 2) {
            return false;
        }
    }
    return true;
}

std::string PhoneNumber::getNumber() {
    return this->number;
}