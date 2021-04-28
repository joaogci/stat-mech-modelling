
function [Emedio,EDmedio]=fteste1b(N,E0,nequi, npassos)
%E0 = Energia total 
%N = numero de particulas
%particulas discerniveis
n=zeros(2,1);
en(1)=-1; en(2)=1;
n(1)=floor((N-E0)/2);

E=N-2*n(1);
ED=E0-E;

n(2)=N-n(1);

nmedidas=npassos-nequi;

EDmedio=0; Emedio=0;
for t=1: npassos
   % perturbar o estado de uma particula escolhida ao acaso
   for act=1:2
    %escolher caixa
         ip=randi(2,1);
  
         dE=-2*en(ip);

        if dE<0 
            if  n(1)<N
           % aceitamos a perturbacao
           n(2)=n(2)-1; n(1)=n(1)+1;
           E=E+dE;
           ED=ED-dE;
            end
        else
            if dE<=ED 
                   if n(1) >=1 
                   n(2)=n(2)+1;n(1)=n(1)-1;
                   E=E+dE;
                   ED=ED-dE;   
                   end
              
            end
        end
     end           
       

    if t> nequi
        EDmedio=EDmedio+ED;
        Emedio=Emedio+E;
    end

end %end t

Emedio=Emedio/nmedidas;
EDmedio=EDmedio/nmedidas;

end
