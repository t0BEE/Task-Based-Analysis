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

  echo "- Turn $i -"
  echo "{" > result_$i.json

  # Generic Execution
  echo -e "\t\"generic\": {" >> result_$i.json
  echo -n -e "\t\t\"sequential\": " >> result_$i.json
#  echo -n -e "${CYAN}Sequential Generic: ${NC}"
#  ../build_output/sequentialGeneric $1 $2 | tee -a result_$i.json
  ../build_output/sequentialGeneric $1 $2 >> result_$i.json
  echo "," >> result_$i.json
  echo -n -e "\t\t\"openMP\": " >> result_$i.json
#  echo " "
#  echo -n -e "${CYAN}openMP Generic: ${NC}"
#  ../build_output/openMPGeneric $1 $2 | tee -a result_$i.json
  ../build_output/openMPGeneric $1 $2 >> result_$i.json
  echo " ," >> result_$i.json
  echo -n -e "\t\t\"hpx\": " >> result_$i.json
#  echo " "
#  echo -n -e "${CYAN}HPX Generic: ${NC}"
#  ../build_output/hpxGeneric --turns=$1 --taskSize=$2 | tee -a result_$i.json
  ../build_output/hpxGeneric --turns=$1 --taskSize=$2 >> result_$i.json
#  echo " "
  echo -e "\n\t}," >> result_$i.json


  # Fibonacci Execution
  echo -e "\t\"fibonacci\": {" >> result_$i.json
  echo -n -e "\t\t\"sequential\": " >> result_$i.json
#  echo -n -e "${CYAN}Sequential Fibonacci: ${NC}"
#  ../build_output/sequentialFibonacci $3 | tee -a result_$i.json
  ../build_output/sequentialFibonacci $3 >> result_$i.json
  echo " ," >> result_$i.json
  echo -n -e "\t\t\"openMP\": " >> result_$i.json
#  echo " "
#  echo -n -e "${CYAN}openMP Fibonacci: ${NC}"
#  ../build_output/openMPFibonacci $3 | tee -a result_$i.json
  ../build_output/openMPFibonacci $3 >> -a result_$i.json
  echo " ," >> result_$i.json
  echo -n -e "\t\t\"hpx\": " >> result_$i.json
#  echo " "
#  echo -n -e "${CYAN}HPX Fibonacci: ${NC}"
#  ../build_output/hpxFibonacci --n-value=$3 | tee -a result_$i.json
  ../build_output/hpxFibonacci --n-value=$3 >> result_$i.json
#  echo " "
  echo -e "\n\t}," >> result_$i.json


  # Merge Sort Execution
  echo -e "\t\"mergeSort\": {" >> result_$i.json
  echo -n -e "\t\t\"sequential\": " >> result_$i.json
#  echo -n -e "${CYAN}Sequential MergeSort: ${NC}"
#  ../build_output/sequentialMergeSort | tee -a result_$i.json
  ../build_output/sequentialMergeSort >> result_$i.json
  echo " ," >> result_$i.json
  echo -n -e "\t\t\"openMP\": " >> result_$i.json
#  echo " "
#  echo -n -e "${CYAN}openMP MergeSort: ${NC}"
#  ../build_output/openMPMergeSort | tee -a result_$i.json
  ../build_output/openMPMergeSort >> result_$i.json
  echo " ," >> result_$i.json
  echo -n -e "\t\t\"hpx\": " >> result_$i.json
#  echo " "
#  echo -n -e "${CYAN}HPX MergeSort: ${NC}"
#  ../build_output/hpxMergeSort | tee -a result_$i.json
  ../build_output/hpxMergeSort >> result_$i.json
#  echo " "
  echo -e "\n\t}\n}" >> result_$i.json
done
