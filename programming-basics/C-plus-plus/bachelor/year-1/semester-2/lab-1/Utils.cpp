//
// Created by Kostia  on 09.02.2022.
//

#include "Utils.h"

string getInput(const char &terminatingKey) {
    string input;
    getline(cin, input, terminatingKey);
    return input;
}

string getInput(int terminatingKey) {
    string input;
    getline(cin, input, char(terminatingKey));
    return input;
}

void fillFile(const string &filename, const string &mode, const string &content, const string & APPEND_MODE){
    ofstream file;
    if (mode == APPEND_MODE) {
        file.open(filename, ios::out | ios::app);
    } else {
        file.open(filename, ios::out | ios::trunc);
    }

    if (!file.is_open()) {
        throw runtime_error("An error has occurred while changing the file");
    }

    file << content;
    file.close();
}

string retrieveFileContent(const string &filename){
    string content;
    ifstream file(filename);
    if (!file.is_open()){
        throw runtime_error("An error has occurred while changing the file");
    }

    while(!file.eof()){
        string line;
        getline(file, line);
        content += line + '\n';
    }
    file.close();
    return content;
}


string filterWords(const string& text, char filteringChar, bool isCaseSensitive){
    string filtered;
    string modified = replaceAll(text, "\n", " ");
    vector<string> words = split(modified, " ");
    for (string word : words) {
        string currentWord = word;
        char currentChar = filteringChar;
        if  (!isCaseSensitive){
            currentWord = toLowerCase(word);
            currentChar = (char) tolower(filteringChar);
        }

        if (currentWord[0] == currentChar){
            filtered.append(word + " ");
        }
    }
    return filtered;
}

