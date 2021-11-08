clc;
clear;
close all;
% %%  打开多个txt文件
% path = uigetdir('D:\','Pick a Directory');
%  files = dir([path, '\*.mat']);
% 
%  for i = 1:length(files)
%     data(:,2*i-1:2*i) = load( [path '\' files(i).name] );
%  end
filename = 'D:\ProgramData\TransferNIRV7\Data\4_class_not\data.csv';
loaddata = load(filename);
data = loaddata(:,1:2074);
label = loaddata(:,2075);

 %% 作图
 color=['r','g','b','c','m','y','k'];
 figure(1);
for j=1:i
A=data(:,2*j-1);
B=data(:,2*j);
%c1 = randint(1,1,[1,length(color)]);  % 产生随机数
c1 = randi([1,length(color)],1,1);  % 产生随机数
c2 = color(c1);     % 确定随机颜色
set(gca,'XDir','reverse'); % 横坐标从大到小
hold on;
plot(A,B,c2);
title('光谱图');
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');
end

%% 吸光度波数
Absorbance=data(:,2:2:end); %得到吸光度
Absorbance=Absorbance';
[Absorbance_m,Absorbance_n]=size(Absorbance);
Wavenumber=data(:,1:2:end); %得到波数
Wavenumber=Wavenumber';
Absorbance_mean=mean(Absorbance);%每个样本吸光度平均

%% 多元散射校正MSC
Absorbance_msc=msc(Absorbance,Absorbance_mean);
figure(2);
for sample=1:1:Absorbance_m
  plot(Wavenumber(1,:),Absorbance_msc(sample,:),'-r');
  hold on;    
end
set(gca,'XDir','reverse'); % 横坐标从大到小
title('多元散射校正MSC');
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');

%% 标准正态变量交化SNV
Absorbance_snv=snv(Absorbance);
figure(3);
for sample=1:1:Absorbance_m
  plot(Wavenumber(1,:),Absorbance_snv(sample,:),'-g');
  hold on;    
end
set(gca,'XDir','reverse'); % 横坐标从大到小
title('标准正态变量交化SNV');
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');

%% 归一化Normalize

[Absorbance_Nor] = normaliz(Absorbance);
figure(4);
for sample=1:1:Absorbance_m
  plot(Wavenumber(1,:),Absorbance_Nor(sample,:),'-b');
  hold on;    
end
set(gca,'XDir','reverse'); % 横坐标从大到小
title('归一化Normalize');
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');

%% 数据中心化(Mean centering)
[Absorbance_MCX,Absorbance_MX] = center(Absorbance);
figure(5);
for sample=1:1:Absorbance_m
  plot(Wavenumber(1,:),Absorbance_MCX(sample,:),'-c');
  hold on;    
end
set(gca,'XDir','reverse'); % 横坐标从大到小
title('数据中心化(Mean centering)');
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');

%% 标准化Autoscales
[ax,mx,stdx] = auto((Absorbance)');
ax=ax';
figure(6);
for sample=1:1:Absorbance_m
plot(Wavenumber(1,:),ax(sample,:),'-m');
hold on;
end
set(gca,'XDir','reverse'); % 横坐标从大到小
title('标准化Autoscales'); 
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');
warning('off')
%% 移动窗口平滑/Moving-average method
Absorbance_nir=nirmaf(Absorbance,11);
figure(7);
for sample=1:1:Absorbance_m
plot(Wavenumber(1,:),Absorbance_nir(sample,:),'-r');
hold on;
end
set(gca,'XDir','reverse'); % 横坐标从大到小
title('移动窗口平滑光谱'); 
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');

%% SavitZky一Golay卷积平滑法及求导
Absorbance_S_G =savgol(Absorbance,15);%光谱，窗口大小；多项式项数；一阶求导;平滑;
Absorbance_S_G1 = savgol(Absorbance,7,3,1);%一阶求导
Absorbance_S_G2 = savgol(Absorbance,7,3,2);%二阶求导
figure(8);
for sample=1:1:Absorbance_m
plot(Wavenumber(1,:),Absorbance_S_G(sample,:),'-k');
hold on;
end
set(gca,'XDir','reverse'); % 横坐标从大到小
title('SavitZky-Golay卷积平滑法'); 
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');

figure(9);
for sample=1:1:Absorbance_m
plot(Wavenumber(1,:),Absorbance_S_G1(sample,:),'-r');
hold on;
end
set(gca,'XDir','reverse'); % 横坐标从大到小
title('SavitZky-Golay一阶求导'); 
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');

figure(10);
for sample=1:1:Absorbance_m
plot(Wavenumber(1,:),Absorbance_S_G2(sample,:),'-g');
hold on;
end
set(gca,'XDir','reverse'); % 横坐标从大到小
title('SavitZky-Golay二阶求导'); 
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');

%% 直接差分一、二阶求导
d1=diff((Absorbance)',1);%
d2=diff((Absorbance)',2);%
d1=d1';
d2=d2';
figure(11);
for sample=1:1:Absorbance_m-1
plot(Wavenumber(1,2:1:end),d1(sample,:),'-b');
hold on;
end
set(gca,'XDir','reverse'); % 横坐标从大到小
title('直接差分一阶求导'); 
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');

figure(12);
for sample=1:1:Absorbance_m-2
plot(Wavenumber(1,3:1:end),d2(sample,:),'-r');
hold on;
end
set(gca,'XDir','reverse'); % 横坐标从大到小
title('直接差分二阶求导'); 
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');



