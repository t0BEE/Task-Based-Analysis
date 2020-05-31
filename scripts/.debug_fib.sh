#!/bin/bash

CYAN='\033[0;36m'
NC='\033[0m'

# clear and create folder for all build solutions
rm -r ../build_output
mkdir ../build_output
cd ../build_output

# build sequential fibonacci program
echo -e "--- ${CYAN}Build sequential fibonacci algorithm ${NC}---"
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


../build_output/sequentialFibonacci 22 --debug

../build_output/openMPFibonacci 22 --debug

../build_output/hpxFibonacci --n-value=22 --debug=1

