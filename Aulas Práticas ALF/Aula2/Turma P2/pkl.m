function po=pkl(x,k,lambda)
%distribuicao gama
po= lambda^k * x.^(k-1) .*exp(-lambda*x)/gamma(k);
end