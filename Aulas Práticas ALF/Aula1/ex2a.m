clear all
close all
figure(1) 
%variavel x
%bins
n=1e4;
u=rand(n,1);
lambda=2; xmax=10/lambda;
nbins=20; dx=(xmax-0)/nbins;
bins=dx/2:dx:xmax-dx/2;
x=-(1/lambda)*log(1-u);

[h]=hist(x,bins);
% normalizaçao do histograma 
hn=(h/sum(h))/dx;
%p(x)=lambda*exp(-lambda*x)
x=0:0.01:xmax;
plot(bins,hn,'x',x,lambda*exp(-lambda*x),'r-')
xlabel('x')
ylabel('p(x)');