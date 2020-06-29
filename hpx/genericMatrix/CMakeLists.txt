cmake_minimum_required(VERSION 3.3.2)

project(hpxGenMatrix CXX)
add_definitions(-DVECTOR_SIZE=1048576)

set(CMAKE_CXX_COMPILER g++)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -lm")
set(HPX_WITH_NETWORKING OFF)
set(HPX_INSTALL_DIR "/home/tobias/Documents/Programs/hpx")
set(HPX_DIR "${HPX_INSTALL_DIR}/bin/lib/cmake/HPX")
set(CMAKE_MODULE_PATH
	${CMAKE_MODULE_PATH}
	"${HPX_INSTALL_DIR}/cmake")

find_package(HPX REQUIRED)

add_hpx_executable(hpxGenMatrix
	SOURCES main.cpp
	COMPONENT_DEPENDENCIES iostreams)
