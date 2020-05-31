cmake_minimum_required(VERSION 3.10)

set(CMAKE_CXX_COMPILER g++)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -lm")
set(CXX_STANDARD_REQUIRED 17)

project(sequentialGeneric)
add_definitions(-DVECTOR_SIZE=100000)

add_executable(sequentialGeneric main.cpp)
