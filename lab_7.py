

from bokeh.plotting import curdoc, figure,show
from bokeh.layouts import column
from bokeh.models import Select
import numpy as np
x=np.linspace(0,2*np.pi,100)
y=np.sin(x)
plot=figure(title="1NT22CS002 Aashutosh",height=300,width=600,y_range=(-1.1,1.1))
line=plot.line(x,y,line_width=2)
dropdown_options=["sin(x)","cos(x)","tan(x)"]
dropdown=Select(title="Function",value="sin(x)",options=dropdown_options)
def update_plot(attrname,old,new):
    if dropdown.value=="sin(x)":
        y=np.sin(x)
    elif dropdown.value=="cos(x)":
        y=np.cos(x)
    else:
        y=np.tan(x)
        line.data_source.data['y']=y
dropdown.on_change('value',update_plot)
layout=column(dropdown,plot)
curdoc().add_root(layout)
show(layout)

