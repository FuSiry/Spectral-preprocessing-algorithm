%# function [mdata]=nirmaf(data,window)
%#
%#  AIM:   �ƶ�����ƽ�����׾������ڹ���Ԥ����
%#
%#  INPUT:  data        m��n�ľ���m�����ף�n������
%#          window      ���״��ڿ�ȣ�����������(Ĭ��: 3)
%# 
%#  OUTPUT: mdata       ƽ�����Ĺ��ף�m�����ף�n������
%#
%#  AUTHOR: ���� 
%#  EMAIL:  wang727yi@hotmail.com
%#  VERSION:1.0 (15/03/2009)

function [mdata]=nirmaf(data,window)

[m,n] = size(data);	
mdata = zeros(m,n);	

if nargin == 1
	window = 3;	    % Ĭ�ϴ��ڿ��
elseif round(window/2) == window/2
	error('���״��ڿ�ȱ���������')
end

wcenter = floor(window/2);
extdata = [zeros(m,wcenter) data zeros(m,wcenter)];	% ��չԭʼ���׾���


%# ��չ��Ĺ��׾����������
for k = 1:m
	bstart = polyfit(wcenter+1:wcenter+4,extdata(k,wcenter+1:wcenter+4),2);		% ����������
	bend = polyfit(n-4+wcenter:n+wcenter,extdata(k,n-4+wcenter:n+wcenter),2);	% �Ҷ��������
	extdata(k,1:wcenter) = polyval(bstart,1:wcenter);				% �������������ϵ�ֵ
	extdata(k,n+wcenter+1:n+window-1) = polyval(bend,n+wcenter+1:n+window-1);	% �����Ҷ�������ϵ�ֵ
end



%# ��ֵƽ��
for i = 1:n
	mdata(:,i) = mean(extdata(:,i:i+window-1)')';	
end