close all
clear all
clc

% gerar rede aleatoria com distribuição de grau de Poisson
N=1e3; % numero de vertices
c=4; % numero medio de arestas em cada vértice
[listav,nv, S, comp]=rede_aleatoria(N,c);

% estado do sistema
e=zeros(N,1);
%suscetivel e=0; infecioso e=1; recuperado e=2;

% colocar um infecioso num sitio da componente gigante escolhido ao acaso
% numero de componentes 
nc=max(comp);
% determinar componebte gigante
for i=1:nc
    sz(i)=sum(comp==i); %tamanho da componente i
end
[S,cg]=max(sz); % S é  o tamanho da componente gigante e cg é o label da
%componente gigante
verticesCG=find(comp==cg); 
% escolher um ao acaso
i=randi(S,1); % escolhe um dos S ao acaso
%construimos o estado inicial
e(verticesCG(i))=1; % coloca este vertice como infetado
[kk,kmax]=size(listav); % kmax é o número de colunas de lista v



% atribuir vertices às classes

[classe,n_classe]=constroi_classe(N,e, listav, nv,kmax);

beta=1/5; gama=1/15; ntransicoes=1e4; 
fprintf(1,'N=%d, beta=%f, gama=%f, ntransicoes=%d\n', N,beta,gama,ntransicoes)
% fazer a simulação
[t,ns, ni, nr, ntr]=MC_tempo_continuo(N, beta, gama,listav, nv, e, kmax, n_classe, classe,ntransicoes);

figure(1)
plot(t(1:ntr),ns(1:ntr),'b-', t(1:ntr),ni(1:ntr),'r-', t(1:ntr),nr(1:ntr),'k-')
xlabel('t'); ylabel('ns, ni, nr')
legend('ns', 'ni' , 'nr','Location','NorthEastOutside')



function [classe,n_classe]=constroi_classe(N,e, listav, nv,kmax)
classe=zeros(N,kmax+1); %inicializaçao da matriz das classes
n_classe=zeros(kmax+1,1); % regista o numero de vertices em cada classe
for i=1:N
    % suscetiveis
    if e(i)==0 % vertice suscetivel
        % calcular numero de vizinhos infetados
        nvi=0;
        for j=1:nv(i)
            if e(listav(i,j))==1 % esta infetado
                nvi=nvi+1;
            end
        end
        if nvi>0
            n_classe(nvi)=n_classe(nvi)+1; 
            classe(n_classe(nvi),nvi)=i; % colocamos o vertice i na classe ni
        end
    elseif e(i)==1
        n_classe(kmax+1)=n_classe(kmax+1)+1; % aumentamos o numero na classe dos infetados
        classe(n_classe(kmax+1),kmax+1)=i;
    end
           
end

end

function [t,ns, ni, nr,ntransicoes]=MC_tempo_continuo(N, beta, gama,listav, nv, e, kmax, n_classe, classe,ntransicoes)
ns=zeros(ntransicoes,1); ni=ns; nr=ns;
ns(1)=sum(e==0); ni(1)=sum(e==1); nr(1)=N-ns(1)-ni(1);
t=zeros(ntransicoes,1); pr=zeros(kmax+1,1);
for tr=1:ntransicoes
    if (mod(tr,1000)==0)
        fprintf(1,'Transicao tr=%d\n',tr)
    end
    % copia informacao do instante anterior
    ns(tr+1)=ns(tr); ni(tr+1)=ni(tr); nr(tr+1)=nr(tr);
    
    % taxa total de transicao
    lambda=sum(beta*[1:kmax]'.* n_classe(1:kmax))+gama*n_classe(kmax+1);
    if lambda==0
        ntransicoes=tr-1;
        fprintf(1,'Epidemia Terminou, Número de transições=%d\n', ntransicoes)
        return
    end
    % tempo para a transicao com distribuição exponencial
    tau=-log(1-rand(1))/lambda; % tempo de espera até se observar transicao
    t(tr+1)=t(tr)+tau; % instante de tempo em que se d'a a transição
    %fazer a transicao
    % escolher ao caso com probabiloidade pr uma das classes
    i=[1:kmax]';
    
    pr(i)=i.*n_classe(1:kmax)*beta/lambda;
    pr(kmax+1)=gama*n_classe(kmax+1)/lambda;
   
    caso=roleta(kmax+1,pr); % indica-nos em que classe vai ocorrer a transição
    % escolher um vertice da classe para fazer a transição
    
    if caso ~= kmax+1
        % um suscetivel infetou
        ns(tr+1)=ns(tr+1)-1; ni(tr+1)=ni(tr+1)+1;
        %escolher um dos suscetiveis da classe
        i=randi(n_classe(caso),1);
        e(classe(i,caso))=1; % infetou 
    else
        i=randi(n_classe(kmax+1),1); % escolher um infetado ao acaso
        e(classe(i,kmax+1))=2; % o infetado recuperou
        ni(tr+1)=ni(tr+1)-1; nr(tr+1)=nr(tr+1)+1;
    end
    
    % atualiza a matriz das classes
    % pode fazer-se a atualizacao de modo muito mais eficiente 
    % o que faz nesta versao é construir a matriz classe de novo
    [classe,n_classe]=constroi_classe(N,e, listav, nv,kmax);
    
end

end





