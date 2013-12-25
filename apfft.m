function result = apfft(apsignal,ansignals)

mods = mod(ansignals,2);
if mods ~= 0
    n_sub = length(apsignal);
    if mod(n_sub,2) ~=0        
        n_sub = n_sub-1;
        apsignal = apsignal(1:n_sub);
    end
    
    ansignals = n_sub;
end
smp = fix(ansignals/2);

sig = apsignal;

win=hanning(smp)';%������,�����һƳΪת��Ϊ������
winn=conv(win,win);%�������ľ��
win2=winn;%����������Ĺ�һ��

len = length(win2);
sig=sig(1:len).*win2;
pts = smp-1;
data1 = sig(pts:pts*2);
data0 = [0,sig(1:pts)];
sig= data0+data1;%����ΪN������FFT��������ΪAPFFT
if pts < 0
    pts
end
fftsig = fft(sig,pts);
result = fftsig;