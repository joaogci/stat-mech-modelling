clear all
close all
nal=10000;
x0=90;
k=100; lambda=1;

x=fex1(nal,k,lambda,x0);
%x=fex1_alternativo(nal,k,lambda,x0);
xf=x0:0.01:max(x);
[hn,xh]=hist(x,50);
figure(1)
hn=hn/(nal*(xh(2)-xh(1)));
pklx0=lambda^k *xf.^(k-1) .* exp(-lambda*xf)/(gamma(k)*gammainc(lambda*x0,k,'upper'));
plot(xh,hn,'rx',xf,pklx0,'k-')
axis([x0 max(xf) 0, max(pklx0)])
xlabel('x')
ylabel('p(x)')
