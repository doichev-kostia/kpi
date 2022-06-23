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
        return 1;
    }

    if (subscribers.empty()) {
        cout << "No subscribers" << endl;
        return 1;
    }

    Subscriber subscriberWithTheBiggestPhoneNumberSum = subscribers[0];
    for (Subscriber subscriber: subscribers) {
        int sum = subscriber.getDigitsSum();
        if (sum > subscriberWithTheBiggestPhoneNumberSum.getDigitsSum()) {
            subscriberWithTheBiggestPhoneNumberSum = subscriber;
        }
    }

    std::cout << subscriberWithTheBiggestPhoneNumberSum.fullName
              << "'s  phone number has the biggest sum of digits, which is "
              << subscriberWithTheBiggestPhoneNumberSum.getDigitsSum() << std::endl;


    return 0;
}
