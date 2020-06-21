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

# build hpx generic algorithm
echo -e "--- ${CYAN}Build HPX generic algorithm ${NC}---"
rm ../build_output/CMakeCache.txt
g++ -o hpxGeneric ../hpx/generic/main.cpp -pthread -O3 -l hpx -l hpx_iostreams -l boost_program_options

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

# build hpx fibonacci algorithm
echo -e "--- ${CYAN}Build HPX fibonacci algorithm ${NC}---"
rm ../build_output/CMakeCache.txt
g++ -o hpxFibonacci ../hpx/fibonacci/main.cpp -pthread -O3 -l hpx -l hpx_iostreams -l boost_program_options

# build sequential mergesort program
echo -e "--- ${CYAN}Build sequential mergesort algorithm ${NC}---"
rm ../build_output/CMakeCache.txt
cmake ../sequential/mergeSort
cmake --build .

# build openMP mergesort program
echo -e "--- ${CYAN}Build openMP mergesort algorithm ${NC}---"
rm ../build_output/CMakeCache.txt
cmake ../openMP/mergeSort
cmake --build .

# build hpx mergesort algorithm
echo -e "--- ${CYAN}Build HPX mergesort algorithm ${NC}---"
rm ../build_output/CMakeCache.txt
g++ -o hpxMergeSort ../hpx/mergeSort/main.cpp -pthread -O3 -l hpx -l hpx_iostreams -l boost_program_options

# build sequential generic Matrix program
echo -e "--- ${CYAN}Build sequential generic matrix ${NC}---"
rm ../build_output/CMakeCache.txt
cmake ../sequential/genericMatrix
cmake --build .

# build openMP generic Matrix algorithm
echo -e "--- ${CYAN}Build openMP generic matrix ${NC}---"
rm ../build_output/CMakeCache.txt
cmake ../openMP/genericMatrix
cmake --build .

# build hpx generic Matrix algorithm
echo -e "--- ${CYAN}Build HPX generic matrix ${NC}---"
rm ../build_output/CMakeCache.txt
g++ -o hpxGenMatrix ../hpx/genericMatrix/main.cpp -pthread -O3 -l hpx -l hpx_iostreams -l boost_program_options
