clear all
close all
figure(1)
n=10000;
u=rand(n,1);
x=zeros(n,1);
i1=find(u<1/2);
i2=find(u>=1/2);
x(i1)=sqrt(u(i1)/2)+3/2;
x(i2)=-sqrt((1-u(i2))/2)+5/2;

[hx,xb]=hist(x,100);
dx=xb(2)-xb(1);
hx=hx/n/dx;
x=3/2:0.01:5/2;

plot(xb,hx,'r.',x,px(x),'k-')
drawnow

% Metodo aceitação/rejeição
figure(2)

xmax=5/2; xmin=3/2; %
nr=20; % numero de retangulos
lr=(xmax-xmin)/nr;
xr=xmin:lr:xmax;

x=xmin:0.01:xmax;
for i=1:nr
    ir=find(x>=xr(i) & x<= xr(i+1)); % indices do vetor x com x dentro do retangulo
    hr(i) = max(px(x(ir))); % valor maximo dentro do retangulo
end
plot(x,px(x),'b-')
hold on
for i=1:nr
    plot([xr(i), xr(i), xr(i+1), xr(i+1)], [px(xr(i)),hr(i), hr(i), px(xr(i+1)) ], 'r-');
end
% area dos retangulos
a=hr*lr; pr=a/sum(a);
Nxa=n;
na=0;
nt=0;

drawnow


while (na <Nxa)
    nt=nt+1; % numero de tentativas
    % escolher um retangulo
    ir=roleta(nr,pr);
    % gerar x e y uniformes dentro do retangulo.
    xa=xr(ir)+lr*rand(1); ya=hr(ir)*rand(1);
  
    % verificar se aceitamos
    if (ya <= px(xa) )
        %aceitamos
        na=na+1; 
        %plot(xa,ya,'k.')
        rx(na)=xa; % valor guardado do numero aleatorio gerado
    %else
     %   plot(xa,ya,'r.')
    end
    
end
ta=na/nt % taxa de numeros aceites
% calculo do histograma normalizado
nbins=100;
[h,x]=hist(rx,nbins);
xmax=max(x); xmin=min(x);
dx=(xmax-xmin)/(nbins-1);
hn=h/(Nxa*dx); %histograma normalizado
plot(x,hn,'k.')

function p=px(x)
p=zeros(size(x));
i1=find(x<2);
i2=find(x>=2);
p(i1)=4*(x(i1)-3/2); p(i2)=-4*(x(i2)-5/2); 
end

function caso=roleta(nr,pr)
% escolhe um de nr casos com probabilidade de cada caso no vetor pr
u=rand(1);
pacum=0;
for i=1:nr
    pacum=pacum+pr(i);
    if u<=pacum;
        caso=i;
        return
    end
end
end
