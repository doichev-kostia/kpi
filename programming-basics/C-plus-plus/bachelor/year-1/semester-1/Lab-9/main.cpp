#include <iostream>

typedef struct {
    std::string value;
    size_t length;
} str;


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
    std::size_t foundIndex;
    std::string inputStringCopy = inputString.value;

    int numberOfSubtractions = 0;
    do {
        foundIndex = inputStringCopy.find(characterGroup.value);

        if (foundIndex != std::string::npos) {
            for (size_t i = foundIndex; i >= 0; --i) {
                int currentCharacter = tolower(inputStringCopy[i]);
                bool isPunctuation = isPunctuationMark(currentCharacter);
                bool isLast = i == 0;

                if (isPunctuation || isLast) {
                    inputStringCopy.replace(i, foundIndex + characterGroup.length, "");
                    numberOfSubtractions++;
                    break;
                }
            }
        }
    } while (foundIndex != std::string::npos);
    std::cout << "Initial string: " << inputString.value << std::endl;
    std::cout << "Result: " << inputStringCopy << std::endl;
    std::cout << "Number of subtractions: " << numberOfSubtractions << std::endl;

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
