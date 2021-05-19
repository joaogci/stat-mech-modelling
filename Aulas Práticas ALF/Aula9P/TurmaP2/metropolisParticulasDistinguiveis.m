function [Emedio,E2medio, nkmedio] = metropolisParticulasDistinguiveis(T ,nequi, nmedidas,N, nmax)
nk=zeros(nmax^2,1);% regista o numero de particulas em cada estado
estado_particula=zeros(N,1);% regista estado da particula
E=2*N;
estado_particula(:)=1; % todas as particulas no estado 1
nk(1)=N; %todas as particulas no estado 1
npassos=nequi+nmedidas;
[listav, nv]=lista_vizinhos(nmax);
Emedio=0; E2medio=0;
nkmedio=zeros(nmax^2,1);

for t=1:npassos
    for act=1:N
        ip=randi(N,1); % escolhemos uma das N particulas ao acaso
        ik=estado_particula(ip); % estado em que se encontra
        % escolher um k vizinho de k
        % escolher k vizinho ao acaso
        iv=randi(nv(ik),1); 
        ikv=listav(ik,iv); % k vizinho
        % calculo da variacao de energia
        nx=mod(ik-1,nmax)+1; ny=floor((ik-1)/nmax)+1;
        nxv=mod(ikv-1,nmax)+1; nyv=floor((ikv-1)/nmax)+1;
        dE=nxv^2+nyv^2-(nx^2+ny^2);
        pA=min([1, (nv(ik)/nv(ikv))*exp(-dE/T)]);
        if rand(1) <= pA
            nk(ik)=nk(ik)-1;
            nk(ikv)=nk(ikv)+1;
            E=E+dE;
            estado_particula(ip)=ikv;
            
        end
          
    end
    
    if t>nequi
        Emedio=Emedio+E;
        E2medio=E2medio+E^2;
        nkmedio=nkmedio+nk;
    end
    
end
Emedio=Emedio/nmedidas;
E2medio=E2medio/nmedidas;
nkmedio=nkmedio/nmedidas;

end