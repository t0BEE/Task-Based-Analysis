#!/bin/bash
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}Sequential Generic${NC}"
../build_output/sequentialGeneric 10 10 | tee output.csv
echo -e " ," >> output.csv
echo -e "${CYAN}openMP Generic${NC}"
../build_output/openMPGeneric 10 10 | tee -a output.csv
echo -e " ," >> output.csv
echo -e "${CYAN}HPX Generic${NC}"
../build_output/hpxGeneric --turns=10 --taskSize=10 | tee -a output.csv
echo -e " \n" >> output.csv
echo -e "${CYAN}Sequential Fibonacci${NC}"
../build_output/sequentialFibonacci 20 | tee -a output.csv
echo -e " ," >> output.csv
echo -e "${CYAN}openMP Fibonacci${NC}"
../build_output/openMPFibonacci 20 | tee -a output.csv
echo -e " ," >> output.csv
echo -e "${CYAN}HPX Fibonacci${NC}"
../build_output/hpxFibonacci --n-value=20 | tee -a output.csv
echo -e " \n" >> output.csv
echo -e "${CYAN}Sequential MergeSort${NC}"
../build_output/sequentialMergeSort | tee -a output.csv
echo -e " ," >> output.csv
echo -e "${CYAN}openMP MergeSort${NC}"
../build_output/openMPMergeSort | tee -a output.csv
echo -e " ," >> output.csv
echo -e "${CYAN}HPX MergeSort${NC}"
../build_output/hpxMergeSort | tee -a output.csv
