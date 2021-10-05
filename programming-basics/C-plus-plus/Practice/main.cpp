#include <iostream>

using namespace std;
int res (int A, int B, int C, int D);

int main() {
    int numbers[] = {6, 7, 7, 14};
    int result = res(numbers[0], numbers[1], numbers[2], numbers[3]);
    cout << "The result is: " << result << endl;
    return 0;
}

int res (int A, int B, int C, int D){
    int result = (!(A == B) && (!(C != D)));
    return result;
}
