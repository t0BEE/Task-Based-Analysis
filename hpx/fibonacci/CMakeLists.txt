cmake_minimum_required(VERSION 3.3.2)

project(hpxFibonacci CXX)

set(CMAKE_CXX_COMPILER g++)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -lm")
set(HPX_WITH_NETWORKING OFF)

# HPX_DIR and HPX_INSTALL_DIR are defined as environment variables

set(CMAKE_MODULE_PATH
	${CMAKE_MODULE_PATH}
	"${HPX_INSTALL_DIR}/cmake")

find_package(HPX REQUIRED)

add_hpx_executable(hpxFibonacci
	SOURCES main.cpp
	COMPONENT_DEPENDENCIES iostreams)
