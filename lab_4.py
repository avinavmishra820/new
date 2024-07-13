
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from matplotlib import pyplot as plt

df=pd.read_csv('/flights.csv')
carrier_counts=df['carrier'].value_counts()
plt.pie(carrier_counts,labels=carrier_counts.index,autopct='%1.1f%%',startangle=80)
plt.title("1NT22CS002 Aashutosh")
plt.show()