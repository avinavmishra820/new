
# lab_1A

import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

cs=pd.read_csv('cars.csv')
cs.head()



fuel=cs['Fuel_Type']
price=cs['Price']
plt.bar(fuel,price,color='skyblue')
plt.xlabel('fuel type')
plt.ylabel('prices($)')
plt.title('Aashhutosh')
plt.xticks(rotation=45,ha='right')
plt.tight_layout()
plt.show()

#lab_1B

cr=pd.read_csv('cars.csv')
x=cr['Age']
y=cr['Price']
fig, ax=plt.subplots()
plt.scatter(x,y,color='RED',marker='^',s=20)
plt.xlabel('age')
plt.ylabel('prices($)')
plt.title('Ashutosh')
plt.show()