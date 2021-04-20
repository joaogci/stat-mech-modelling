clear all
close all
n=1e3; %  numero de numeros aleatorios
% uniformes no intervalo [0,1]
u=rand(n,1);

% verificar se a distribuição uniforme
% calcular
nbins=20; xmax=1; xmin=0;
dx=(xmax-xmin)/nbins; % largura de cada caixa
xc=xmin+dx/2:dx:xmax-dx/2; % posicao do centro das caixas
h=hist(u,xc);
%normalizar
hn=h/(sum(h)*dx);
% comparar graficamente
figure(1)
x=xmin:dx/100:xmax;
pu=ones(1,numel(x));
plot(xc,hn,'.', x,pu,'r-')
xlabel('u'); ylabel('p(u)')
axis([xmin,xmax,0,1.2])
%fazer a transformação de variaveis
theta=acos(1-2*u);
% calcular
%nbins=20; 
xmax=pi; xmin=0;
dx=(xmax-xmin)/nbins; % largura de cada caixa
xc=xmin+dx/2:dx:xmax-dx/2; % posicao do centro das caixas
h=hist(theta,xc);
%normalizar
hn=h/(sum(h)*dx);
% comparar graficamente
figure(2)
x=xmin:dx/100:xmax;
ptheta=sin(x)/2;
plot(xc,hn,'.', x,ptheta,'r-')
xlabel('theta'); ylabel('p(theta)')

u2=rand(n,1);  phi=2*pi*u2;
figure(3)
x=sin(theta).*cos(phi);y=sin(theta).*sin(phi);z=cos(theta);
plot3(x,y,z,'.')
axis equal

