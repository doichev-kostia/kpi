#ifndef LAB_2_FILE_H
#define LAB_2_FILE_H

#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <sstream>

using namespace std;
class File {
public:
    string name;
    File(string fileName);
    vector<vector<string>>getCsvContent();
};


#endif //LAB_2_FILE_H
