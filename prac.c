/*
L_1a

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
cs=pd.read_csv('cars.csv')
cs.head()

fuel=cs['Fuel_Type']
prices=cs['Price']
plt.bar(fuel,prices,color="skyblue")
plt.xlabel("Fuel Type")
plt.ylabel("Price($)")
plt.title("[Price vs Fuel]1NT22CS002: Aashutosh")
plt.xticks(rotation=45,ha="right")
plt.tight_layout()
plt.show()

L_1b

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
cr=pd.read_csv("cars.csv")
x=cr['Age']
y=cr['Price']
fig,ax=plt.subplots()
plt.scatter(x,y,color="red",marker="^",s=20)
plt.xlabel("Age")
plt.ylabel("Price")
plt.title("1NT22CS002 Aashutosh")

L_2a

import matplotlib.pyplot as plt
sub=['Physics','Maths','C Language','electronics','english']
marks=[91,98,87,96,85]
plt.plot(sub,marks)
plt.xlabel('subjects')
plt.ylabel('marks')
plt.title('1NT22CS002:Aashutosh')
plt.show()

L_2b

import matplotlib.pyplot as plt
sub = ['Physics', 'Maths', 'C Language', 'Electronics', 'English']
marks = [91, 98, 87, 96, 86]
plt.plot(sub, marks, marker='o', color='b', linestyle='-', linewidth=2)
plt.xlabel('Subjects')
plt.ylabel('Marks')
plt.title('1NT22CS002:Aashutosh')
plt.show()

L_3

import matplotlib.pyplot as plt
import pandas as pd
df=pd.read_csv("flights.csv")
hour_data=df['hour']
plt.hist(hour_data, bins=24,edgecolor='c',alpha=1)
plt.xlabel("Hour of the day")
plt.ylabel("Frequency")
plt.title("1NT22CS002 Aashutosh")
plt.grid(True)

L_4

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt

df=pd.read_csv('flights.csv')
carrier_counts=df['carrier'].value_counts()
plt.pie(carrier_counts,labels=carrier_counts.index,autopct='%1.1f%%',startangle=80)
plt.title("1NT22CS002 Aashutosh")
plt.show()

L_5

import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from matplotlib import pyplot as plt
import seaborn as sns
sl=pd.read_csv("sales1.csv")
sl.head()
sns.regplot(x="Units",y="Unit Price",data=sl,color="r",marker="+",scatter_kws={'color':'green'})
plt.title("1NT22CS002 Aashutosh-Regression Plot",fontsize=15)
plt.xlabel("Units (ut)")
plt.ylabel("Unit Price ($)")
plt.show()

L_6

from bokeh.plotting import figure,curdoc,show
from bokeh.models import ColumnDataSource
import numpy as np
x=np.random.randn(100)
y=np.random.randn(100)
source=ColumnDataSource(data=dict(x=x,y=y))
plot=figure(title="",height=400,width=500)
plot.line('x','y',source=source,color="blue",alpha=0.5,line_width=2,legend_label="Y vs X")
curdoc().add_root(plot)
show(plot)

L_7

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

L_8

import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from PIL import Image
from matplotlib import cm
# Read the image
image = plt.imread("1716193413237.jpg")
image_array = np.array(image)
plt.figure(figsize=(8,8))
plt.imshow(image_array)
plt.title("")
plt.axis("off")
plt.show()
gray_img_array = np.mean(image_array,axis=-1,dtype=int)
plt.figure(figsize=(8,8))
plt.imshow(gray_img_array,cmap="gray")
plt.title("1NT22CS002 Aashutosh")
plt.axis("off")
plt.show()

#Grayscale of img
fig = plt.figure(figsize=(7,7))
ax=fig.add_subplot(111,projection="3d")
x,y=np.meshgrid(np.arange(gray_img_array.shape[1]),np.arange(gray_img_array.shape[0]))
z=gray_img_array
ax.plot_surface(x,y,z,cmap=cm.gray,linewidth=0,antialiased=False)
ax.set_xlabel("X")
ax.set_ylabel("Y")
ax.set_zlabel("Intensity")
plt.title("")
plt.show()

#Sine wave of img
fig = plt.figure(figsize=(7,7))
ax=fig.add_subplot(111,projection="3d")
x=np.linspace(0,10,100)
y=np.linspace(0,10,100)
x,y=np.meshgrid(x,y)
z=np.sin(np.sqrt(x**2+y**2))
ax.plot_surface(x,y,z,cmap=cm.viridis,linewidth=0,antialiased=False)
ax.set_xlabel("X")
ax.set_ylabel("Y")
ax.set_zlabel("Z")
plt.title("")
plt.show()

L_9

import plotly.graph_objects as go
data=[{"x": [1, 2, 3, 4, 5], "y": [6, 7, 8, 9, 10]},{"x":[6, 7, 8, 9, 10],"y": [1, 2, 3, 4, 5]}]
fig = go.Figure()
for i in range(len(data)):
    fig.add_trace(go.Scatter(x=data[i]["x"], y=data[i]["y"],mode='lines+markers'))
    fig.update_layout(title="Aashutosh", xaxis_title="time",yaxis_title="value")
fig.show()

import pandas as pd
import plotly.graph_objects as go
dat=pd.read_csv("sales1.csv")
fig=go.Figure()
fig.update_layout(title="Aashutosh", xaxis_title="order dates",yaxis_title="value")
fig.add_trace(go.Scatter(x=dat.iloc[0:,0],y=dat.iloc[5:,5],mode="lines+markers"))
fig.add_trace(go.Scatter(x=dat.iloc[0:,0],y=dat.iloc[4:,4],mode="lines+markers"))
fig.update_layout(title="Aashutosh", xaxis_title="order dates",yaxis_title="value")
fig.show()

L_10

import pandas as pd
import plotly.express as px
election=pd.read_csv("election.csv")
election=election[0:500]
fig=px.scatter(election,x="STATE",y="NAME",marginal_x="histogram",marginal_y="rug",color="GENDER",title="Election Data")
fig.show()


*/