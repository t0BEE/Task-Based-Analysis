# cmake_minimum_required(VERSION <specify CMake version here>)
project(openMP)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fopenmp")

add_executable(openMP main.cpp)