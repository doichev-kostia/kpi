import utils


def main():
    input_text = utils.get_text()

    filename = input("Enter the file name: ")
    input_mode = input("Would you like to append the text or replace the old one? Enter 'a' for appending or 'w' for replacing: ")
    utils.fill_file(filename, input_mode.strip(), input_text)
    print("The file has been modified! Open {}".format(filename))

    content = utils.retrieve_file_content(filename)

    print('----------------------------------------------------')
    print('File content: {}'.format(content))
    print('----------------------------------------------------')

    searching_char = input("Enter the searching character: ")
    case_sensitive_result = input("Should the filter be case sensitive? Enter 'y' for yes or 'n' for no: ")
    is_case_sensitive = True if case_sensitive_result.strip() == 'y' else False
    new_filename = input("Enter the file name where the result will be stored: ")
    output_mode = input("Would you like to append the text or replace the old one? Enter 'a' for appending or 'w' for replacing: ")
    filtered_words = utils.filter_words(content, searching_char.strip(), is_case_sensitive)
    utils.fill_file(new_filename, output_mode, filtered_words)
    print("The file has been modified! Open {}".format(new_filename))

    print('----------------------------------------------------')
    print('Output text: {}'.format(filtered_words))
    print('----------------------------------------------------')


main()