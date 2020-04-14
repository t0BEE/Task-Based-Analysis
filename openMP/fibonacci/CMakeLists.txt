cmake_minimum_required(VERSION 3.10)

set(CMAKE_CXX_COMPILER g++)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -lm -fopenmp -O3")
set(CXX_STANDARD_REQUIRED 17)

project(openMPFibonacci)

add_executable(openMPFibonacci main.cpp)

find_package(OpenMP REQUIRED)
if(OpenMP_CXX_FOUND)
	target_link_libraries(openMPFibonacci PUBLIC OpenMP::OpenMP_CXX)
endif()
