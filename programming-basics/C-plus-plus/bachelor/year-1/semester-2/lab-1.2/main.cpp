#include <iostream>
#include <vector>
#include "utils.h"

using namespace std;

int main() {
    string initialFileName;
    cout << "Enter initial file name: ";
    cin >> initialFileName;

    Range RANGE = {"12:45", "17:30"};


    vector<Todo> initialTodos = {
            {"Buy milk",  "09:00", "00:15"},
            {"Buy eggs",  "12:45", "01:00"},
            {"Buy bread", "17:00", "00:45"},
    };

    cout << "Initial todos:" << endl;
    printTodos(initialTodos);

    cout << "Filling binary file..." << endl;
    fillBinaryFile(initialFileName, initialTodos);

    cout << "Reading binary file..." << endl;
    vector<Todo> todosFromFile = readBinaryFile(initialFileName, initialTodos.size());

    cout << "Todos from " << initialFileName << ": " << endl;
    printTodos(todosFromFile);

    cout << "Filtering todos by range..." << endl;
    vector<Todo> filteredTodos = filterArray(todosFromFile, filterCallback, RANGE);

    cout << "Todos in range : " << endl;
    printTodos(filteredTodos);

    string outputFilename;
    cout << "Enter output file name: ";
    cin >> outputFilename;

    cout << "Filling filtered todos in the  binary file..." << endl;
    fillBinaryFile(outputFilename, filteredTodos);
    cout << "Done!" << endl;

    cout << "Reading filtered todos from the binary file..." << endl;
    vector<Todo> todosFromOutputFile = readBinaryFile(outputFilename, filteredTodos.size());

    cout << "Todos from " << outputFilename << ": " << endl;
    printTodos(todosFromOutputFile);

    vector<FreeTime> freeTime = getFreeTime(initialTodos);
    cout << "Free time: " << endl;
    printFreeTime(freeTime);

    return 0;
}
