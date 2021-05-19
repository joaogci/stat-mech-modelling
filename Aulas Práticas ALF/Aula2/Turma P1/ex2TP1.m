clear all
close all
figure(1) 
%variavel x
%bins
n=1e4;
u=rand(n,1);
lambda=1; x=-(1/lambda)*log(1-u);

xmax=max(x);
nbins=20; dx=(xmax-0)/nbins;
bins=dx/2:dx:xmax-dx/2;


[h]=hist(x,bins);
% normalizaçao do histograma 
hn=(h/sum(h))/dx;
%p(x)=lambda*exp(-lambda*x)
x=0:0.01:xmax;
plot(bins,hn,'x',x,lambda*exp(-lambda*x),'r-')
xlabel('x')
ylabel('p(x)');

k=2; % numero a somar
u=rand(n,k); % matriz de n linhas e k colunas 
xk=-(1/lambda)*log(1-u);
xs=sum(xk,2); % somar para cada linha os numeros nas k colunas

figure(2)
xmax=max(xs);
nbins=20; dx=(xmax-0)/nbins;
bins=dx/2:dx:xmax-dx/2;

[h]=hist(xs,bins);
% normalizaçao do histograma 
hn=(h/sum(h))/dx;
%pk(x)=lambda^k*x^(k-1)*exp(-lambda*x)/gamma(k)
x=0:0.01:xmax;
plot(bins,hn,'x',x,lambda^k*x.^(k-1).*exp(-lambda*x)/gamma(k),'r-')
xlabel('x')
ylabel('pk(x)');

%b)

k=5; lambda=1;
n=1000;
xmax=20;
x=0:0.01:xmax; 
a=max(pklambda(x,lambda,k));

na=0; nt=0;
 figure(3)
subplot(2,1,1)
plot(x,pklambda(x,lambda,k),'k-')
xlabel('x'); ylabel('y')
hold on

 while na<n
   % gerar pontos no interior do retangulo
   nt=nt+1; % numero de tentativas
   xP(nt)=rand(1)*xmax; yP(nt)=a*rand(1);
   if yP(nt)<=pklambda(xP(nt),lambda,k); % ponto esta abaixo da curva
       na=na+1;
       xA(na)=xP(nt); % coordenadas xP dos pontos  abaixo da curva p(x) 
   end
 end
 subplot(2,1,1)
       iazul=find(yP<pklambda(xP,lambda,k));
       plot(xP(iazul),yP(iazul),'b.')
       ivermelho=find(yP>pklambda(xP,lambda,k));
       plot(xP(ivermelho),yP(ivermelho),'r.')
       
       drawnow
   fprintf(1,'Fracao dos pontos gerados que é rejeitada=%f\n', (nt-n)/nt)
   

   % fazer o histograma e comparar com o esperado
xmax=max(xA);
nbins=20; dx=(xmax-0)/nbins;
bins=dx/2:dx:xmax-dx/2;

[h]=hist(xA,bins);
% normalizaçao do histograma 
hn=(h/sum(h))/dx;
%pk(x)=lambda^k*x^(k-1)*exp(-lambda*x)/gamma(k)
x=0:0.01:xmax;

subplot(2,1,2)
plot(bins,hn,'x',x,pklambda(x,lambda,k),'r-')
xlabel('x')
ylabel('pk(x)');

%c)
nr=10; % numero de retangulos
xmax=20;
dx=(xmax-0)/nr;
xi=(0:(nr-1))*dx; % limite inferor em x de cada retangulo
xs=xi+dx; % limite superior em x de cada retangulo
figure(4)
x=0:0.01:xmax;
plot(x,pklambda(x,lambda,k),'k-')
hold on

for i=1:nr
    x=xi(i):dx/100:xs(i);
    hr(i)=max(pklambda(x,lambda,k));
    plot([xi(i),xi(i)],[pklambda(xi(i),lambda,k), hr(i)],'r-') % traco verical esquerda
    plot([xi(i),xs(i)],[hr(i),hr(i)],'r-')
    plot([xs(i),xs(i)],[hr(i),pklambda(xs(i),lambda,k)],'r-')
    
end

 
