#!/bin/bash

rm -r metrics
mkdir metrics

./.build_spack.sh
./output.sh 20 20 22 10
#./.generic_output.sh 20 100 10

for files in *.json
do
  mv $files metrics/
done

pipenv run python3 ./plot.py

