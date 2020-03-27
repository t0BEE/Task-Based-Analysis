cmake_minimum_required(VERSION 3.10)

set(CMAKE_CXX_COMPILER g++)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -lm -fopenmp")
set(CXX_STANDARD_REQUIRED 17)

project(openMPMergeSort)
add_definitions(-DVECTOR_SIZE=10000)

add_executable(openMPMergeSort main.cpp)
