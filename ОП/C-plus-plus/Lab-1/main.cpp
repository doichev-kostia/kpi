#include <iostream>

using namespace std;
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
    unsigned short int ones = (divisionResult / 10 - (int) divisionResult / 10) * 10;

    cout<< "Tenths: " << tenths << endl;
    cout<< "Ones: " << ones << endl;

    return 0;
}