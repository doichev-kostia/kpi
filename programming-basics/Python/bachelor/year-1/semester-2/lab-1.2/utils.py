import pickle
import datetime


def fill_binary_file(data, filename):
    with open(filename, 'wb') as file:
        pickle.dump(data, file)


def get_binary_file_data(filename):
    with open(filename, 'rb') as file:
        return pickle.load(file)


def transform_time_to_milliseconds(time):
    return time.hour * 60 * 60 * 1000 + time.minute * 60 * 1000 + time.second * 1000 + time.microsecond / 1000


def transform_milliseconds_to_time(milliseconds):
    if type(milliseconds) == float:
        milliseconds = int(milliseconds)

    return datetime.time(milliseconds // (60 * 60 * 1000), milliseconds // (60 * 1000) % 60, milliseconds // 1000 % 60,
                         milliseconds % 1000)


def add_time(time1, time2):
    return transform_milliseconds_to_time(transform_time_to_milliseconds(time1) + transform_time_to_milliseconds(time2))


def subtract_time(time1, time2):
    return transform_milliseconds_to_time(transform_time_to_milliseconds(time1) - transform_time_to_milliseconds(time2))


def print_todos(todos):
    for todo in todos:
        print('Title: {}, Begin time: {}, Duration: {}'.format(todo['title'], todo['begin_time'], todo['duration']))


def is_todo_in_range(todo, range):
    time_sum = add_time(todo['begin_time'], todo['duration'])
    return range['min'] <= time_sum <= range['max']


def get_free_time(todos, start_time=datetime.time(0, 0), end_time=datetime.time(23, 59, 59)):
    free_time = []
    cursor = start_time

    todos.sort(key=lambda todo: todo['begin_time'])

    for todo in todos:
        todo_end_time = add_time(todo['begin_time'], todo['duration'])
        if cursor < todo['begin_time'] < end_time:
            free_time.append({'begin_time': cursor, 'end_time': todo['begin_time']})
            cursor = todo_end_time
        elif cursor == todo['begin_time']:
            cursor = todo_end_time

    if cursor < end_time:
        free_time.append({'begin_time': cursor, 'end_time': end_time})

    return free_time


def print_free_time(free_time):
    for item in free_time:
        print('Begin time: {}, End time: {}, Duration: {}'.format(item['begin_time'], item['end_time'], subtract_time(item['end_time'], item['begin_time'])))
