#include <iostream>
#include <string>

using namespace std;

int main() {
    double coordX, coordY;
    string output;

    cout << "Enter x coordinate: ";
    cin >> coordX;

    cout << "Enter y coordinate: ";
    cin >> coordY;


    if (coordX == 0 && coordY == 0) {
        output = "The point is lying on the origin of the coordinate system";
    } else if (coordX == 0) {
        output = "The point is lying on Y-axis";
    } else if (coordY == 0) {
        output = "The point is lying on X-axis";
    } else if (coordX > 0 && coordY > 0) {
        output = "The point is lying on the first quadrant";
    } else if (coordX > 0 && coordY < 0) {
        output = "The point is lying on the forth quadrant";
    } else if (coordX < 0 && coordY > 0) {
        output = "The point is lying on the second quadrant";
    } else {
        output = "The point is lying on the third quadrant";
    }

    cout << output << endl;
    return 0;
}
