//
// Created by Kostia  on 16.02.2022.
//

#include "string-utils.h"

vector<string> split(string text, const string &divider) {
    vector<string> output;
    size_t position = 0;
    string chunk;
    while ((position = text.find(divider)) != string::npos) {
        chunk = text.substr(0, position);
        output.push_back(chunk);
        text.erase(0, position + divider.length());
    }
    if (text.length() > 0) {
        output.push_back(text);
    }
    return output;
}


string toLowerCase(const string &str){
    size_t strLength = str.length();
    string lower;
    for (size_t i = 0; i < strLength; ++i) {
        // врахувати числа
        lower.push_back((char) tolower(str[i]));
    }
    return lower;
}

string replaceAll (string str, const string &substring, const string &newSubstring) {
    string copy = str;
    size_t position = 0;
    size_t substringLength = substring.length();
    while ((position = copy.find(substring)) != string::npos) {
        copy.replace(position, substringLength, newSubstring);
    }

    return copy;
}