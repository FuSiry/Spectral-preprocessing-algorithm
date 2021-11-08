clc;
clear;
close all;
% %%  �򿪶��txt�ļ�
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

 %% ��ͼ
 color=['r','g','b','c','m','y','k'];
 figure(1);
for j=1:i
A=data(:,2*j-1);
B=data(:,2*j);
%c1 = randint(1,1,[1,length(color)]);  % ���������
c1 = randi([1,length(color)],1,1);  % ���������
c2 = color(c1);     % ȷ�������ɫ
set(gca,'XDir','reverse'); % ������Ӵ�С
hold on;
plot(A,B,c2);
title('����ͼ');
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');
end

%% ����Ȳ���
Absorbance=data(:,2:2:end); %�õ������
Absorbance=Absorbance';
[Absorbance_m,Absorbance_n]=size(Absorbance);
Wavenumber=data(:,1:2:end); %�õ�����
Wavenumber=Wavenumber';
Absorbance_mean=mean(Absorbance);%ÿ�����������ƽ��

%% ��Ԫɢ��У��MSC
Absorbance_msc=msc(Absorbance,Absorbance_mean);
figure(2);
for sample=1:1:Absorbance_m
  plot(Wavenumber(1,:),Absorbance_msc(sample,:),'-r');
  hold on;    
end
set(gca,'XDir','reverse'); % ������Ӵ�С
title('��Ԫɢ��У��MSC');
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');

%% ��׼��̬��������SNV
Absorbance_snv=snv(Absorbance);
figure(3);
for sample=1:1:Absorbance_m
  plot(Wavenumber(1,:),Absorbance_snv(sample,:),'-g');
  hold on;    
end
set(gca,'XDir','reverse'); % ������Ӵ�С
title('��׼��̬��������SNV');
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');

%% ��һ��Normalize

[Absorbance_Nor] = normaliz(Absorbance);
figure(4);
for sample=1:1:Absorbance_m
  plot(Wavenumber(1,:),Absorbance_Nor(sample,:),'-b');
  hold on;    
end
set(gca,'XDir','reverse'); % ������Ӵ�С
title('��һ��Normalize');
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');

%% �������Ļ�(Mean centering)
[Absorbance_MCX,Absorbance_MX] = center(Absorbance);
figure(5);
for sample=1:1:Absorbance_m
  plot(Wavenumber(1,:),Absorbance_MCX(sample,:),'-c');
  hold on;    
end
set(gca,'XDir','reverse'); % ������Ӵ�С
title('�������Ļ�(Mean centering)');
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');

%% ��׼��Autoscales
[ax,mx,stdx] = auto((Absorbance)');
ax=ax';
figure(6);
for sample=1:1:Absorbance_m
plot(Wavenumber(1,:),ax(sample,:),'-m');
hold on;
end
set(gca,'XDir','reverse'); % ������Ӵ�С
title('��׼��Autoscales'); 
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');
warning('off')
%% �ƶ�����ƽ��/Moving-average method
Absorbance_nir=nirmaf(Absorbance,11);
figure(7);
for sample=1:1:Absorbance_m
plot(Wavenumber(1,:),Absorbance_nir(sample,:),'-r');
hold on;
end
set(gca,'XDir','reverse'); % ������Ӵ�С
title('�ƶ�����ƽ������'); 
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');

%% SavitZkyһGolay���ƽ��������
Absorbance_S_G =savgol(Absorbance,15);%���ף����ڴ�С������ʽ������һ����;ƽ��;
Absorbance_S_G1 = savgol(Absorbance,7,3,1);%һ����
Absorbance_S_G2 = savgol(Absorbance,7,3,2);%������
figure(8);
for sample=1:1:Absorbance_m
plot(Wavenumber(1,:),Absorbance_S_G(sample,:),'-k');
hold on;
end
set(gca,'XDir','reverse'); % ������Ӵ�С
title('SavitZky-Golay���ƽ����'); 
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');

figure(9);
for sample=1:1:Absorbance_m
plot(Wavenumber(1,:),Absorbance_S_G1(sample,:),'-r');
hold on;
end
set(gca,'XDir','reverse'); % ������Ӵ�С
title('SavitZky-Golayһ����'); 
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');

figure(10);
for sample=1:1:Absorbance_m
plot(Wavenumber(1,:),Absorbance_S_G2(sample,:),'-g');
hold on;
end
set(gca,'XDir','reverse'); % ������Ӵ�С
title('SavitZky-Golay������'); 
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');

%% ֱ�Ӳ��һ��������
d1=diff((Absorbance)',1);%
d2=diff((Absorbance)',2);%
d1=d1';
d2=d2';
figure(11);
for sample=1:1:Absorbance_m-1
plot(Wavenumber(1,2:1:end),d1(sample,:),'-b');
hold on;
end
set(gca,'XDir','reverse'); % ������Ӵ�С
title('ֱ�Ӳ��һ����'); 
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');

figure(12);
for sample=1:1:Absorbance_m-2
plot(Wavenumber(1,3:1:end),d2(sample,:),'-r');
hold on;
end
set(gca,'XDir','reverse'); % ������Ӵ�С
title('ֱ�Ӳ�ֶ�����'); 
xlabel('Wavenumber(cm-1)');
ylabel('Absorbance');



