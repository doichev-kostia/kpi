#include <iostream>
#include <cstring>
#include <cctype>
#include <cstdio>

typedef struct {
    std::string value;
    size_t length;
} str;

int main() {
    const int MAXIMUM_CHARACTER_LENGTH = 256;
    char PUNCTUATION_MARKS[] = {'.', ',', ' ', ':', '?', '\''};
    size_t punctuationLength = sizeof(PUNCTUATION_MARKS) / sizeof(PUNCTUATION_MARKS[0]);
    str inputString;
    str characterGroup;
    inputString.value = "";
    characterGroup.value = "";

    std::cout << "Enter the sentence: ";
    getline(std::cin, inputString.value);

    std::cout << "Enter the filtering characters: ";
    getline(std::cin, characterGroup.value);

    inputString.length = inputString.value.length();
    characterGroup.length = characterGroup.value.length();

    std::cout << inputString.value << std::endl;

//    char *words = new std::string[1];
//    int wordLength = 0;
//    int numberOfWords = 0;
//    for (int i = 0; i < inputString.length; i++) {
//        int currentCharacter = tolower(inputString.value[i]);
//        bool isPunctuation = false;
//        for (int punctuation = 0; punctuation < punctuationLength; punctuation++) {
//            int punctuationCharacter = tolower(PUNCTUATION_MARKS[punctuation]);
//            if (currentCharacter == punctuationCharacter) {
//                isPunctuation = true;
//            }
//        }
//
//        if (!isPunctuation) {
//            words[numberOfWords][wordLength] = (char) currentCharacter;
//            wordLength++;
//        } else {
//            numberOfWords++;
//            wordLength = 0;
//        }
//    }
//
//    for (int i = 0; i < numberOfWords; ++i) {
//        size_t len = sizeof(words[i]) / sizeof(words[i][0]);
//        for (int j = 0; j < len; ++j) {
//            std::cout << words[i][j];
//        }
//        std::cout << "\n";
//    }
//
    return 0;
}

