import matplotlib.pyplot as plt
import numpy as np
from PreProcessing import *

#载入数据
data_path = './/data//data.csv' #数据
xcol_path = './/data//xcol.csv' #波长
data = np.loadtxt(open(data_path, 'rb'), dtype=np.float64, delimiter=',', skiprows=0)
xcol = np.loadtxt(open(xcol_path, 'rb'), dtype=np.float64, delimiter=',', skiprows=0)

# 绘制MSC预处理后图片
plt.figure(500)
x_col = xcol  #数组逆序
y_col = np.transpose(data)
plt.plot(x_col, y_col)
plt.xlabel("Wavenumber(nm)")
plt.ylabel("Absorbance")
plt.title("The spectrum of the raw for dataset",fontweight= "semibold",fontsize='large') #记得改名字MSC
plt.show()

#数据预处理、可视化和保存
datareprocessing_path = './/data//dataMSC.csv' #波长
Data_Msc = MSC(data) #改这里的函数名就可以得到不同的预处理

# 绘制MSC预处理后图片
plt.figure(500)
x_col = xcol  #数组逆序
y_col = np.transpose(Data_Msc)
plt.plot(x_col, y_col)
plt.xlabel("Wavenumber(nm)")
plt.ylabel("Absorbance")
plt.title("The spectrum of the MSC for dataset",fontweight= "semibold",fontsize='large') #记得改名字MSC
plt.show()

#保存预处理后的数据
np.savetxt(datareprocessing_path, Data_Msc, delimiter=',')