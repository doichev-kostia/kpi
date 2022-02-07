#include <iostream>
#include <vector>

using namespace std;

vector<int> getDecimalFractions(int number);

int main(){
    int M, N;

    do {
        cout << "Enter the first natural number: ";
        cin >> M;
    } while (M <= 0);

    do{
        cout << "Enter the second natural number: ";
        cin >>N;
    } while(N <= 0);

    float divisionResult = (float) M / N;

    unsigned short int tenths = divisionResult * 10 - (int) divisionResult * 10;
    unsigned short int ones = getDecimalFractions((int) divisionResult)[0];

    cout<< "Tenths: " << tenths << endl;
    cout<< "Ones: " << ones << endl;

    return 0;
}

/*
 * This function divides the number by decimal fractions
 */
vector<int> getDecimalFractions(int number){
    vector <int> fractions;
    while (number != 0){
        fractions.push_back(number % 10);
        number = number / 10;
    }
    return fractions;
}