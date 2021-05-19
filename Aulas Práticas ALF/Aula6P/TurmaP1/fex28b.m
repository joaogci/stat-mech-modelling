% clear all
% close all
function [Emed,EDmed]=fex28b(E0)

%E0=10; % Energia total do sistema
nmax=min( max(1,floor(sqrt(E0^2-1))) ,50); % nxmax=nymax % limita nmax a 20

nk=zeros(nmax,nmax); % nk representa o estado do sistema. Começamos com o
%sistema sem fotoes

tmax=12000;
ED=E0; % inicialmente o Demon tem toda a energia
E=0;
tdes=2000;
Emed=0; EDmed=0; nmedidas=0;
for t=1: tmax % ciclo temporal
    for act=1:nmax^2 %atualizacoes
        % escoher (nx,ny) ao acaso
        nx=randi(nmax,1); ny=randi(nmax,1);
        % escolher adicionar ou remover fotao
        if rand(1) <=0.5 % adicionar
            dE=sqrt(nx^2+ny^2); %-sqrt(2); % variacao energia associada a criaçao de um fotao
            if dE <= ED % se o Demon tiver energia suficiente para dar
                nk(nx,ny)=nk(nx,ny)+1; % criamos fotao
                E=E+dE; ED=ED-dE;
            end
        else %remover fotao
            if nk(nx,ny) >=1 % se existir pelo menos um fotao
            nk(nx,ny)=nk(nx,ny)-1;
            dE=-(sqrt(nx^2+ny^2)); %-sqrt(2));
            E=E+dE; ED=ED-dE;
            end
        end
        
    end
    if t>=tdes
        nmedidas=nmedidas+1;
        Emed=Emed+E;
        EDmed=EDmed+ED;
    end
    
end
Emed=Emed/nmedidas; 

EDmed=EDmed/nmedidas;
end
