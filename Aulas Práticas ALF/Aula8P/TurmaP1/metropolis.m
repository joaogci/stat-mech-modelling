function [Emedio,E2medio, nkmed] = metropolis(T ,nequi, nmedidas,N, nmax)
nk=zeros(nmax^2,1); % vetor que regista o numero de particulas em cada estado
nk(1)=N;
E=2*N;
estado_particula=ones(N,1); % vetor que regista estado de cada uma das N particulas;
npassos=nequi+nmedidas;
[listav, nv]=lista_vizinhos(nmax);
Emedio=0; E2medio=0; nkmed=zeros(nmax^2,1);
for t=1:npassos
    for act=1:N
        % transição para outro estado
        % escolher uma das N particulas ao acaso
        ip=randi(N,1); % inteiro aleatorio uniforme entre 1 e N
        ik=estado_particula(ip); % estado da particula ip escolhida
        % precisamos de uma lista de estados vizinhos do estado ik.
        % escolha de vizinho ao acaso
        iv=randi(nv(ik),1);
        ikv=listav(ik,iv); %Estado vizinho  escolhido ao acaso
        %calculo da variacao de energia quando a particula se move para o
        % estado vizinho
       nx=mod(ik-1,nmax)+1; ny=floor((ik-1)/nmax)+1;
       nxv=mod(ikv-1,nmax)+1; nyv=floor((ikv-1)/nmax)+1;
       dE=nxv^2+nyv^2-(nx^2+ny^2);
       % determinamos se aceitamos o novo estado proposto
       pA=min([ 1, (nv(ik)/nv(ikv))*(nk(ikv)+1)/(nk(ik))*exp(-dE/T) ]);
       if rand(1) <= pA
           E=E+dE;
           nk(ik)=nk(ik)-1;
           nk(ikv)=nk(ikv)+1;
           estado_particula(ip)=ikv;
       end
     
    end  
    if t> nequi
        Emedio=Emedio+E;
        E2medio=E2medio+E^2;
        nkmed=nkmed+nk;
    end
end
Emedio=Emedio/nmedidas;
E2medio=E2medio/nmedidas;
nkmed=nkmed/nmedidas;

end