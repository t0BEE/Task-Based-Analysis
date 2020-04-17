#!/bin/bash

rm -r metrics
mkdir metrics

./build_spack.sh
./output.sh 20 20 22 20

for files in *.json
do
  mv $files metrics/
done
