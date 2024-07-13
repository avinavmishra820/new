

import matplotlib.pyplot as plt
import pandas as pd
df=pd.read_csv("flights.csv")
hour_data=df['hour']
plt.hist(hour_data, bins=24,edgecolor='c',alpha=1)
plt.xlabel("Hour of the day")
plt.ylabel("Frequency")
plt.title("1NT22CS002 Aashutosh")
plt.grid(True)
plt.show()


