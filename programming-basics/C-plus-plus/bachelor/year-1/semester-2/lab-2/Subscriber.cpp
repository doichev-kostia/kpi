
#include "Subscriber.h"

Subscriber::Subscriber() {};

Subscriber::Subscriber(std::string fullName, std::string address, std::string phoneNumber) {
    this->fullName = fullName;
    this->address = address;
    try {
        this->phoneNumber = PhoneNumber(phoneNumber);
    } catch (const std::invalid_argument& exception) {
        throw std::invalid_argument(fullName+ " has invalid phone number. " + exception.what());
    }
}

int Subscriber::getDigitsSum() {
    std::vector<std::string> parts = StringUtilities::split(this->phoneNumber.getNumber(), "-");
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