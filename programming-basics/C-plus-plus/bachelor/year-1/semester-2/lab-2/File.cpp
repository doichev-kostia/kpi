#include "File.h"


File::File(string fileName){
    this->name = fileName;
}

vector<vector<string>> File::getCsvContent() {
    vector<vector<string>> content;
    vector<string> row;

    string line, word;

    fstream file(this->name);
    if (!file.is_open()){
        throw runtime_error("An error has occurred while changing the file");
    }

    while(getline(file, line)){
        row.clear();

        stringstream ss(line);
        while(getline(ss, word, ',')){
            row.push_back(word);
        }
        content.push_back(row);
    }
    return content;
}