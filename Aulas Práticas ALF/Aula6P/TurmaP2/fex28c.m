function [Emed, EDmed, Ev, nE]=fex28c(E0)

nmax= ceil(max(1,sqrt(E0^2-1)));
nk=zeros(nmax,nmax); % armazena o estado do sistema
nmedidas=10000; tdes=2000;
tmax=nmedidas+tdes;
E=0;
ED=E0;
Emed=0;
EDmed=0;
nkmed=zeros(nmax,nmax); 

for t=1:tmax
    for act=1: nmax^2
        % perturbacao do estado
        % escolher nx e ny uniformemente ( ao acaso).
        nx=randi(nmax,1);ny=randi(nmax,1);
        
        dE=sqrt(nx^2+ny^2); % energia necessaria para criar fota
        if rand(1) <= 0.5 % com probabilidade 0.5 criamos um fotao
            
            if dE<= ED % o demon tem energia suficiente
                nk(nx,ny)=nk(nx,ny)+1;
                ED=ED-dE;
                E=E+dE;
            end
        else % aniquilar um fotao
            if nk(nx,ny) >=1
                nk(nx,ny)=nk(nx,ny)-1;
                ED=ED+dE;
                E=E-dE;
            end
               
        end
            
        
    end
    if t> tdes
        % acumular valores para a media temporal
        Emed=Emed+E; 
        EDmed=EDmed+ED;
        nkmed=nkmed+nk;
    end
    
end

Emed=Emed/nmedidas;
EDmed=EDmed/nmedidas;
nkmed=nkmed/nmedidas;
% alinea c
deltaE=sqrt(2);
Ev=sqrt(2):deltaE: E0;
nE=zeros(1,numel(Ev));
for nx=1:nmax
    for ny=1:nmax
        E=sqrt(nx^2+ny^2);
        if E<=E0
            iE=floor((E-Ev(1))/deltaE)+1;
            nE(iE)=nE(iE)+nkmed(nx,ny);
        end
    end
end        
        

end