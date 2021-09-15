function [f,p] = freq_spectrum(X,Fs)
% function of compute the frequency spectrum
% L��ʾ�źų���
L = length(X);
% Fs��ʾ����Ƶ�ʹ̶���Ϊ2000,����ʵ�������ϵĲ���Ƶ��
if nargin == 1
    Fs = 2;
end
% ���ź�����ΪT
T = 1/Fs;
% Ƶ����Ķ���f
f = Fs*(0:floor(L/2))/L;
% ���źŽ���FFT
Y = fft(X);
% ����˫��Ƶ��
P = abs(Y/L);
% ���㵥��Ƶ��
p = P(1:floor(L/2)+1);
p(2:end-1) = 2*p(2:end-1);
end
