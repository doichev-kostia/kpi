#include <iostream>
#include <vector>
#include "Subscriber.h"
#include "File.h"

int main() {
    std::vector<Subscriber> subscribers;
    try {
        File file("../data.csv");
        std::vector<std::vector<std::string>> data = file.getCsvContent();
        /**
         * @description: starting from the second line of the csv file
         */
        for (int i = 1; i < data.size(); i++) {
            Subscriber subscriber(data[i][0], data[i][1], data[i][2]);
            subscribers.push_back(subscriber);
        }
    } catch (std::exception &e) {
        std::cout << e.what() << std::endl;
    }

    Subscriber subscriberWithTheBiggestPhoneNumberSum = subscribers[0];
    for (Subscriber subscriber: subscribers) {
        int sum = subscriber.phoneNumber.getDigitsSum();
        if (sum > subscriberWithTheBiggestPhoneNumberSum.phoneNumber.getDigitsSum()) {
            subscriberWithTheBiggestPhoneNumberSum = subscriber;
        }
    }

    std::cout << subscriberWithTheBiggestPhoneNumberSum.fullName
              << "'s  phone number has the biggest sum of digits, which is "
              << subscriberWithTheBiggestPhoneNumberSum.phoneNumber.getDigitsSum() << std::endl;


    return 0;
}
