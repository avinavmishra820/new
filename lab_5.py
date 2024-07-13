

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

