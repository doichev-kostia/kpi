#include "utils.h"

using namespace std;

vector<string> split(string text, const string &divider) {
    vector<string> output;
    size_t position = 0;
    string chunk;
    while ((position = text.find(divider)) != string::npos) {
        chunk = text.substr(0, position);
        output.push_back(chunk);
        text.erase(0, position + divider.length());
    }

    if (text.length() > 0) {
        output.push_back(text);
    }

    return output;
}

void printTodos(vector<Todo> todos) {
    for (auto todo: todos) {
        cout << "Title: " << todo.title << ", Begin time: " << todo.beginTime << ", Duration: "
             << todo.duration
             << endl;
    }
}

void fillBinaryFile(const string &fileName, vector<Todo> todos) {
    ofstream file(fileName, ios::binary);
    if (!file.is_open()) {
        throw runtime_error("Could not open file " + fileName);
    }

    for (int i = 0; i < todos.size(); ++i) {
        file.write((char *) &todos[i], sizeof(Todo));
    }

    file.close();
    if (!file.good()) {
        throw runtime_error("Could not write to file " + fileName);
    }
}

vector<Todo> readBinaryFile(const string &fileName, int size) {
    vector<Todo> todos(size);
    ifstream file(fileName, ios::binary);
    if (!file.is_open()) {
        throw runtime_error("Could not open file " + fileName);
    }

    for (int i = 0; i < size; i++) {
        file.read((char *) &todos[i], sizeof(Todo));
    }

    file.close();
    if (!file.good()) {
        throw runtime_error("Could not read file " + fileName);
    }
    return todos;
}

vector<Todo> filterArray(vector<Todo> &arr, bool (*callback)(Todo, Range), Range range) {
    vector<Todo> filteredArr;
    for (int i = 0; i < arr.size(); ++i) {
        if (callback(arr[i], range)) {
            filteredArr.push_back(arr[i]);
        }
    }
    return filteredArr;
}

int transformTimeToMilliseconds(const string &time) {
    vector<string> timeParts = split(time, ":");
    int hours = stoi(timeParts[0]);
    int minutes = stoi(timeParts[1]);
    return hours * 3600 * 1000 + minutes * 60 * 1000;
}

string transformMillisecondsToTime(int milliseconds) {
    int hours = milliseconds / (3600 * 1000);
    int minutes = (milliseconds % (3600 * 1000)) / (60 * 1000);
    return to_string(hours) + ":" + to_string(minutes);
}

string addTime(string time1, string time2) {
    int time1Milliseconds = transformTimeToMilliseconds(time1);
    int time2Milliseconds = transformTimeToMilliseconds(time2);
    int sumMilliseconds = time1Milliseconds + time2Milliseconds;
    return transformMillisecondsToTime(sumMilliseconds);
}

string subtractTime(string time1, string time2) {
    int time1Milliseconds = transformTimeToMilliseconds(time1);
    int time2Milliseconds = transformTimeToMilliseconds(time2);
    int differenceMilliseconds = time1Milliseconds - time2Milliseconds;
    return transformMillisecondsToTime(differenceMilliseconds);
}

bool filterCallback(Todo todo, Range range) {
    string timeSum = addTime(todo.beginTime, todo.duration);
    int timeSumMilliseconds = transformTimeToMilliseconds(timeSum);
    int minMilliseconds = transformTimeToMilliseconds(range.min);
    int maxMilliseconds = transformTimeToMilliseconds(range.max);
    return timeSumMilliseconds >= minMilliseconds && timeSumMilliseconds <= maxMilliseconds;
};

bool sortByBeginTime(Todo todo1, Todo todo2) {
    return transformTimeToMilliseconds(todo1.beginTime) < transformTimeToMilliseconds(todo2.beginTime);
}

vector<FreeTime> getFreeTime(vector<Todo> todos, string startTime, string endTime) {
    vector<FreeTime> freeTime;
    string cursor = startTime;

    sort(todos.begin(), todos.end(), sortByBeginTime);

    for (auto todo: todos) {
        string todoEndTime = addTime(todo.beginTime, todo.duration);
        int cursorMilliseconds = transformTimeToMilliseconds(cursor);
        int todoBeginMilliseconds = transformTimeToMilliseconds(todo.beginTime);
        int todoEndMilliseconds = transformTimeToMilliseconds(todoEndTime);

        if (cursorMilliseconds < todoBeginMilliseconds < todoEndMilliseconds) {
            FreeTime freeTimeItem = {cursor, todo.beginTime};
            freeTime.push_back(freeTimeItem);
            cursor = todoEndTime;
        } else if (cursorMilliseconds < todoBeginMilliseconds) {
            cursor = todoEndTime;
        }
    }

    if (transformTimeToMilliseconds(cursor) < transformTimeToMilliseconds(endTime)) {
        FreeTime freeTimeItem = {cursor, endTime};
        freeTime.push_back(freeTimeItem);
    }

    return freeTime;
}

void printFreeTime(std::vector<FreeTime> freeTime) {
    for (auto freeTimeItem: freeTime) {
        string duration = subtractTime(freeTimeItem.endTime, freeTimeItem.beginTime);
        cout << "Begin time: " << freeTimeItem.beginTime << ", End time: " << freeTimeItem.endTime << " , Duration: "
             << duration << endl;
    }
}