function result = ar(b,anMode)
    if(length(b)<2)
        result = b
    end
    if(anMode == 0)
        result= zeros(1,(length(b)));
        result(1)=(1.5*b(1)+0.5*b(2))/2;
        for i =2:(length(b))
            
            result(i)=(1.5*result(i-1)+0.5*b(i))/2;
        end
    else
       
       result= zeros(1,(length(b)-1));
       result(1)=(b(1)+b(2))/2;
       for i = 2:(length(b)-1)
            result(i)=(b(i)+b(i+1))/2;
       end
       %result = sum(result)/(length(result));
    end
end
