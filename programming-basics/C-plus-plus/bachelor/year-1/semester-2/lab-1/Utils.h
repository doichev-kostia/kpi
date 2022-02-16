//
// Created by Kostia  on 09.02.2022.
//

#ifndef LAB_1_UTILS_H
#define LAB_1_UTILS_H

#include <string>
#include <vector>
#include <iostream>
#include <fstream>
#include <cctype>
#include "string-utils.h"

using namespace std;


string getInput(const char &terminatingKey);
string getInput(int terminatingKey);
void fillFile(const string &filename, const string &mode, const string &content, const string & APPEND_MODE);
string filterWords(const string& text, char filteringChar, bool isCaseSensitive);

#endif //LAB_1_UTILS_H
