import plotly.graph_objects as go
import json
import os
import pandas as pd

path_to_json = 'metrics/'
json_files = [pos for pos in os.listdir(path_to_json) if pos.endswith('.json')]


def mean(in_list):
    length = len(in_list)
    tmp_sum = 0
    for position in range(length):
        tmp_sum += in_list[position]
    return tmp_sum / length


benchmark_metrics = {
    "generic_seq": [],
    "generic_omp": [],
    "generic_hpx": [],
    "fibonacci_seq": [],
    "fibonacci_omp": [],
    "fibonacci_hpx": [],
    "mergeSort_seq": [],
    "mergeSort_omp": [],
    "mergeSort_hpx": []
}

for index, js in enumerate(json_files):
    with open(os.path.join(path_to_json, js), 'r') as j_file:
        temp_dict = json.load(j_file)
        benchmark_metrics["generic_seq"].append(temp_dict['generic']['sequential'])
        benchmark_metrics["generic_omp"].append(temp_dict['generic']['openMP'])
        benchmark_metrics["generic_hpx"].append(temp_dict['generic']['hpx'])
        benchmark_metrics["fibonacci_seq"].append(temp_dict['fibonacci']['sequential'])
        benchmark_metrics["fibonacci_omp"].append(temp_dict['fibonacci']['openMP'])
        benchmark_metrics["fibonacci_hpx"].append(temp_dict['fibonacci']['hpx'])
        benchmark_metrics["mergeSort_seq"].append(temp_dict['mergeSort']['sequential'])
        benchmark_metrics["mergeSort_omp"].append(temp_dict['mergeSort']['openMP'])
        benchmark_metrics["mergeSort_hpx"].append(temp_dict['mergeSort']['hpx'])


generic_mean_values = [mean(benchmark_metrics["generic_seq"]), mean(benchmark_metrics["generic_omp"]),
                       mean(benchmark_metrics["generic_hpx"])]
fib_mean_values = [mean(benchmark_metrics["fibonacci_seq"]), mean(benchmark_metrics["fibonacci_omp"]),
                   mean(benchmark_metrics["fibonacci_hpx"])]
mergSort_mean_values = [mean(benchmark_metrics["mergeSort_seq"]), mean(benchmark_metrics["mergeSort_omp"]),
                        mean(benchmark_metrics["mergeSort_hpx"])]

fig = go.Figure(
    data=[go.Bar(y=[generic_mean_values[0], generic_mean_values[1], generic_mean_values[2]],
                 x=['Sequential', 'openMP', 'HPX'],
                 text=[generic_mean_values[0], generic_mean_values[1], generic_mean_values[2]],
                 textposition='auto')],
    layout_title_text="Generic Algorithm run time in milliseconds"
)
fig.show()

fig = go.Figure(
    data=[go.Bar(y=[fib_mean_values[0], fib_mean_values[1], fib_mean_values[2]],
                 x=['Sequential', 'openMP', 'HPX'],
                 text=[fib_mean_values[0], fib_mean_values[1], fib_mean_values[2]],
                 textposition='auto')],
    layout_title_text="Fibonacci Algorithm run time in milliseconds"
)
fig.show()

fig = go.Figure(
    data=[go.Bar(y=[mergSort_mean_values[0], mergSort_mean_values[1], mergSort_mean_values[2]],
                 x=['Sequential', 'openMP', 'HPX'],
                 text=[mergSort_mean_values[0], mergSort_mean_values[1], mergSort_mean_values[2]],
                 textposition='auto')],
    layout_title_text="Merge Sort run time in milliseconds"
)
fig.show()

