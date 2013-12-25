clc;
clear all; close all
A1=1;   %Ƶ��F1�źŵķ���
F1=49.8; %�ź�1Ƶ��(Hz)
Fs=3200; %����Ƶ��(Hz)
P1=0; %�ź�1��λ(��)
N=256; %��������
t=[0:1/Fs:N/Fs]; %����ʱ��
%�ź�
S=A1*sin(2*pi*F1*t+pi*P1/180);
%��ʾԭʼ�ź�
subplot(411);plot(S);
title('ԭʼ�ź�ʱ��ͼ');
Y = fft(S,N); %��FFT�任
Ayy = (abs(Y)); %ȡģ
subplot(412);stem(Ayy(1:N)); %��ʾԭʼ��FFTģֵ���
title('FFT ģֵ'); xlim([0 50]);
Ayy=Ayy/(N/2);   %�����ʵ�ʵķ���
Ayy(1)=Ayy(1)/2;
F=([1:N]-1)*Fs/N; %�����ʵ�ʵ�Ƶ��ֵ��Fn=(n-1)*Fs/N
subplot(413);stem(F(1:N/2),Ayy(1:N/2));   %��ʾ������FFTģֵ���
title('����-Ƶ������ͼ');
Pyy=[1:N/2];
for i=1:N/2
Pyy(i)=angle(Y(i)); %������λ
Pyy(i)=Pyy(i)*180/pi; %����Ϊ�Ƕ�
end;
subplot(414);stem(F(1:N/2),Pyy(1:N/2));   %��ʾ��λͼ
title('��λ-Ƶ������ͼ');
[Aym,Ayl]=max(Ayy(1:N/2));
fprintf('%5.6f   %5.6f   %5.6f   %4d\n',Ayy(Ayl-1),Ayy(Ayl),Ayy(Ayl+1),Ayl);
Z=Specorr(S,Fs,N,25,75,1);
fprintf('%5.6f   %5.6f   %5.6f\n',Z(1),Z(2),Z(3));
Z=Specorr(S,Fs,N,25,75,2);
fprintf('%5.6f   %5.6f   %5.6f\n',Z(1),Z(2),Z(3));