function [energias,np_med,emed2,nestados]=GasFermiDiracv1(N,T,tmax,nmin)

figure(1)
[nestados,energias,lviz,nv]=DensidadeEstados(nmin);
drawnow
np=zeros(nestados,1); % numero de particulas em cada estado
np_med=np; % calculo do numero medio de particulas em cada estado.
emed2=0; % para calculo do valor medio da energia ao quadrado

lista=zeros(N,1); %lista de estados com particulas
ll=zeros(nestados,1); % posicao do estado na lista de estados com particulas


noc=0;

% sistema no estado fundamental
[aa,i]=sort(energias);
np(i(1:N))=1;
% Etotal=sum(np.*energias);
% EF=energias(i(N));
% fprintf('EF=%f, valor esperado= %f\n',EF, N^(2/3)*(3/(4*pi))^(2/3));
noc=N;
  
lista(1:noc)=i(1:N);
ll(i(1:N))=1:noc;



nmedidas=0;
for t=1:1.1*tmax
    for k=1:N
              
     % escolher um estado ocupado ao acaso
     i=randi(noc);
     
     estado=lista(i);
     iv=randi(nv(estado)); % escolhe um estado vizinho
     estadov=lviz(estado,iv);
     nocf=noc;
%      if(np(estadov)  ==0 && np(estado)>1 ) 
%                  nocf=noc+1;
%      end
     
         if np(estadov)==0
        dE=energias(estadov)-energias(estado);
        pa=min([1,(nv(estado)*noc)/(nv(estadov)*nocf)*exp(-dE/T)]);
        else
            pa=0;
        end
         
     if rand(1) < pa
         
         % atualizar a lista de estados ocupados
         
         %adicionar a lista estados que passaram a ter particulas.
         if (np(estadov)==0)
             noc=noc+1;
             lista(noc)=estadov;
             ll(estadov)=noc;
         end
         np(estadov)=np(estadov)+1;
         np(estado)=np(estado)-1;
         
          % retirar da lista estados que ficaram sem particulas
          if (np(estado)==0) 
             lista(ll(estado))=lista(noc);
             ll(lista(noc))=ll(estado);
             
             noc=noc-1;
             ll(estado)=0;
          end
          
     end
    end
    
     if t>= 0.1*tmax
         nmedidas=nmedidas+1;
         np_med=np_med+np;
          aux=sum(np.*energias);
          emed2=emed2+aux*aux;
         
     end
end

     
np_med=np_med/nmedidas;
emed2=emed2/nmedidas;


end


     
        
    



