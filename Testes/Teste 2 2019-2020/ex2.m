function ex2()
clear all
close all
Nv=[1e3, 5e3, 1e4];
strplot=['k.';'gx';'b+'];
for in=1: numel(Nv)
    N=Nv(in);
ic=0; cv=0.5:0.1:2;
for c=cv
    ic=ic+1;
[listv,nv,lista_sitios]=rg(N, c);
ncomp=numel(unique(lista_sitios));
fprintf(1,'numero de componentes=%d\n',ncomp)
for i=transpose(unique(lista_sitios))
    tamanho_comp(i)=sum(lista_sitios==i);
end
[S(ic),lmax]=max(tamanho_comp); S(ic)=S(ic)/N;
tamanho_comp=sort(tamanho_comp,'descend');
susc(ic)=sum(tamanho_comp(2:ncomp).^2)/sum(tamanho_comp(2:ncomp));

 St(ic)=pfixo(c);

fprintf(1,'S=%f Valor teorico=%f\n',S(ic),St(ic))

end
figure(1)
   
plot(cv,S,strplot(in,:),cv, St,'r-')
hold on
xlabel('c'); ylabel('S')

figure(2)
plot(cv,susc,strplot(in,:))
hold on
xlabel('c'); ylabel('Susc')
end
end

function St=pfixo(c)
St=1; dS=1; lambda=0.1;
while dS>1e-7
    Sto=St;
    St=Sto-lambda*(Sto-1+exp(-c*Sto));
    dS=abs(St-Sto); 
end
end

function [listv,nv,lista_sitios]=rg(N, c)
% c=<k> numero medio de vizinhos de um vertice
kmax=floor(c+10);
p=c/(N-1);
% percorrer todos os edges possiveis
listv=zeros(N,kmax);
nv=zeros(N,1);
for i=1:N-1
    for j=i+1:N
        if rand(1)<=p
            %edge existe
            nv(i)=nv(i)+1;
            nv(j)=nv(j)+1;
            listv(i,nv(i))=j;
            listv(j,nv(j))=i;
        end
    end
    end
    %calculo <k>
km=sum(nv)/N;
fprintf(1,'Valor desejado=%f Valor obtido <k>=%f\n', c, km)
lista_sitios=componentes(N,listv, nv);
end

function lista_sitios=componentes(N,listav, nv)
%esta funcao acabou por ficar bastante elegante e simples
% Ja tinha programado por varias vezes e nunca saiu tao elegante
%Nao testei para uma rede geometrica danificada mas deve funcionar tambem 
%ALF

lista_sitios=zeros(N,1);
ip=0; % ultimo analisado
label=0; % label das componentes
while ip<N
    ip=ip+1;
    if lista_sitios(ip)==0 % ainda nao foi analisado
     label=label+1; %aumenta label
     lista_sitios(ip)=label; %atribui label
   
     % cria lista de vizinhos que necessariamente ainda nao tem
    %label
    la= listav(ip,1:nv(ip));
    lista_sitios(la)=label;  % da o mesmo label aos vizinhos
    na=numel(la);
     % analisa a lista enquanto ela tiver sitios  
    while na>0
    i=la(1);  la=la(2:end);  %comeca pelo primeiro e remove-o da lista
    la=[ la listav(i,lista_sitios(listav(i,1:nv(i)))==0)]; % adiciona a' lista os vizinhos  
    %que ainda nao foram colocados na lista
    
    %atribui o mesmo label aos novos membros
    lista_sitios(listav(i,lista_sitios(listav(i,1:nv(i)))==0))=label;
    
    na=numel(la); %determina o novo tamanho da lista
    end
 end
end
end


    