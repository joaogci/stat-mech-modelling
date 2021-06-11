function [listav,nv, S, comp]=rede_aleatoria(n,c)

%criar rede aleatória
%n = numero total de nodos
%c=numero medio de vizinhos ou grau medio

p=c/(n-1); % probabilide de uma aresta existir
kmax=floor(10*c); %numero maximo de vizinhos admitido

listav=zeros(n,kmax);
nv=zeros(n,1);
for i=1:n
    for j=i+1:n
        if rand(1) <=p
            nv(i)=nv(i)+1; nv(j)=nv(j)+1;
            listav(i,nv(i))=j; listav(j,nv(j))=i;
        end
    end
end

comp=componentes(listav,nv);

ncomponentes=max(comp); % numero de componentes

% calcular tamanho das componentes
scomp=zeros(n,1); % tamanho de cada componente
for rotulo=1:ncomponentes
    scomp(rotulo)=sum(comp==rotulo); % calcula o numero de nodos
    % no vetor com que e' igual ao rotulo
end
[S,rS]=max(scomp); % a componente gigante e' a componente com maior tamanho

S=S/n;


end

        