#!/bin/bash

rm -r metrics
mkdir metrics

./.build_spack.sh
./output.sh 20 20 22 10

for files in *.json
do
  mv $files metrics/
done

pipenv run python3 ./plot.py


# compare generic execution of sequential, OpenMP and HPX
# For different task sizes

for run in $(seq 1 20)
do
  echo "{" > genericComp_$run.data
  echo -n -e "\"sequential\": [" >> genericComp_$run.data
  for i in 1 4 10 20 100 200
  do
    ../build_output/sequentialGeneric 50 $i >> genericComp_$run.data
    if [[ $i -ne 200 ]]; then
      echo -n ", " >> genericComp_$run.data
    else
      echo "]," >> genericComp_$run.data
    fi
  done

  echo -n -e "\"openMP\": [" >> genericComp_$run.data
  for i in 1 4 10 20 100 200
  do
    ../build_output/openMPGeneric 50 $i >> genericComp_$run.data
    if [[ $i -ne 200 ]]; then
      echo -n ", " >> genericComp_$run.data
    else
      echo "]," >> genericComp_$run.data
    fi
  done

  echo -n -e "\"hpx\": [" >> genericComp_$run.data
  for i in 1 4 10 20 100 200
  do
    ../build_output/hpxGeneric 50 $i >> genericComp_$run.data
    if [[ $i -ne 200 ]]; then
      echo -n ", " >> genericComp_$run.data
    else
      echo "]" >> genericComp_$run.data
    fi
  done
  echo -e "}" >> genericComp_$run.data
done

mv *.data metrics/

pipenv run python3 ./plotGenericComp.py

