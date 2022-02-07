#include <iostream>
#include <vector>

using namespace std;

float transformCelsiusToFahrenheit(float temperature);

int main() {
    float celsiusTemperature;
    float step;

    do {
        cout << "Enter the positive temperature in Celsius: ";
        cin >> celsiusTemperature;
    } while (celsiusTemperature < 0);

    do {
        cout << "Enter the step of temperature calculations: ";
        cin >> step;
    } while (step <= 0);

    vector<vector<float> > temperatures;

    for (float i = 0; i <= celsiusTemperature; i += step) {
        float fahrenheit = transformCelsiusToFahrenheit((float) i);
        vector<float> values = {(float) i, fahrenheit};
        temperatures.push_back(values);
    }

    int numberOfRows = temperatures.size();

    cout << "The result is: " << endl;
    for (int i = 0; i < numberOfRows; i++) {
        cout << "Celsius: " << temperatures[i][0] << " Fahrenheit: " << temperatures[i][1] << endl;
    }
    return 0;
}

float transformCelsiusToFahrenheit(float temperature) {
    return 9 * temperature / 5. + 32;
}