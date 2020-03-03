#!/bin/bash

# create folder for all build solutions

mkdir -p ../build_output
cd ../build_output

# build sequential generic program
cmake ../sequential/generic
cmake --build .

# build openMP generic algorithm
cmake ../openMP/generic
cmake --build .

# build sequential fibonacci program
cmake ../sequential/fibonacci
cmake --build .

# build openMP fibonacci algorithm
cmake ../openMP/fibonacci
cmake --build .
