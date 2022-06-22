
#include "Subscriber.h"

Subscriber::Subscriber(std::string fullName, std::string address, std::string phoneNumber) : phoneNumber(phoneNumber) {
    this->fullName = fullName;
    this->address = address;
    this->phoneNumber = PhoneNumber(phoneNumber);
    if (!this->phoneNumber.isValid()) {
        throw std::invalid_argument(fullName + " has invalid phone number");
    }
}