import json
import matplotlib.pyplot as plt
import os
import numpy as np

path_to_data = 'metrics/'
data_file = [pos for pos in os.listdir(path_to_data) if pos.endswith('.data')]

def mean(in_list):
    length = len(in_list)
    tmp_sum = 0
    for position in range(length):
        tmp_sum += in_list[position]
    return tmp_sum / length

genLists = {
    "seq": [],
    "omp": [],
    "hpx": []
}

for index, js in enumerate(data_file):
    with open(os.path.join(path_to_data, js), 'r') as j_file:
        temp_dict = json.load(j_file)
        genLists["seq"].extend(temp_dict['sequential'])
        genLists["omp"].extend(temp_dict['openMP'])
        genLists["hpx"].extend(temp_dict['hpx'])

