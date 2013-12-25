function [a,b] = test2(m,n,chann)
%input =[];
%input(1) = reshape(10,2,2);
%input_filttered =zeros(10,1);
%result = [];
lstrDir = sprintf('./data/%s/',chann);
listing = dir(lstrDir);
n1=length(listing);
a = [];
start =1;
resultStart = 0;
lnPointCount=0;
lnAbnormalArrayCount = 1;
for i = n1-20 : -1 : start
    lstrTempFileName = listing(i+3).name;
    lstrFilaName = sprintf('./data/%s/%s',chann,lstrTempFileName);
    if(strcmp(lstrTempFileName,'k1031_1H_20131218141803.017_631_10240_1946.dat')== 1)
      %  af = i
    end
    a= importdata(lstrFilaName);
    max_i=max(a);
    min_i = min(a);
   % a=a/(max_i-min_i);
    if(i<(n1-20))
        if(length(a)> length(input(i+1,:)) )
            a = a(1:length(input(i+1,:)));            
        end
        if(length(a)< length(input(i+1,:)) )
            a(length(a)+1:length(input(i+1,:)))=0;            
        end
    end
    input(i,:)= a;
    z = input(i,:);
    input_filttered(i,:) = sgolayfilt(z(1:1900),m,n);
    if(i<(n1-20))
        ldblData2 = alike(input_filttered(i+1,:),input_filttered(i,:));
        ldblData1  = alike(input(i+1,:),input(i,:));
        if(ldblData1 > 0.01)          
           lnPointCount = lnPointCount+1;
           result(lnPointCount,1) = ldblData1;
           result(lnPointCount,2) = ldblData2;
           result(lnPointCount,3) = i;  
           result(lnPointCount,4) = i+3;
        end
        
    end 
end

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
plot(result(:,1:2));
a = result;
b = listing;

