import re
input_string = input("Enter the sentence: ")
character_group = input("Enter characters: ")

words = re.split(r'[(!,.:?\')]|[( +)]', input_string)
filtered_words = []

for word in words:
    if not word.endswith(character_group) or word == " ":
        filtered_words.append(word)
number_of_deletions = len(words) - len(filtered_words)

formatted_string = " ".join(filtered_words)
print("Result: ", formatted_string)
print(number_of_deletions, " word/s were deleted")