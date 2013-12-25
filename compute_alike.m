function coeff = compute_alike(X , Y)
X=load(X);
Y=load(Y);
coeff_a = alike(X,Y);
[r2,lags2]=xcorr(X,'unbiased');
[r1,lags1]=xcorr(Y,'unbiased');
coeff_b = alike(r1,r2);
coeff = [coeff_a coeff_b];
end 