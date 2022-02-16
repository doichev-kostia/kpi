#include <iostream>

#include "Utils.h"

using namespace std;

int main() {
    const string APPEND_MODE = "a";
    const string TRUNCATE_MODE = "t";
    const string YES = "y";
    const string NO = "n";
    char terminatingKey;
    cout << "Enter the terminating key: ";
    cin >> terminatingKey;

    cout << "Enter the text: ";
    string input = getInput(terminatingKey);

    string inputFilename;
    do {
        cout << "Enter the file name: ";
        cin >> inputFilename;
    } while (inputFilename.length() < 3);

    string inputMode;
    do {
        cout << "Would you like to append the text or replace the old one? Enter '" << APPEND_MODE << "' to append or '"
             << TRUNCATE_MODE << "' to truncate(replace): ";
        cin >> inputMode;
    } while (inputMode != APPEND_MODE && inputMode != TRUNCATE_MODE);

    try {
        fillFile(inputFilename, inputMode, input, APPEND_MODE);
    } catch (runtime_error error) {
        cout << "Runtime error: " << error.what() << endl;
    }

    string content;
    try {
        content = retrieveFileContent(inputFilename);
    } catch (runtime_error error) {
        cout << "Runtime error: " << error.what() << endl;
    }

    cout << "The file has been modified! Open " << inputFilename << endl;

    cout << "---------------------------------------------------------------------------" << endl;
    cout << "Input: " << content << endl;
    cout << "---------------------------------------------------------------------------" << endl;

    char searchingCharacter;
    cout << "Enter the searching character: ";
    cin >> searchingCharacter;

    string caseSensitiveResult;
    cout << "Should the filter be case sensitive? Enter '" << YES << "' for yes or '" << NO << "' for no: ";
    cin >> caseSensitiveResult;

    bool isCaseSensitive = caseSensitiveResult == YES;
    string outputFilename;
    do {
        cout << "Enter the file name where the result will be stored: ";
        cin >> outputFilename;
    } while (inputFilename.length() < 3);

    string outputMode;
    do {
        cout << "Would you like to append the text or replace the old one? Enter '" << APPEND_MODE << "' to append or '"
             << TRUNCATE_MODE << "' to truncate(replace): ";
        cin >> outputMode;
    } while (outputMode != APPEND_MODE && outputMode != TRUNCATE_MODE);

    string filteredWords = filterWords(content, searchingCharacter, isCaseSensitive);
    fillFile(outputFilename, outputMode, filteredWords, APPEND_MODE);
    cout << "The file has been modified! Open " << outputFilename << endl;

    cout << "---------------------------------------------------------------------------" << endl;
    cout << "Output: " << filteredWords << endl;
    cout << "---------------------------------------------------------------------------" << endl;

    return 0;
}
