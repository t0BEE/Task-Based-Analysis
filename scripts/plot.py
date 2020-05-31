import matplotlib.pyplot as plt
import json
import os
import numpy as np

path_to_json = 'metrics/'
json_files = [pos for pos in os.listdir(path_to_json) if pos.endswith('.json')]


def mean(in_list):
    length = len(in_list)
    tmp_sum = 0
    for position in range(length):
        tmp_sum += in_list[position]
    return tmp_sum / length


benchMetr = {
    "generic_seq": [],
    "generic_omp": [],
    "generic_hpx": [],
    "fib_seq": [],
    "fib_omp": [],
    "fib_hpx": [],
    "mSort_seq": [],
    "mSort_omp": [],
    "mSort_hpx": []
}

for index, js in enumerate(json_files):
    with open(os.path.join(path_to_json, js), 'r') as j_file:
        temp_dict = json.load(j_file)
        benchMetr["generic_seq"].append(temp_dict['generic']['sequential'])
        benchMetr["generic_omp"].append(temp_dict['generic']['openMP'])
        benchMetr["generic_hpx"].append(temp_dict['generic']['hpx'])
        benchMetr["fib_seq"].append(temp_dict['fibonacci']['sequential'])
        benchMetr["fib_omp"].append(temp_dict['fibonacci']['openMP'])
        benchMetr["fib_hpx"].append(temp_dict['fibonacci']['hpx'])
        benchMetr["mSort_seq"].append(temp_dict['mergeSort']['sequential'])
        benchMetr["mSort_omp"].append(temp_dict['mergeSort']['openMP'])
        benchMetr["mSort_hpx"].append(temp_dict['mergeSort']['hpx'])


tableData = [[(np.mean(benchMetr['generic_seq']), np.std(benchMetr['generic_seq']), np.var(benchMetr['generic_seq'])),
              (np.mean(benchMetr['generic_omp']), np.std(benchMetr['generic_omp']), np.var(benchMetr['generic_omp'])),
              (np.mean(benchMetr['generic_hpx']), np.std(benchMetr['generic_hpx']), np.var(benchMetr['generic_hpx']))],
             [(np.mean(benchMetr['fib_seq']), np.std(benchMetr['fib_seq']), np.var(benchMetr['fib_seq'])),
              (np.mean(benchMetr['fib_omp']), np.std(benchMetr['fib_omp']), np.var(benchMetr['fib_omp'])),
              (np.mean(benchMetr['fib_hpx']), np.std(benchMetr['fib_hpx']), np.var(benchMetr['fib_hpx']))],
             [(np.mean(benchMetr['mSort_seq']), np.std(benchMetr['mSort_seq']), np.var(benchMetr['mSort_seq'])),
              (np.mean(benchMetr['mSort_omp']), np.std(benchMetr['mSort_omp']), np.var(benchMetr['mSort_omp'])),
              (np.mean(benchMetr['mSort_hpx']), np.std(benchMetr['mSort_hpx']), np.var(benchMetr['mSort_hpx']))]]

meanData = [[np.mean(benchMetr['generic_seq']), np.mean(benchMetr['generic_omp']), np.mean(benchMetr['generic_hpx'])],
            [np.mean(benchMetr['fib_seq']), np.mean(benchMetr['fib_omp']), np.mean(benchMetr['fib_hpx'])],
            [np.mean(benchMetr['mSort_seq']), np.mean(benchMetr['mSort_omp']), np.mean(benchMetr['mSort_hpx'])]]

stdData = [[np.std(benchMetr['generic_seq']), np.std(benchMetr['generic_omp']), np.std(benchMetr['generic_hpx'])],
           [np.std(benchMetr['fib_seq']), np.std(benchMetr['fib_omp']), np.std(benchMetr['fib_hpx'])],
           [np.std(benchMetr['mSort_seq']), np.std(benchMetr['mSort_omp']), np.std(benchMetr['mSort_hpx'])]]

varData = [[np.var(benchMetr['generic_seq']), np.var(benchMetr['generic_omp']), np.var(benchMetr['generic_hpx'])],
           [np.var(benchMetr['fib_seq']), np.var(benchMetr['fib_omp']), np.var(benchMetr['fib_hpx'])],
           [np.var(benchMetr['mSort_seq']), np.var(benchMetr['mSort_omp']), np.var(benchMetr['mSort_hpx'])]]

fig1, ax1 = plt.subplots()
ax1.boxplot([benchMetr['generic_seq'], benchMetr['generic_omp'], benchMetr['generic_hpx']])
ax1.yaxis.grid(True, linestyle='-', which='major', color='lightgrey', alpha=0.5)
ax1.set_title('Generic Algorithm Execution Time')
ax1.set_ylabel('Execution Time in Milliseconds')
ax1.set_xticklabels(['Sequential', 'OpenMP', 'HPX'])

fig1.savefig("plot1")

fig2, ax2 = plt.subplots()
ax2.boxplot([benchMetr['fib_seq'], benchMetr['fib_omp'], benchMetr['fib_hpx']])
ax2.yaxis.grid(True, linestyle='-', which='major', color='lightgrey', alpha=0.5)
ax2.set_title('Fibonacci Algorithm Execution Time')
ax2.set_ylabel('Execution Time in Milliseconds')
ax2.set_xticklabels(['Sequential', 'OpenMP', 'HPX'])

fig2.savefig("plot2")

fig3, ax3 = plt.subplots()
ax3.boxplot([benchMetr['mSort_seq'], benchMetr['mSort_omp'], benchMetr['mSort_hpx']])
ax3.yaxis.grid(True, linestyle='-', which='major', color='lightgrey', alpha=0.5)
ax3.set_title('Merge Sort Execution Time')
ax3.set_ylabel('Execution Time in Milliseconds')
ax3.set_xticklabels(['Sequential', 'OpenMP', 'HPX'])

fig3.savefig("plot3")

fig4, ax4 = plt.subplots()
fig4.patch.set_visible(False)
ax4.axis('off')
ax4.axis('tight')
ax4.table(cellText=np.round(meanData, decimals=2), rowLabels=['Generic', 'Fibonacci', 'MergeSort'],
          colLabels=['Sequential', 'OpenMP', 'HPX'], loc='center')
fig4.savefig("table1")

fig5, ax5 = plt.subplots()
fig5.patch.set_visible(False)
ax5.axis('off')
ax5.axis('tight')
ax5.table(cellText=np.round(stdData, decimals=2), rowLabels=['Generic', 'Fibonacci', 'MergeSort'],
          colLabels=['Sequential', 'OpenMP', 'HPX'], loc='center')
fig5.savefig("table2")

fig6, ax6 = plt.subplots()
fig6.patch.set_visible(False)
ax6.axis('off')
ax6.axis('tight')
ax6.table(cellText=np.round(varData, decimals=2), rowLabels=['Generic', 'Fibonacci', 'MergeSort'],
          colLabels=['Sequential', 'OpenMP', 'HPX'], loc='center')
fig6.savefig("table3")

#plt.show()



