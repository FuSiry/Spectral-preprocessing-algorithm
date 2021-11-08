
%%%%问题：设置N为3，F为5，A97中的每一行（一个样本）的到的平滑数据、一阶导数和二阶导数均是是一行104个数据；有97个样本，得到的数据应该是97*104，但按以下程序运行得到的平滑数据和一阶导数，二阶导数为一行数据9897个，图也不对？？？

%光谱预处理，包括Savitzky-Golay平滑和Savitzky-Golay求导
clear
clc
load A97 %导入光谱,第一列为编号，最后一列为浓度值
dx=1;
x=215:321; %波长范围是215nm-321nm
a=length(x); %x的数据个数
k=0:96;
z=A97(:,109); %97个样本对应的浓度值 （这一句对光谱平滑、求导没有多大关系）
N=input('请输入拟合次数');
F=input('设置窗口参数(奇数)');

[b,g]=sgolay(N,F);
Halfwin=((F+1)/2)-1;
hold on            %这是为了保存每次计算的图
for k=k+1
hold on 
for n=(F+1)/2:a-(F+1)/2
y=A97(k,2:108); %第k个样本 215nm-321nm应的吸光度对
%SG平滑
SG0(n,k)=dot(g(:,1),y(n-Halfwin:n+Halfwin));   %红色是之前没有添加的
%一阶差分求导
SG1(n,k)=dot(g(:,2),y(n-Halfwin:n+Halfwin));
%二阶差分求导
SG2(n,k)=2*dot(g(:,3)',y(n-Halfwin:n+Halfwin)); 

end
SG1=SG1/dx;
SG2=SG2/(dx*dx);

subplot(3,1,1);
plot(SG0)
legend('S-G Smooth');

subplot(3,1,2);
plot(SG1)
legend('S-G Smooth 1st derivative');

subplot(3,1,3);
plot(SG2)
legend('S-G Smooth 2st derivativa');
end