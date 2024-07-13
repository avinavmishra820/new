

import pandas as pd
import plotly.express as px
election=pd.read_csv("election.csv")
election=election[0:500]
fig=px.scatter(election,x="STATE",y="NAME",marginal_x="histogram",marginal_y="rug",color="GENDER",title="Election Data")
fig.show()

