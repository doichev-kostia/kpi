//
// Created by Kostia  on 16.02.2022.
//

#ifndef LAB_1_STRING_UTILS_H
#define LAB_1_STRING_UTILS_H

#endif //LAB_1_STRING_UTILS_H

#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <cctype>

using namespace std;
vector<string> split(string text, const string &divider);
string toLowerCase(const string &str);
string replaceAll (string str, const string &substring, const string &newSubstring);