
%%%%���⣺����NΪ3��FΪ5��A97�е�ÿһ�У�һ���������ĵ���ƽ�����ݡ�һ�׵����Ͷ��׵���������һ��104�����ݣ���97���������õ�������Ӧ����97*104���������³������еõ���ƽ�����ݺ�һ�׵��������׵���Ϊһ������9897����ͼҲ���ԣ�����

%����Ԥ��������Savitzky-Golayƽ����Savitzky-Golay��
clear
clc
load A97 %�������,��һ��Ϊ��ţ����һ��ΪŨ��ֵ
dx=1;
x=215:321; %������Χ��215nm-321nm
a=length(x); %x�����ݸ���
k=0:96;
z=A97(:,109); %97��������Ӧ��Ũ��ֵ ����һ��Թ���ƽ������û�ж���ϵ��
N=input('��������ϴ���');
F=input('���ô��ڲ���(����)');

[b,g]=sgolay(N,F);
Halfwin=((F+1)/2)-1;
hold on            %����Ϊ�˱���ÿ�μ����ͼ
for k=k+1
hold on 
for n=(F+1)/2:a-(F+1)/2
y=A97(k,2:108); %��k������ 215nm-321nmӦ������ȶ�
%SGƽ��
SG0(n,k)=dot(g(:,1),y(n-Halfwin:n+Halfwin));   %��ɫ��֮ǰû����ӵ�
%һ�ײ����
SG1(n,k)=dot(g(:,2),y(n-Halfwin:n+Halfwin));
%���ײ����
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