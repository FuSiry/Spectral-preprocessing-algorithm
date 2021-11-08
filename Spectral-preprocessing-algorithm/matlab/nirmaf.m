%# function [mdata]=nirmaf(data,window)
%#
%#  AIM:   移动窗口平滑光谱矩阵，用于光谱预处理
%#
%#  INPUT:  data        m×n的矩阵，m个光谱，n个变量
%#          window      光谱窗口宽度，必须是奇数(默认: 3)
%# 
%#  OUTPUT: mdata       平滑过的光谱，m个光谱，n个变量
%#
%#  AUTHOR: 王毅 
%#  EMAIL:  wang727yi@hotmail.com
%#  VERSION:1.0 (15/03/2009)

function [mdata]=nirmaf(data,window)

[m,n] = size(data);	
mdata = zeros(m,n);	

if nargin == 1
	window = 3;	    % 默认窗口宽度
elseif round(window/2) == window/2
	error('光谱窗口宽度必须是奇数')
end

wcenter = floor(window/2);
extdata = [zeros(m,wcenter) data zeros(m,wcenter)];	% 延展原始光谱矩阵


%# 延展后的光谱矩阵曲线拟合
for k = 1:m
	bstart = polyfit(wcenter+1:wcenter+4,extdata(k,wcenter+1:wcenter+4),2);		% 左端曲线拟合
	bend = polyfit(n-4+wcenter:n+wcenter,extdata(k,n-4+wcenter:n+wcenter),2);	% 右端曲线拟合
	extdata(k,1:wcenter) = polyval(bstart,1:wcenter);				% 返回左端曲线拟合的值
	extdata(k,n+wcenter+1:n+window-1) = polyval(bend,n+wcenter+1:n+window-1);	% 返回右端曲线拟合的值
end



%# 均值平滑
for i = 1:n
	mdata(:,i) = mean(extdata(:,i:i+window-1)')';	
end