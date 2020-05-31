#!/bin/bash
CYAN='\033[0;36m'
NC='\033[0m'

if [[ "$#" -ne 3 ]]; then
	echo -e "Please provide 4 parameter"
	echo -e "1: Generic algorithm #turns"
	echo -e "2: Generic algorithm task size"
	echo -e "3: Number of runs"
	exit
fi

for i in $(seq 1 $4)
do

  echo "{" > generic$2_result_$i.json

  # Generic Execution
  echo -e "\t\"generic\": {" >> generic$2_result_$i.json
  echo -n -e "\t\t\"sequential\": " >> generic$2_result_$i.json
  echo -n -e "${CYAN}Sequential Generic: ${NC}"
  ../build_output/sequentialGeneric $1 $2 | tee -a generic$2_result_$i.json
  echo "," >> generic$2_result_$i.json
  echo -n -e "\t\t\"openMP\": " >> generic$2_result_$i.json
  echo " "
  echo -n -e "${CYAN}openMP Generic: ${NC}"
  ../build_output/openMPGeneric $1 $2 | tee -a generic$2_result_$i.json
  echo " ," >> generic$2_result_$i.json
  echo -n -e "\t\t\"hpx\": " >> generic$2_result_$i.json
  echo " "
  echo -n -e "${CYAN}HPX Generic: ${NC}"
  ../build_output/hpxGeneric --turns=$1 --taskSize=$2 | tee -a generic$2_result_$i.json
  echo " "
  echo -e "\n\t}," >> generic$2_result_$i.json
done
