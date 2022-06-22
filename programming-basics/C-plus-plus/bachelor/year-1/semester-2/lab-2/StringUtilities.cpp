//
// Created by Panenco on 15.05.2022.
//

#include "StringUtilities.h"

std::vector<std::string> StringUtilities::split(std::string text, const std::string &divider) {
    std::vector<std::string> output;
    size_t position = 0;
    std::string chunk;
    while ((position = text.find(divider)) != std::string::npos) {
        chunk = text.substr(0, position);
        output.push_back(chunk);
        text.erase(0, position + divider.length());
    }
    if (text.length() > 0) {
        output.push_back(text);
    }
    return output;
}