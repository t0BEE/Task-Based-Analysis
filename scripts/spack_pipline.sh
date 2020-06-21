#!/bin/bash

rm -r metrics
mkdir metrics

./.build_spack.sh
echo "--- Algorithm Comparison ---"
./output.sh 20 20 22 100

for files in *.json
do
  mv $files metrics/
done

#pipenv run python3 ./plot.py


echo "--- Generic Comp ---"
./.genericComp

