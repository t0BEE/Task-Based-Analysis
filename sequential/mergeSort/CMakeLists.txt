cmake_minimum_required(VERSION 3.10)

set(CMAKE_CXX_COMPILER g++)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -lm")
set(CXX_STANDARD_REQUIRED 17)

project(sequentialMergeSort)

add_executable(sequentialMergeSort main.cpp)
