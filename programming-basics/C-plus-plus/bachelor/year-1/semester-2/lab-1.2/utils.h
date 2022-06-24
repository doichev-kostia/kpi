#ifndef LAB_1_2_UTILS_H
#define LAB_1_2_UTILS_H

#endif //LAB_1_2_UTILS_H

#include <iostream>
#include <vector>
#include <string>
#include <fstream>

struct Todo {
    std::string title;
    std::string beginTime;
    std::string duration;
};

struct FreeTime {
    std::string beginTime;
    std::string endTime;
};

struct Range {
    std::string min;
    std::string max;
};

std::vector<std::string> split(std::string text, const std::string &divider);

void printTodos(std::vector<Todo> todos);

void fillBinaryFile(const std::string &fileName,std::vector<Todo> todos);

std::vector<Todo> readBinaryFile(const std::string &fileName, int size);

std::vector<Todo> filterArray(std::vector<Todo> &arr, bool (*callback)(Todo, Range), Range range);

bool filterCallback(Todo todo, Range range);

int transformTimeToMilliseconds(const std::string &time);

std::string transformMillisecondsToTime(int milliseconds);

std::string addTime(std::string time1, std::string time2);

std::string subtractTime(std::string time1, std::string time2);

bool sortByBeginTime(Todo todo1, Todo todo2);

std::vector<FreeTime> getFreeTime(std::vector<Todo> todos, std::string startTime = "00:00", std::string endTime="23:59");

void printFreeTime(std::vector<FreeTime> freeTime);