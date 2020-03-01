#!/bin/bash
# build openMP generic algorithm
mkdir -p ../build_output
cd ../build_output
cmake ../openMP
cmake --build .
