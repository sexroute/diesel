function [a,b]  = test(m,n,chann)
%input =[];
%input(1) = reshape(10,2,2);
%input_filttered =zeros(10,1);
%result = [];
close all;
lstrDir = sprintf('./data/%s/',chann);
listing = dir(lstrDir);
n1=length(listing);
a = [];
start =1;
endt = n1-20;
resultStart = 0;
lnPointCount=0;
lnAbnormalArrayCount = 1;
v_max = 0;
n_max = start;
for i = start : 1 : endt
    lstrTempFileName = listing(i+3).name;
    lstrFilaName = sprintf('./data/%s/%s',chann,lstrTempFileName);
    a= importdata(lstrFilaName);
    wave(lnPointCount+1,:)= a(1:1800);
    max_i=max(a);
    if(v_max<max_i)
        v_max = max_i;
        n_max = i;
    end
    min_i = min(a);
    %a=a/(max_i-min_i);
    b= fft(a);
    b= b(1:ceil(length(b)/2));
    a= abs(b).^2/length(a);
    %plot(a);
    %break;
    if(i>start)
        if(length(a)> length(input(i-1,:)) )
            a = a(1:length(input(i-1,:)));            
        end
        if(length(a)< length(input(i-1,:)) )
            a(length(a)+1:length(input(i-1,:)))=0;            
        end
    end
    input(i,:)= a;
    z = input(i,:);
    input_filttered(i,:) = sgolayfilt(z,m,n);
    if(i>start)
        ldblData2 = alike(input_filttered(i-1,:),input_filttered(i,:));
        ldblData1  = alike(input(i-1,:),input(i,:));
        if(ldblData1 > 0.01)          
           lnPointCount = lnPointCount+1;
           result(lnPointCount,1) = ldblData1;
           result(lnPointCount,2) = ldblData2;
           result(lnPointCount,3) = i; 
           result(lnPointCount,4) = i+3;
        end
        
    end 
    
end
n_max=n_max;
tmid = input;
min_d = min(result(1:lnPointCount,2));
[x,y] =find(min_d == result(:,2))
%x=af;
dd=(listing(result(x,3)+3).name)
subplot(4,1,1);
plot(tmid(result(x+1,3),:));
subplot(4,1,2);
plot(tmid(result(x,3),:));
subplot(4,1,3);
plot(tmid(result(x-1,3),:));
subplot(4,1,4);
plot(wave(result(x-1,3),:));
a = result;
b = listing;

