function coeff = getall(x)
m = zeros(1,2);
for i=1:70
    try
    str_wave1= sprintf('data/%s/%d.txt',x,i*2-1);
    str_wave2= sprintf('data/%s/%d.txt',x,i*2);
    m(i,:)=compute_alike(str_wave1,str_wave2);
    catch exc
        getReport(exc);
        break;
    end
end
coeff = m;