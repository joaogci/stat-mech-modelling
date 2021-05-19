clear all
close all
clc
n=10000;
lambda=1;k=1; 
u=rand(n,1); x=-(1/lambda)*log(1-u); %metodo de transformacao de variaveis
% verificar se a distribuicao dos numeros gerados e' exponencial
xmax=max(x); xmin=0;
nbins=20; dx=(xmax-xmin)/nbins; xc=xmin+dx/2:dx:xmax-dx/2;
h=hist(x,xc); 
%normalizacao 
h=h/(n*dx);
figure(1)

x=0:dx/100:xmax;
plot(xc,h,'b.',x,pkl(x,k,lambda),'r-')

%a)
k=2;
u=rand(n,k); xk=-(1/lambda)*log(1-u);
xs=sum(xk,2); % soma dos numeros das  k colunas de cada linha

xmax=max(xs); xmin=0;
nbins=20; dx=(xmax-xmin)/nbins; xc=xmin+dx/2:dx:xmax-dx/2;
hs=hist(xs,xc); 
%normalizacao 
hs=hs/(n*dx);
figure(2)

x=0:dx/100:xmax;
plot(xc,hs,'b.',x,pkl(x,k,lambda),'r-')

%b)
k=2; lambda=1; xmax=14; xmin=0;
x=0:0.001:xmax;
% determinar o maximo de pkl
a=max(pkl(x,k,lambda));
%gerar pontos distribuidos uniformemente no retangulo
n=5300;
xP=xmin+(xmax-xmin)*rand(n,1); yP=a*rand(n,1);
% aceitar aqueles que tem yP<pkl(xP) sao os que estao abaico da curva
aceites=yP<=pkl(xP,k,lambda);
rejeitados=yP>pkl(xP,k,lambda);
xk=xP(aceites); naceites=numel(xk);
fprintf(1,'Fracao aceite=%f ,naceites=%d\n',naceites/n,naceites)

figure(3)
subplot(2,1,1)
plot(xP(aceites),yP(aceites),'b.',xP(rejeitados),yP(rejeitados),'r.',x,pkl(x,k,lambda),'k-')
hold on
plot([0, 0, xmax , xmax],[0, a, a,0],'r-')
xlabel('x'); ylabel('y')

xmax=max(xk); xmin=0;
nbins=20; dx=(xmax-xmin)/nbins; xc=xmin+dx/2:dx:xmax-dx/2;
hs=hist(xk,xc); 
%normalizacao 
hs=hs/(sum(hs)*dx);
figure(3)
subplot(2,1,2)
x=0:dx/100:xmax;
plot(xc,hs,'b.',x,pkl(x,k,lambda),'r-')
xlabel('x');ylabel('h norm')

%definir retangulos
nr=15; xmax=14; xmin=0; dx=(xmax-xmin)/nr;
xi=xmin+(0:nr)*dx; xs=xi+dx;
%altura do retangulo
figure(4)
x=0:dx/100:xmax;
plot(x,pkl(x,k,lambda),'k-')
hold on
xlabel('x');ylabel('y')
for i=1:nr
    x=xi(i):dx/100:xs(i);
    hr(i)=max(pkl(x,k,lambda));
    plot([xi(i) xi(i) xs(i) xs(i)],[0 hr(i) hr(i) 0],'r-')
end
ar=hr*dx;

    



