cmake_minimum_required(VERSION 3.10)

set(CMAKE_CXX_COMPILER g++)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fopenmp -lm")
set(CXX_STANDARD_REQUIRED 17)

project(openMPFibonacci)

add_executable(openMPFibonacci main.cpp)
