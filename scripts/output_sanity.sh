#!/bin/bash
CYAN='\033[0;36m'
NC='\033[0m'

if [[ "$#" -ne 4 ]]; then
	echo -e "Please provide 3 parameter"
	echo -e "1: Generic algorithm #turns"
	echo -e "2: Generic algorithm task size"
	echo -e "3: Generic algorithm task size for second run"
	echo -e "4: Number of runs"
	exit
fi

for i in $(seq 1 $4)
do

  echo "-- Turn $i --"
  echo "{" > result_$i.sanity

  # Fibonacci Execution
  echo -e -n "\t\"seqeuntial\": [" >> result_$i.sanity
  ../build_output_sanity/sequentialGeneric $1 $2 >> result_$i.sanity
  echo -n ", " >> result_$i.sanity
  ../build_output_sanity/sequentialGeneric $1 $3 >> result_$i.sanity
  echo "]," >> result_$i.sanity

  echo -e -n "\t\"omp\": [" >> result_$i.sanity
  export OMP_NUM_THREADS=1
  ../build_output_sanity/openMPGeneric $1 $2 >> result_$i.sanity
  echo -n ", " >> result_$i.sanity
  export OMP_NUM_THREADS=2
  ../build_output_sanity/openMPGeneric $1 $3 >> result_$i.sanity
  echo "]," >> result_$i.sanity
  unset OMP_NUM_THREADS
  
  echo -e -n "\t\"hpx\": [" >> result_$i.sanity
  ../build_output_sanity/hpxGeneric --turns=$1 --taskSize=$2 >> result_$i.sanity
  echo -n ", " >> result_$i.sanity
  ../build_output_sanity/hpxGeneric --turns=$1 --taskSize=$3 >> result_$i.sanity
  echo -e "]\n}" >> result_$i.sanity

done
