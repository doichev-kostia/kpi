#include <iostream>

using namespace std;
int calculateByFormula (int A, int B, int C, int D);

int main() {
    int numbers[] = {6, 7, 7, 14};
    int result = calculateByFormula(numbers[0], numbers[1], numbers[2], numbers[3]);
    cout << "The result is: " << result << endl;
    return 0;
}

int calculateByFormula (int A, int B, int C, int D){
    int result = (!(A == B) && (!(C != D)));
    return result;
}
