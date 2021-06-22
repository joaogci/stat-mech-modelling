function [Emedio,E2medio, nkmed]=metropolis(T,nequi,nmedidas,N,nmax)

[lv,nv]=listv_sem_cfp(nmax); % inicializa a lista de vizinhos lv e numero de vizinhos nv para a rede
%quadrada de comprimento nmax onde cada estado esta definido

nk=zeros(nmax,nmax,1); % array com o numero de particulas em cada estado
% a matriz pode ser acedida com 1 indice ou com dois indices
nkmed=nk; % matriz para calculo do valor medio da matriz nk
nk(1)=N; % todas as particulas estao no estado 1 com nx=1 e ny=1
estado_particula=ones(N,1); %inicialmente todas as particulas estao no estado 1

E=2*N;     %  energia total inicial   

npassos=nmedidas+nequi; % numro total de passos
Emedio=0; E2medio=0; % variaveis para calculo dos valores medios inicializadas a zero

for t=1:npassos % ciclo do numero de passos
    for iter=1:N % itreacoes sobre particulas - para atualizar o estado de uma particula uma vez em cada passo 
        % em media
        %escolhe uma particula ao acaso
        ip=floor(N*rand(1))+1; % a funçao randi parece ser muito lenta ip=randi(N,1);
        ik=estado_particula(ip); % determina o estado em que se encontra
        % escolhe estado vizinho
         id=floor(nv(ik)*rand(1))+1;%id=randi(nv(ik),1);
        ikv=lv(ik,id);
        % indices nx,ny do estado ik
        nx=mod(ik-1,nmax)+1;ny=floor(ik/nmax)+1;
         % indices nx,ny do estado ikv
         nxv=mod(ikv-1,nmax)+1;nyv=floor((ikv-1)/nmax)+1;
    
        % calcula variaçao de energia
            dE=nxv^2+nyv^2-(nx^2+ny^2);
            if (rand(1) <= min(1,nv(ik)*(nk(ikv)+1)/(nv(ikv)*nk(ik))*exp(-dE/T)) ); 
                % se for aceite muda-se a particula para o novo estado
                nk(ikv)=nk(ikv)+1;
                nk(ik)=nk(ik)-1;
                E=E+dE;
                estado_particula(ip)=ikv;
            end
            
            end
        
    
    if t>nequi
        % acumular variaveis para calculo de medias
        Emedio=Emedio+E;
        E2medio=E2medio+E*E;
        nkmed=nkmed+nk;
       
    end
end

Emedio=Emedio/nmedidas;
E2medio=E2medio/nmedidas;
nkmed=nkmed/nmedidas;

end

            
           
        
        