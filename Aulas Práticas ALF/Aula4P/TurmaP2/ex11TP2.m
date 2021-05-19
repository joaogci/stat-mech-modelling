clear all
close all
%a
N=30; % numero de particulas 
nestados=N+1; % numero de estados
Pi=zeros(nestados,nestados); % matriz das probabilidades de transicao
% estado i corresponde ao compartimento 1 ter N1= i-1 particulas
for i=1:nestados
    N1=i-1;
    if  N1>0
    Pi(i-1 ,i)=N1/N; % probabilidade de diminuir em 1 particula
    end
    if N1<N
    Pi(i+1,i)=1-N1/N; % probabilidade de aumentar em 1 particula
    end 
end
%b 
%Determinar vetores proprios e valores proprios da matriz Pi

[V, D]=eig(Pi); % determina os vetores proprios V (sao as colunas da matriz V)
% e os valores proprios dao os elementos da diagonal da matriz diagonal D
vp=diag(D); % cria vetor com a diagonal de D
% valor proprio 1 é o maior valor próprio
[vp, i]=sort(vp,'descend');
pest=V(:,i(1))/sum(V(:,i(1))); % probabilidade estacionaria (para tempos longos)
figure(1)
N1=0:N;
pest_teorica=factorial(N)./(factorial(N1).*factorial(N-N1)) * 2^(-N);
plot(N1,pest,'x',N1,pest_teorica,'r-')
xlabel('N_1'); ylabel('p_{est}')

% c simulacao - gerar uma realizaçao do processo estocastico
N1=N; % valor inicial - todas as particulas no compartimento 1
npassos=10000; % numero de passos
N1t=zeros(npassos+1,1);
N1t(1)=N1;
for t=1: npassos
    wdiminuir=N1/N;
    if rand(1) < wdiminuir
        N1=N1-1;
    else
        N1=N1+1;
    end
    N1t(t+1)=N1;
end
figure(2)
t=0:npassos;
plot(t,N1t,'b-')
xlabel('t'); ylabel('N_1(t)')
test=100;
[h]=hist(N1t(test:end),0:N); % calcula o histograma dos valores observados
%em regime estacionario
hn=h/sum(h); %normaliza o histograma
figure(1)
hold on
plot(0:N,hn,'s')

%d Calcular a media de N1(t) sobre 100 realizacoes

nreal=200;
npassos=100; % numero de passos
N1medt=zeros(npassos+1,1);
erro=zeros(npassos+1,1);
for real=1:nreal
N1=N; % valor inicial - todas as particulas no compartimento 1
N1t=zeros(npassos+1,1);
N1t(1)=N1;
for t=1: npassos
    wdiminuir=N1/N;
    if rand(1) < wdiminuir
        N1=N1-1;
    else
        N1=N1+1;
    end
    N1t(t+1)=N1;
end
N1medt=N1medt+N1t;
erro=erro+N1t.^2;

end

N1medt=N1medt/nreal; 
erro=erro/nreal; % calcula a media do numero de particulas ao quadrado
%<N1(t)^2>
erro=sqrt(erro-N1medt.^2)/sqrt(nreal); %erro padrao ou erro na media

figure(3)
t=0:npassos;
errorbar(t,N1medt,erro,'k-')
hold on
N1medTeorico=N/2+(N-N/2)*exp(-t*log(1/(1-2/N)));
plot(t,N1medTeorico,'r-')
xlabel('t')
ylabel('<N_1(t)>')
axis([0 npassos 0 N]);


