clear all
close all
%dados
t=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14];
ie=[1, 3, 7, 25, 72, 222 , 282, 256, 233, 189,123, 70, 25,11,4];
n=763;
%y0=condicao inicial
i0=1; s0=n-1; r0=0;
y0=[s0,i0,r0];

% determinar beta e gama que melhor se ajustam aos dados
x0=[0,1];
[x,chi2final]=fminsearch(@(x) quiquadrado(x),x0);
beta=x(1); gama=x(2);
fprintf(1,'Ajuste, beta=%f gama=%f \n', beta, gama)

%integracao numerica das equacoes diferenciais
ti=0:0.05:20; % 
[ti,yi]=ode45(@(t,y) FSIR(t,y,beta,gama), ti,y0);
ii=yi(:,2); %previsao de infecioso
s=yi(:,1); r=yi(:,3);
figure(1)
plot(t,ie,'rx',ti,ii,'k-')
xlabel('t'); ylabel('i')
figure(2)
plot(ti,s,'k-')
xlabel('t'); ylabel('s')
figure(3)
plot(ti,r,'k-')
xlabel('t'); ylabel('r')



function F=FSIR(t,y,beta,gama)
F(1)=-beta*y(1)*y(2);
F(2)=beta*y(1)*y(2)-gama*y(2);
F(3)=gama*y(2);
F=F';
end

function chi2=quiquadrado(x)
n=763;
te=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14];
ie=[1, 3, 7, 25, 72, 222 , 282, 256, 233, 189,123, 70, 25,11,4];
i0=1; s0=n-1; r0=0;
y0=[s0,i0,r0];
beta=x(1); gama=x(2);
ti=te; % 
[ti,yi]=ode45(@(t,y) FSIR(t,y,beta,gama), ti,y0);
ie=ie';
chi2=sum((yi(:,2)-ie).^2);
end

