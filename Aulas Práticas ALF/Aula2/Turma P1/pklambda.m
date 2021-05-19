function y=pklambda(x,lambda,k)
y=lambda^k*x.^(k-1).*exp(-lambda*x)/gamma(k);
end