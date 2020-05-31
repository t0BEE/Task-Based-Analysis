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


../build_output/sequentialGeneric 20 200 --debug

../build_output/openMPGeneric 20 200 --debug

../build_output/hpxGeneric --turns=20 --taskSize=200 --debug=1

