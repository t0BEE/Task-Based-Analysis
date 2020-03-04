#!/bin/bash
CYAN='\033[0;36m'
NC='\033[0m'

# clear and create folder for all build solutions
rm -r ../build_output
mkdir ../build_output
cd ../build_output

# build sequential generic program
echo -e "--- ${CYAN}Build sequential generic algorithm ${NC}---"
cmake ../sequential/generic
cmake --build .

# build openMP generic algorithm
echo -e "--- ${CYAN}Build openMP generic algorithm ${NC}---"
rm ../build_output/CMakeCache.txt
cmake ../openMP/generic
cmake --build .

# build sequential fibonacci program
echo -e "--- ${CYAN}Build sequential fibonacci algorithm ${NC}---"
rm ../build_output/CMakeCache.txt
cmake ../sequential/fibonacci
cmake --build .

# build openMP fibonacci algorithm
echo -e "--- ${CYAN}Build openMP fibonacci algorithm ${NC}---"
rm ../build_output/CMakeCache.txt
cmake ../openMP/fibonacci
cmake --build .

# build sequential mergesort program
echo -e "--- ${CYAN}Build sequential mergesort algorithm ${NC}---"
rm ../build_output/CMakeCache.txt
cmake ../sequential/mergeSort
cmake --build .
