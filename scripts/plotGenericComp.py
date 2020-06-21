import json
import matplotlib.pyplot as plt
import os
import numpy as np

path_to_data = 'metrics/'
data_file = [pos for pos in os.listdir(path_to_data) if pos.endswith('.data')]

taskSizeList = range(10, 500, 10)

def mean(in_list):
    length = len(in_list)
    tmp_sum = 0
    for position in range(length):
        tmp_sum += in_list[position]
    return tmp_sum / length


genLists = {
    "seq": [0.0] * len(taskSizeList),
    "omp": [0.0] * len(taskSizeList),
    "hpx": [0.0] * len(taskSizeList)
}

nrFiles = 0
for index, js in enumerate(data_file):
    with open(os.path.join(path_to_data, js), 'r') as j_file:
        nrFiles += 1
        temp_dict = json.load(j_file)
        for i in range(len(genLists['seq'])):
            genLists['seq'][i] += temp_dict['sequential'][i]
            genLists['omp'][i] += temp_dict['openMP'][i]
            genLists['hpx'][i] += temp_dict['hpx'][i]


for i in range(len(genLists['seq'])):
    genLists['seq'][i] = genLists['seq'][i] / nrFiles
    genLists['omp'][i] = genLists['omp'][i] / nrFiles
    genLists['hpx'][i] = genLists['hpx'][i] / nrFiles


#plt.scatter(taskSizeList, genLists['seq'])
fig = plt.figure()
#ax = fig.add_axes([0, 0, 1, 1])
ax = fig.add_subplot(1, 1, 1)
ax.scatter(taskSizeList, genLists['seq'], color='red', label='Sequential')
ax.scatter(taskSizeList, genLists['omp'], color='blue', label='OpenMP')
ax.scatter(taskSizeList, genLists['hpx'], color='green', label='HPX')
ax.set_xlabel('Task Size Parameter')
ax.set_ylabel('Execution Time')
ax.set_title('Generic Comparison')

plt.legend(loc=1)
fig.savefig("genericComp")
#plt.show()
