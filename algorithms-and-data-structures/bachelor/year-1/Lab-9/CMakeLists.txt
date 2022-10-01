cmake_minimum_required(VERSION 3.20)
project(Lab_9)

set(CMAKE_CXX_STANDARD 14)
add_library(
        utils

        SHARED

        src/utils.cpp
)
add_library(
        matrix-output

        SHARED

        src/matrix-output.cpp
)
add_executable(Lab_9 src/main.cpp)
