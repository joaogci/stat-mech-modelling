clear all
close all
n=1e4;
i=0;
cv=0.5:0.1:3;
for c=cv
    
 i=i+1;   
[listav,nv, S(i), comp]=rede_aleatoria(n,c);
% tamanho de cada componente
scomp=zeros(n,1); % tamanho de cada componente
ncomponentes=max(comp); % numero de componentes
%calcula o tamanho de cada componente
for rotulo=1:ncomponentes
    scomp(rotulo)=sum(comp==rotulo); % calcula o numero de nodos
    % no vetor comp que e' igual ao rotulo
end
% determinar o numero de components de tamanho s
ns=zeros(n,1);
[S(i),rS]=max(scomp); % rS é o rótulo da componente gigante
S(i)=S(i)/n; % fraçao de nodos na componente gigante
for  rotulo=1:ncomponentes % ciclo nas componentes
    % nao podemos contar a componente gigante se c>1. Se c<1  nao existe
    % componente gigante
    if c>1
    if rotulo ~= rS % excluimos a componente gigante
       ns(scomp(rotulo))=ns(scomp(rotulo))+1; % contamos uma componente com tamanho scomp(i) 
    end
    else % caso c <=1
        ns(scomp(rotulo))=ns(scomp(rotulo))+1;
    end
end

s=1:n;s=s';
R(i)=sum(s.*ns)/sum(ns); %produto interno de s e ns
smed(i)=sum(s.^2.*ns)/sum(s.*ns);%(n*(1-S(i)));
end

figure(1)
plot(cv, S, 'rx')
xlabel('c'); ylabel('S')

figure(2)
plot(cv,R,'rx',cv,smed,'ko')
%axis([0,3,0,8])
xlabel('c'); ylabel('R,<s>')

