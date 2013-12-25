clc;clear;close all
N=128;
n=-N+1:N-1;
%fs=4e9;%����Ƶ�ʣ����ݲ�����������2f
s=3*cos(10.0*2*n*pi/N+pi/18)+2*cos(20.1*2*n*pi/N+pi/6)+2*cos(30.2*2*n*pi/N+pi*5/18)+2*cos(40.3*2*n*pi/N+7*pi/18)+2*cos(50.4*2*n*pi/N+pi/2);%������1e9���ں��油�����
%�����źŶ����

y1=s(N:2*N-1);%N������������FFT����
y2=s(1:2*N-1);%2N-1������������APFFT����
win=hanning(N)'%������,�����һƳΪת��Ϊ������
win1=win/sum(win);%��������һ��
winn=conv(win,win);%�������ľ��
win2=winn/sum(winn);%����������Ĺ�һ��
%���Ķ����
 
y11_fft=fft(y1.*win,N);
a_fft=abs(y11_fft);%FFT��Ƶ
p_fft= angle(y11_fft)*180/pi ;%FFT��Ƶ
%FFT����Ƶ�ͷ�Ƶ���
%figure(5);
%stem(0:N-1,abs(fft(y1,N)),'.r');%����FFT���Ӵ������

y22=y2.*win2;
y222=[0,y22(1:N-1)]+y22(N:end);%����ΪN������FFT��������ΪAPFFT
y222_fft=fft(y222,N);
a_apfft=abs(y222_fft);%APFFT��Ƶ
p_apfft=mod(phase(y222_fft)*180/pi,360);%APFFT��Ƶ
%APFFT����Ƶ�ͷ�Ƶ���
%y222t=y2(N:end)+[0,y2(1:N-1)];
%figure(6);
%stem(0:N-1,abs(fft(y222t,N)),'.r');%����APFFT���Ӵ������


%��ͼ�����
t1=0:N-1;
t2=t1;%*fs/N;%����Ķ���

figure(1);
%a_fft1=a_fft/sum(a_fft);%�����ȹ�һ����ʹ�ò�ͬN�ķ�Ƶ�пɱ���
stem(t2,a_fft,'.k');%FFT�ķ�Ƶ����
grid on;
title('FFT��Ƶ����');
ylabel('��ֵ');
xlabel('Ƶ�ʣ�HZ��');
xlim([0,60]);
ylim([0,1.2]);
%axis([1.2e9,1.8e9,0,0.5]);
figure(2);
stem(t2,p_fft,'.k');%FFT����Ƶ����
xlim([0,60]);
%ylim([-200,200]);
grid on;
title('FFT��Ƶ����');
ylabel('�ȣ��㣩');
xlabel('Ƶ�ʣ�HZ��');

figure(3);
%a_apfft1=a_apfft/(sum(a_apfft)^2);
stem(t2,a_apfft,'.k');%APFFT�ķ�Ƶ����
grid on;
title('apFFT��Ƶ����');
ylabel('��ֵ');
xlabel('Ƶ�ʣ�HZ��');
xlim([0,60]);
ylim([0,10]);
figure(4);
stem(t2,p_apfft,'.k');%APFFT�ķ�Ƶ����
xlim([0,60]);
ylim([0,100]);
grid on;
title('apFFT��Ƶ����');
ylabel('�ȣ��㣩');
xlabel('Ƶ�ʣ�HZ��');


%���ִ�������
[a,b]=max(a_fft);
a_fft(b)=0;
[c,d]=max(a_fft);
a_fft(d)=0;
e=max(a_fft);
display('FFT�԰������');
FFT_sidelobe=e/a%FFT���Ա��������ֵ

[h,i]=max(a_apfft);
a_apfft(i)=0;
[j,k]=max(a_apfft);
a_apfft(k)=0;
l=max(a_apfft);
display('apFFT�԰������');
APFFT_sielobe=l/h





