clear all
close all
N=30; % 30 particulas no total
%0<=N1<=N são N+1 estados
% a dimensao da matriz Pi de probabilidades de transição é (N+1)x(N+1)
%Pi(i,j)= probabilidade de transitar de j para i 
%a)
Pi=zeros(N+1,N+1);
for j=1:N+1 % percorrer todos os estados iniciais
    N1=j-1; % numero de particulas quando o sistema se encontra no estado j
    i1=j+1; i2=j-1; % estados finais possiveis
    if i1<=N+1
        Pi(i1,j)=1-N1/N;
    end
    if i2>=1
        Pi(i2,j)=N1/N;
    end
end
%b Determinar os vetores proprios e valores proprios da matriz Pi

[V,D] = eig(Pi);
[vp,i]=sort(diag(D),'descend'); % o maior valor proprio e' 1
ps1=V(:,i(1))/sum(V(:,i(1))); % vetor proprio com valor proprio 1

figure(1)
n1=0:N;
pst=factorial(N)./(factorial(N-n1).*factorial(n1)) * 2^(-N);
plot(n1,ps1,'.', n1,pst,'r-')
xlabel('N_1'); ylabel('P_{st}(N_1)');

%c
npassos=10000;
%simulacao da cadeia Markov
N1=zeros(npassos+1,1); % guardar a variacao de N1 no tempo
N1(1)=N; % todas as particulas na caixa 1
% simulacao de uma realizacao
for t=1:npassos
    w1=1-N1(t)/N; % probabilidade de aumentar
    %w2= N1/N; % probabilidade de diminuir 
    if rand(1) <= w1
        N1(t+1)=N1(t)+1;
    else
        N1(t+1)=N1(t)-1;
    end
    
end
figure(2)
plot(1:npassos+1, N1, 'k-')
xlabel('t'); ylabel('N1(t)')
tequi=100; % passos a desprezar pra atingir regime estacionario
[h, xh]=hist(N1(tequi:end),0:N); % histograma no regime estacionario

h=h/sum(h);

figure(1)
hold on
plot(xh, h,'kx')

%d
nreal=100; npassos=200;
N1med=zeros(npassos+1,1);
for real=1: nreal
    
N1=zeros(npassos+1,1); % guardar a variacao de N1 no tempo
N1(1)=N; % todas as particulas na caixa 1
% simulacao de uma realizacao
for t=1:npassos
    w1=1-N1(t)/N; % probabilidade de aumentar
    %w2= N1/N; % probabilidade de diminuir 
    if rand(1) <= w1
        N1(t+1)=N1(t)+1;
    else
        N1(t+1)=N1(t)-1;
    end
    
end
% media sobre as varias realizacos
N1med=N1med+N1;
end
N1med=N1med/nreal; % media sobre as varias realizacoes

figure(3)
t=0:npassos;
N1mediot=N/2+(N1(1)-N/2).*exp(-t*log(1/(1-2/N)));

plot(t,N1med,'k-',t,N1mediot,'r-')
xlabel('t'); ylabel('<N1>')
axis([0 npassos 0 N])



    