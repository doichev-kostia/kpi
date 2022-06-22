from datetime import time, datetime
import utils


def main():
    RANGE = {
        "min": time(12, 45),
        "max": time(17, 30)
    }

    initial_file_name = input("Enter the initial file name : ")

    initial_todos = [
        {"title": "Buy milk", "begin_time": time(9, 0), "duration": time(0, 15)},
        {"title": "Buy eggs", "begin_time": time(12, 45), "duration": time(1, 0)},
        {"title": "Buy bread", "begin_time": time(17, 0), "duration": time(0, 45)},
    ]

    print('Initial todos:')
    utils.print_todos(initial_todos)

    utils.fill_binary_file(initial_todos, initial_file_name)

    todos = utils.get_binary_file_data(initial_file_name)

    print('Todos from the file:')
    utils.print_todos(todos)

    filtered = list(filter(lambda todo: utils.is_todo_in_range(todo, RANGE), todos))
    print('Todos in the range:')
    utils.print_todos(filtered)

    output_file_name = input("Enter the output file name : ")

    utils.fill_binary_file(filtered, output_file_name)
    print("Saved todos to the file")

    output = utils.get_binary_file_data(output_file_name)
    print('Todos from the file:')
    utils.print_todos(output)

    free_time = utils.get_free_time(initial_todos)
    print('Free time:')
    utils.print_free_time(free_time)


if __name__ == "__main__":
    main()
