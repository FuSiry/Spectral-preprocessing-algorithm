# Spectral-preprocessing-algorithm
Common preprocessing such as sg, msc, SNV, first-order derivative, second-order derivative, etc.
## 1.搭建python环境
<font color=#9A >推荐基于anaconda安装python，参考安装如下：
[基于anaconda安装python](https://zhuanlan.zhihu.com/p/347990651)

## 2.引入库
```python
import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import MinMaxScaler, StandardScaler
```
## 3.读入数据、预处理以及展示

```python
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
```

## 4.结果(以msc为例)
<font color=#999AAA >原始光谱
![原始光谱](https://img-blog.csdnimg.cn/4772301c3ba840f1a142eec6fa7bb9b7.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBARWNob19Db2Rl,size_20,color_FFFFFF,t_70,g_se,x_16)
msc预处理后
![msc预处理后](https://img-blog.csdnimg.cn/9a01b6a3eabe427aba1b44217e8e3a63.png?x-oss-process=image/watermark,type_ZHJvaWRzYW5zZmFsbGJhY2s,shadow_50,text_Q1NETiBARWNob19Db2Rl,size_20,color_FFFFFF,t_70,g_se,x_16)
