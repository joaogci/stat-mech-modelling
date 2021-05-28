% clear all
% close all
function [Emed,EDmed, Ev, nE]=fex28c(E0)

%E0=10; % Energia total do sistema
nmax=min( max(1,floor(sqrt(E0^2-1))) ,20); % nxmax=nymax % limita nmax a 20

nk=zeros(nmax,nmax); % nk representa o estado do sistema. Começamos com o
%sistema sem fotoes

tmax=12000;
ED=E0; % inicialmente o Demon tem toda a energia
E=0;
tdes=2000;
Emed=0; EDmed=0; nmedidas=0;
nkmed=zeros(nmax,nmax);

for t=1: tmax % ciclo temporal
    for act=1:nmax^2 %atualizacoes
        % escoher (nx,ny) ao acaso
        nx=randi(nmax,1); ny=randi(nmax,1);
        % escolher adicionar ou remover fotao
        if rand(1) <=0.5 % adicionar
            dE=sqrt(nx^2+ny^2); % variacao energia associada a criaçao de um fotao
            if dE <= ED % se o Demon tiver energia suficiente para dar
                nk(nx,ny)=nk(nx,ny)+1; % criamos fotao
                E=E+dE; ED=ED-dE;
            end
        else %remover fotao
            if nk(nx,ny) >=1
            nk(nx,ny)=nk(nx,ny)-1;
            dE=-sqrt(nx^2+ny^2);
            E=E+dE; ED=ED-dE;
            end
        end
        
    end
    if t>=tdes
        nmedidas=nmedidas+1;
        Emed=Emed+E;
        EDmed=EDmed+ED;
        nkmed=nkmed+nk;
    end
    
end
Emed=Emed/nmedidas;
Emed=Emed-sqrt(2); % para obter acordo com a expressao teorica
% e' necessario subtrair a energia minima que um fotao pode ter.
% A expressao teorica assume implicitamente que a energia minima 
% de um fotao e' zero.

EDmed=EDmed/nmedidas;
nkmed=nkmed/nmedidas;
% Calculo do nE = numero medio de fotoes com uma dada energia
%Emax=sqrt(nmax^2+nmax^2);
Ev=sqrt(2):1:E0; % bins de energia
deltaE=Ev(2)-Ev(1);

nE=zeros(numel(Ev),1); % vetor com o numero medio de fotoes com uma dada energia

for nx=1: nmax
    for ny=1:nmax
        E=sqrt(nx^2+ny^2);
        if (E <=E0)
        iE=floor((E-Ev(1))/deltaE )+1;
        nE(iE)=nE(iE)+nkmed(nx,ny);
        end
       
    end  
end


end
