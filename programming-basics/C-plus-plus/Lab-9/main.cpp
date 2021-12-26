#include <iostream>
#include <iomanip>
#include <cstdio>

typedef struct {
    std::string value;
    size_t length;
} str;

template<typename T>
struct array {
    T *value;
    size_t length;
};


bool isPunctuationMark(int character);

int main() {
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
    for (int i = 0; i < inputString.length; ++i) {
        int currentCharacter = tolower(inputString.value[i]);
        int prevCharacter = i > 0 ? tolower(inputString.value[i - 1]) : 0;
        bool isPunctuation = isPunctuationMark(currentCharacter);
        bool isPreviousCharacterPunctuation = isPunctuationMark(prevCharacter);

        if (i == 0 && isPunctuation) {
            continue;
        }

        if ((isPunctuation && !isPreviousCharacterPunctuation) || i == inputString.length - 1) {
            numberOfWords++;
        }
    }

    array<array<char>> words;
    words.value = new array<char>[numberOfWords];
    words.length = numberOfWords;
    int wordOrder = 0;
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

        int prevCharacter = i > 0 ? tolower(inputString.value[i - 1]) : 0;
        bool isPunctuation = isPunctuationMark(currentCharacter);
        bool isPreviousCharacterPunctuation = isPunctuationMark(prevCharacter);

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

        if ((isPunctuation && !isPreviousCharacterPunctuation) || i == inputString.length) {
            array<char> wordItem;
            word[wordLength] = '\0';
            wordItem.length = wordLength + 1;
            wordItem.value = word;
            words.value[wordOrder] = wordItem;
            wordLength = 0;
            wordOrder++;
            delete[] word;
        } else if (!isPunctuation) {
            word[wordLength] = (char) currentCharacter;
            ++wordLength;
        }
    }

    for (int i = 0; i < words.length; ++i) {
        array<char> word = words.value[i];
        for (int j = 0; j < word.length; ++j) {
            std::cout << word.value[j] << std::endl;
        }
        std::cout << std::endl;
    }

    return 0;
}

bool isPunctuationMark(int character) {
    char PUNCTUATION_MARKS[] = {'.', ',', ' ', ':', '?', '\''};
    size_t punctuationLength = sizeof(PUNCTUATION_MARKS) / sizeof(PUNCTUATION_MARKS[0]);

    bool isPunctuation = false;
    for (int punctuation = 0; punctuation < punctuationLength; punctuation++) {
        int punctuationCharacter = tolower(PUNCTUATION_MARKS[punctuation]);
        if (character == punctuationCharacter) {
            isPunctuation = true;
        }
    }

    return isPunctuation;
}
