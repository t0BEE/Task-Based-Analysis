#!/bin/bash


# compare generic execution of sequential, OpenMP and HPX
# For different task sizes but same number of task

runList=$(seq 1 2 21)

for run in $(seq 1 50)
do
  echo "-- Run $run --"
  echo "{" > genericMatrix_$run.data
  echo -n -e "\"sequential\": [" >> genericMatrix_$run.data
  for i in ${runList[@]}
  do
    ../build_output/seqGenMatrix 50 $i >> genericMatrix_$run.data
    if [[ $i -ne 21 ]]; then
      echo -n ", " >> genericMatrix_$run.data
    else
      echo "]," >> genericMatrix_$run.data
    fi
  done

  echo -n -e "\"openMP\": [" >> genericMatrix_$run.data
  for i in ${runList[@]}
  do
    ../build_output/ompGenMatrix 50 $i >> genericMatrix_$run.data
    if [[ $i -ne 21 ]]; then
      echo -n ", " >> genericMatrix_$run.data
    else
      echo "]," >> genericMatrix_$run.data
    fi
  done

  echo -n -e "\"hpx\": [" >> genericMatrix_$run.data
  for i in ${runList[@]}
  do
    ../build_output/hpxGenMatrix 50 $i >> genericMatrix_$run.data
    if [[ $i -ne 21 ]]; then
      echo -n ", " >> genericMatrix_$run.data
    else
      echo "]" >> genericMatrix_$run.data
    fi
  done
  echo -e "}" >> genericMatrix_$run.data
done

mv *.data metrics/

# pipenv run python3 ./plotGenericComp.py

