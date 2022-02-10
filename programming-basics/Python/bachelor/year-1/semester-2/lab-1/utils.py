def get_text():
    lines = []
    terminating_key = input("Enter the key that will finish the input: ")
    print("Enter the text. To finish entering press '{}' and Enter".format(terminating_key))
    terminating_key_length = len(terminating_key)
    while True:
        line = input()
        if line.find(terminating_key) != -1:
            lines.append(line[0:-1 * terminating_key_length])
            break
        else:
            lines.append(line)
    return "\n".join(lines)


def fill_file(filename, mode, content):
    file = open(filename, mode)
    file.write(content)
    file.close()
    return file


def filter_words(text, filtering_char, is_case_sensitive):
    filtered = []
    words = text.split()
    for word in words:
        current_word = word
        if not is_case_sensitive:
            current_word = word.lower()
            filtering_char = filtering_char.lower()

        if current_word.startswith(filtering_char):
            filtered.append(word)
    return " ".join(filtered) + " "
