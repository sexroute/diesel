function coeff = alike(X , Y)


lnLenx = length(X);
lnLeny = length(Y);
if(lnLenx < lnLeny)   
    Y = Y(1:lnLenx);
else
    X = X(1:lnLeny);
end

num = sum(X .* Y) - (sum(X) * sum(Y)) / length(X);
den = sqrt((sum(X .^2) - sum(X)^2 / length(X)) * (sum(Y .^2) - sum(Y)^2 / length(X)));
coeff = abs(num / den);

end 