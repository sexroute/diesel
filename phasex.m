clear;clc;close all;

%0.�������
sampleFreq = 25600;%������ 
revfile = 'rev1.txt';
wavefile = 'wave1.txt';


%1.����������
workfreq = 0;%��Ƶ
sampleTime = 0;%����ʱ��
rev=load(revfile);
wave = load(wavefile);
y=length(rev);
z=zeros(1);
i=1;
zIndex=1;
while i<y    
    lnrev = rev(i);
    if lnrev >3 
        z(zIndex) = i;
        zIndex=zIndex+1;
        for j=i:1:y
            lnrev = rev(j);
            if(lnrev <2)
                i=j;
                break;
            end
        end
    else
        i=i+1;
        %break;
    end
end
points = z(length(z)) - z(1)+1;
sampleTime = points/25600; %����ʱ��
workfreq = (length(z)-1)/sampleTime; %��Ƶ
rpm = workfreq*60; %ת��

%2.��ȡ����
revstartIndex = 1;%�ӵڼ������ڿ�ʼ�ضϲ���
revendIndex = -1;
wavestartIndex = z(revstartIndex);
waveendIndex = -1;
y=length(z);
i=y;
wavelength = length(wave);
while i > revstartIndex
    if(z(i)<=wavelength)
        waveendIndex =z(i);
        revendIndex = i;
        break;
    else
        i=i-1;
    end
end

wavenew = wave(wavestartIndex:waveendIndex);
revnew = rev(wavestartIndex:waveendIndex);


revnew = revnew/30-9.35;
subplot(311);
plot(wavenew);
subplot(312);
plot(revnew);
subplot(313);
plot(wavenew);
hold on
plot(revnew,'r-');


%3.�������Ҳ�
dt = 1/sampleFreq;
TN = 0:dt:sampleTime;
AMP = max(wavenew)*10;
sinwave = AMP*sin(2*pi*TN*workfreq);
df = sampleFreq*2/points;
freqs = 0:df:sampleFreq;

%4 compute phase different
sinfft=apfft(sinwave,points);
sinangle = angle(sinfft)*180/pi;
[amp,sinindex] = max(abs(sinfft));
sinindex=sinindex;
freq0 =freqs(sinindex);
%plot(sinangle);
wavefft=apfft(wavenew,points);
anglewave = angle(wavefft)*180/pi;
diff = anglewave(sinindex)-sinangle(sinindex);
if(diff<0) 
    diff = diff+360;
end
x=diff;


