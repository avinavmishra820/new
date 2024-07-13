

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

