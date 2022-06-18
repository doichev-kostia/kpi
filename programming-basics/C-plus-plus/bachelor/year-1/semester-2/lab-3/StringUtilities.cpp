
#include "StringUtilities.h"

using namespace std;

vector<string> StringUtilities::split(std::string text, const std::string &delimiter) {
    vector<string> output;
    size_t position = 0;
    string chunk;
    while ((position = text.find(delimiter)) != string::npos) {
        chunk = text.substr(0, position);
        output.push_back(chunk);
        text.erase(0, position + delimiter.length());
    }
    if (text.length() > 0) {
        output.push_back(text);
    }
    return output;
}