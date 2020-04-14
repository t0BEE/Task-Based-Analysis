import plotly.graph_objects as go
import json

with open('result.json', 'r') as f:
    result_dict = json.load(f)


fig = go.Figure(
            data=[go.Bar(y=[result_dict['generic']['sequential'], result_dict['generic']['openMP'], result_dict['generic']['hpx']])],
                layout_title_text="Generic Algorithm run time in milliseconds"
                )


fig.show()

