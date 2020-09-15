#!/bin/bash
CYAN='\033[0;36m'
NC='\033[0m'

if [[ "$#" -ne 4 ]]; then
	echo -e "Please provide 4 parameter"
	echo -e "1: Generic algorithm #turns"
	echo -e "2: Generic algorithm task size"
	echo -e "3: Fibonacci number to calculate"
	echo -e "4: Number of runs"
	exit
fi

for i in $(seq 1 $4)
do

  echo "-- Turn $i --"
  echo "{" > result_$i.epyc
  echo -e "\t\"generic\":{" >> result_$i.epyc

  # Generic Execution
  echo -n -e "\t\t\"local-priority-fifo\": " >> result_$i.epyc
  ../build_output_epyc/hpxGeneric --turns=$1 --taskSize=$2 --hpx:queuing=local-priority-fifo >> result_$i.epyc
  echo "," >> result_$i.epyc

  echo -n -e "\t\t\"local-priority-lifo\": " >> result_$i.epyc
  ../build_output_epyc/hpxGeneric --turns=$1 --taskSize=$2 --hpx:queuing=local-priority-lifo >> result_$i.epyc
  echo "," >> result_$i.epyc

  echo -n -e "\t\t\"static-priority\": " >> result_$i.epyc
  ../build_output_epyc/hpxGeneric --turns=$1 --taskSize=$2 --hpx:queuing=static-priority >> result_$i.epyc
  echo "," >> result_$i.epyc

  echo -n -e "\t\t\"local\": " >> result_$i.epyc
  ../build_output_epyc/hpxGeneric --turns=$1 --taskSize=$2 --hpx:queuing=local >> result_$i.epyc
  echo "," >> result_$i.epyc

  echo -n -e "\t\t\"static\": " >> result_$i.epyc
  ../build_output_epyc/hpxGeneric --turns=$1 --taskSize=$2 --hpx:queuing=static >> result_$i.epyc
  echo "," >> result_$i.epyc

  echo -n -e "\t\t\"abp-priority-fifo\": " >> result_$i.epyc
  ../build_output_epyc/hpxGeneric --turns=$1 --taskSize=$2 --hpx:queuing=abp-priority-fifo >> result_$i.epyc
  echo "," >> result_$i.epyc

  echo -n -e "\t\t\"abp-priority-lifo\": " >> result_$i.epyc
  ../build_output_epyc/hpxGeneric --turns=$1 --taskSize=$2 --hpx:queuing=abp-priority-lifo >> result_$i.epyc

  echo -e "\n\t}," >> result_$i.epyc
  # Fibonacci Execution
  echo -e "\t\"fib\":{" >> result_$i.epyc

  echo -n -e "\t\t\"local-priority-fifo\": " >> result_$i.epyc
  ../build_output_epyc/hpxFibonacci --n-value=$3 --hpx:queuing=local-priority-fifo >> result_$i.epyc
  echo "," >> result_$i.epyc

  echo -n -e "\t\t\"local-priority-lifo\": " >> result_$i.epyc
  ../build_output_epyc/hpxFibonacci --n-value=$3 --hpx:queuing=local-priority-lifo >> result_$i.epyc
  echo "," >> result_$i.epyc

  echo -n -e "\t\t\"static-priority\": " >> result_$i.epyc
  ../build_output_epyc/hpxFibonacci --n-value=$3 --hpx:queuing=static-priority >> result_$i.epyc
  echo "," >> result_$i.epyc

  echo -n -e "\t\t\"local\": " >> result_$i.epyc
  ../build_output_epyc/hpxFibonacci --n-value=$3 --hpx:queuing=local >> result_$i.epyc
  echo "," >> result_$i.epyc

  echo -n -e "\t\t\"static\": " >> result_$i.epyc
  ../build_output_epyc/hpxFibonacci --n-value=$3 --hpx:queuing=static >> result_$i.epyc
  echo "," >> result_$i.epyc

  echo -n -e "\t\t\"abp-priority-fifo\": " >> result_$i.epyc
  ../build_output_epyc/hpxFibonacci --n-value=$3 --hpx:queuing=abp-priority-fifo >> result_$i.epyc
  echo "," >> result_$i.epyc

  echo -n -e "\t\t\"abp-priority-lifo\": " >> result_$i.epyc
  ../build_output_epyc/hpxFibonacci --n-value=$3 --hpx:queuing=abp-priority-lifo >> result_$i.epyc

  echo -e "\n\t}," >> result_$i.epyc
  # Merge Sort Execution
  echo -e "\t\"sort\":{" >> result_$i.epyc

  echo -n -e "\t\t\"local-priority-fifo\": " >> result_$i.epyc
  ../build_output_epyc/hpxMergeSort --hpx:queuing=local-priority-fifo >> result_$i.epyc
  echo "," >> result_$i.epyc

  echo -n -e "\t\t\"local-priority-lifo\": " >> result_$i.epyc
  ../build_output_epyc/hpxMergeSort --hpx:queuing=local-priority-lifo >> result_$i.epyc
  echo "," >> result_$i.epyc

  echo -n -e "\t\t\"static-priority\": " >> result_$i.epyc
  ../build_output_epyc/hpxMergeSort --hpx:queuing=static-priority >> result_$i.epyc
  echo "," >> result_$i.epyc

  echo -n -e "\t\t\"local\": " >> result_$i.epyc
  ../build_output_epyc/hpxMergeSort --hpx:queuing=local >> result_$i.epyc
  echo "," >> result_$i.epyc

  echo -n -e "\t\t\"static\": " >> result_$i.epyc
  ../build_output_epyc/hpxMergeSort --hpx:queuing=static >> result_$i.epyc
  echo "," >> result_$i.epyc

  echo -n -e "\t\t\"abp-priority-fifo\": " >> result_$i.epyc
  ../build_output_epyc/hpxMergeSort --hpx:queuing=abp-priority-fifo >> result_$i.epyc
  echo "," >> result_$i.epyc

  echo -n -e "\t\t\"abp-priority-lifo\": " >> result_$i.epyc
  ../build_output_epyc/hpxMergeSort --hpx:queuing=abp-priority-lifo >> result_$i.epyc

  echo -e "\n\t}" >> result_$i.epyc

  echo -e "\n}" >> result_$i.epyc
done
