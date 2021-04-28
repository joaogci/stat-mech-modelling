
function [Emedio,EDmedio]=fteste1a(N,E0,nequi, npassos)
%E0 = Energia total 
%N = numero de particulas
%particulas discerniveis

n1=floor((N-E0)/2);
E=N-2*n1;
ED=E0-E;
s=-ones(N,1); %  caixa das particulas
s(n1+1:N)=1;

nmedidas=npassos-nequi;

EDmedio=0; Emedio=0;
for t=1: npassos
    
    for nact=1:N
        
    % perturbar o estado de uma particula escolhida ao acaso
    
    %escolher a particula
    ip=randi(N,1);
    
    dE=-2*s(ip);

        if dE<0
           % aceitamos a perturbacao
          s(ip)=-s(ip);
           E=E+dE;
           ED=ED-dE;
        else
            if dE<=ED
               s(ip)=-s(ip);
               E=E+dE;
               ED=ED-dE;   
            end
        end
            
    end% end nact  
        

    if t> nequi
        EDmedio=EDmedio+ED;
        Emedio=Emedio+E;
    end
    
end %end t

Emedio=Emedio/nmedidas;
EDmedio=EDmedio/nmedidas;

end
