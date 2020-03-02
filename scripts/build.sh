#!/bin/bash

# create folder for all build solutions

mkdir -p ../build_output
cd ../build_output

# build sequential program
cmake ../sequential
cmake --build .

# build openMP generic algorithm
cmake ../openMP
cmake --build .
