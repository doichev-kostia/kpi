#include <iostream>

using namespace std;
bool calculateByFormula (int A, int B, int C, int D);

int main() {
    int numbers[] = {6, 7, 7, 14};
    bool result = calculateByFormula(numbers[0], numbers[1], numbers[2], numbers[3]);
    cout << "The result is: " << result << endl;
    return 0;
}

bool calculateByFormula (int A, int B, int C, int D){
   return (!(A == B) && (!(C != D)));
}
