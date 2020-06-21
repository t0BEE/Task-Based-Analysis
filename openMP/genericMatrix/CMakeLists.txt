cmake_minimum_required(VERSION 3.10)

set(CMAKE_CXX_COMPILER g++)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -lm -fopenmp")
set(CXX_STANDARD_REQUIRED 17)

project(ompGenMatrix)
add_definitions(-DVECTOR_SIZE=1048576)

add_executable(ompGenMatrix main.cpp)

find_package(OpenMP REQUIRED)
if(OpenMP_CXX_FOUND)
	target_link_libraries(ompGenMatrix PUBLIC OpenMP::OpenMP_CXX)
endif()
