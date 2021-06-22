function [energias,np_med,emed2,nestados]=GasFotoesv1(T,tmax,nmin)

figure(1)
[nestados,energias,lviz,nv]=DensidadeEstados(nmin);

drawnow
np=zeros(nestados,1); % numero de particulas em cada estado
np_med=np; % calculo do numero medio de particulas em cada estado.
emed2=0; % para calculo do valor medio da energia ao quadrado

% sistema no estado fundamental sem qualquer fotao.
i0=find(energias==0);
nmedidas=0;
for t=1:1.1*tmax
    for estado=1:nestados
        if (estado  ~=i0)
         [np]=atualiza_np_estado(np,estado,T,energias);
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


     
        
    



