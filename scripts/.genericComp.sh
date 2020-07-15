#!/bin/bash


# compare generic execution of sequential, OpenMP and HPX
# For different task sizes

runList=$(seq 10 10 500)

for run in $(seq 1 50)
do
  echo "-- Run $run --"
  echo "{" > genericComp_$run.data
  echo -n -e "\"sequential\": [" >> genericComp_$run.data
  for i in ${runList[@]}
  do
    ../build_output/sequentialGeneric 50 $i >> genericComp_$run.data
    if [[ $i -ne 500 ]]; then
      echo -n ", " >> genericComp_$run.data
    else
      echo "]," >> genericComp_$run.data
    fi
  done

  echo -n -e "\"openMP\": [" >> genericComp_$run.data
  for i in ${runList[@]}
  do
    ../build_output/openMPGeneric 50 $i >> genericComp_$run.data
    if [[ $i -ne 500 ]]; then
      echo -n ", " >> genericComp_$run.data
    else
      echo "]," >> genericComp_$run.data
    fi
  done

  echo -n -e "\"hpx\": [" >> genericComp_$run.data
  for i in ${runList[@]}
  do
    ../build_output/hpxGeneric 50 $i >> genericComp_$run.data
    if [[ $i -ne 500 ]]; then
      echo -n ", " >> genericComp_$run.data
    else
      echo "]" >> genericComp_$run.data
    fi
  done
  echo -e "}" >> genericComp_$run.data
done

mv *.data metrics/

# pipenv run python3 ./plotGenericComp.py

