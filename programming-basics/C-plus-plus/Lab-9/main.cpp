#include <iostream>
#include <cstring>
#include <cctype>
#include <cstdio>

typedef struct {
    std::string value;
    size_t length;
} str;

int main() {
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

    int numberOfWords = 0;

    char *word;
    int wordLength = 0;
    for (int i = 0; i <= inputString.length; ++i) {
        int currentCharacter = tolower(inputString.value[i]);

        char *temporary;
        if (wordLength != 0) {
            temporary = new char[wordLength];
            for (int j = 0; j < wordLength; ++j) {
                temporary[j] = word[j];
            }
        }

        bool isPunctuation = false;
        for (int punctuation = 0; punctuation < punctuationLength; punctuation++) {
            int punctuationCharacter = tolower(PUNCTUATION_MARKS[punctuation]);
            if (currentCharacter == punctuationCharacter) {
                isPunctuation = true;
            }
        }

        if (wordLength != 0 && !isPunctuation) {
            delete[] word;
        }

        word = new char[wordLength + 1];
        if (wordLength > 0) {
            for (int j = 0; j < wordLength; ++j) {
                word[j] = temporary[j];
            }
            delete[] temporary;
        }

        if (isPunctuation || i == inputString.length) {
            word[wordLength] = '\0';
            for (int j = 0; j < wordLength; ++j) {
                std::cout << word[j];
            }
            std::cout << "\n";
            wordLength = 0;
            delete[] word;
        } else {
            word[wordLength] = (char) currentCharacter;
            ++wordLength;
        }
    }


//    std::string test = "hello,world";
//    char **newTestWord;
//    size_t size = test.length();
//    int wordLength = 0;
//    for (int i = 0; i < size; ++i) {
//
//        char **temporary;
//        if (wordLength != 0) {
//            temporary = new char*[wordLength];
//            for (int j = 0; j < wordLength; ++j) {
//                *temporary[j] = *newTestWord[j];
//            }

//        }
//        int currentCharacter = tolower(test[i]);
//
//        bool isPunctuation = false;
//        for (int punctuation = 0; punctuation < punctuationLength; punctuation++) {
//            int punctuationCharacter = tolower(PUNCTUATION_MARKS[punctuation]);
//            if (currentCharacter == punctuationCharacter) {
//                isPunctuation = true;
//            }
//        }

//        if (i != 0 && !isPunctuation){
//            delete[] newTestWord;
//        }
//
//        if (!isPunctuation){
//            ++wordLength;
//            newTestWord = new char *[wordLength];
//            if (wordLength > 1){
//                for (int j = 0; j < wordLength - 1; ++j) {
//                    *newTestWord[j] = *temporary[j];
//                }
//            }
//            *(*(newTestWord + wordLength - 1)) = (char) currentCharacter;
//        } else {
//            std::cout << "The word is: ";
//            for (int j = 0; j < wordLength; ++j) {
//                std::cout << *newTestWord[j];
//            }
//            std::cout << "\n";
//            wordLength = 0;
//        }
//    }
//    char ** words;
//
//    for (int i = 0; i < numberOfWords; ++i) {
//        if (i != 0){
//            delete[] words;
//        }
//        char **word;
//
//        for (int j = 0; j < ; ++j) {
//
//        }
//    }

    return 0;
}

