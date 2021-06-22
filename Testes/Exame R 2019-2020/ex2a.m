function [Emedio] = ex2a(T ,nequi, nmedidas, nmax)

nk=zeros(nmax^3,1); 

E=0; %Energia inicial do sistema quando não ha fotoes

Emedio=0; 
npassos=nequi+nmedidas; % passo 2

for t=1:npassos
    for act=1:nmax^3
        ik=randi(nmax^3,1); 
 
        nx=mod(ik-1, nmax)+1; ny=floor(mod(ik-1,nmax^2)/nmax)+1; 
        nz=floor((ik-1)/nmax^2)+1;
        
        Eik=sqrt(nx^2+ny^2+nz^2)-sqrt(3);    
         
         % Escolher adicionar ou rwmover fotão
         if rand(1) <0.5
             % remover fotão 
             p=min([1, exp(Eik/T)]);
             if rand(1)  < p && nk(ik)>0
                 nk(ik)=nk(ik)-1;
                 E=E-Eik;
             end
         else
             %adicionar fotao
             p=min([1, exp(-Eik/T)]);
             if rand(1)  < p 
                 nk(ik)=nk(ik)+1;
                 E=E+Eik;
             end
         end  
    end
   if t> nequi
            Emedio=Emedio+E;
    end
end
Emedio=Emedio/nmedidas;

end
