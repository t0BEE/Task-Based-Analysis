#!/bin/bash
CYAN='\033[0;36m'
NC='\033[0m'

if [[ "$#" -ne 3 ]]; then
	echo -e "Please provide 3 parameter"
	echo -e "1: Generic algorithm #turns"
	echo -e "2: Generic algorithm task size"
	echo -e "3: Fibonacci number to calculate"
	exit
fi

echo "{" > result.json

# Generic Execution
echo -e "\t\"generic\": {" >> result.json
echo -n -e "\t\t\"sequential\": " >> result.json
echo -n -e "${CYAN}Sequential Generic: ${NC}"
../build_output/sequentialGeneric $1 $2 | tee -a result.json
echo "," >> result.json
echo -n -e "\t\t\"openMP\": " >> result.json
echo " "
echo -n -e "${CYAN}openMP Generic: ${NC}"
../build_output/openMPGeneric $1 $2 | tee -a result.json
echo " ," >> result.json
echo -n -e "\t\t\"hpx\": " >> result.json
echo " "
echo -n -e "${CYAN}HPX Generic: ${NC}"
../build_output/hpxGeneric --turns=$1 --taskSize=$2 | tee -a result.json
echo " "
echo -e "\n\t}," >> result.json


# Fibonacci Execution
echo -e "\t\"fibonacci\": {" >> result.json
echo -n -e "\t\t\"sequential\": " >> result.json
echo -n -e "${CYAN}Sequential Fibonacci: ${NC}"
../build_output/sequentialFibonacci $3 | tee -a result.json
echo " ," >> result.json
echo -n -e "\t\t\"openMP\": " >> result.json
echo " "
echo -n -e "${CYAN}openMP Fibonacci: ${NC}"
../build_output/openMPFibonacci $3 | tee -a result.json
echo " ," >> result.json
echo -n -e "\t\t\"hpx\": " >> result.json
echo " "
echo -n -e "${CYAN}HPX Fibonacci: ${NC}"
../build_output/hpxFibonacci --n-value=$3 | tee -a result.json
echo " "
echo -e "\n\t}," >> result.json


# Merge Sort Execution
echo -e "\t\"mergeSort\": {" >> result.json
echo -n -e "\t\t\"sequential\": " >> result.json
echo -n -e "${CYAN}Sequential MergeSort: ${NC}"
../build_output/sequentialMergeSort | tee -a result.json
echo " ," >> result.json
echo -n -e "\t\t\"openMP\": " >> result.json
echo " "
echo -n -e "${CYAN}openMP MergeSort: ${NC}"
../build_output/openMPMergeSort | tee -a result.json
echo " ," >> result.json
echo -n -e "\t\t\"hpx\": " >> result.json
echo " "
echo -n -e "${CYAN}HPX MergeSort: ${NC}"
../build_output/hpxMergeSort | tee -a result.json
echo " "
echo -e "\n\t}\n}" >> result.json
