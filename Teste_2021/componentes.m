function  [comp]=componentes(listav,nv)

[n,kmax]=size(listav);
comp=zeros(n,1); % cada sitio pertencente a uma componente vai ser identificado 
%por um numero
verificado=zeros(n,1); %lista dos verificados
averificar=zeros(n,1); % lista dos sitios a verificar
n_averificar=0;
rotulo=0; % rotulo inicial

for i=1:n
    if verificado(i)==0 % ainda nao esta verificado
       verificado(i)=1; % passa a verificado
       % colocar na lista a verificar
       n_averificar=n_averificar+1; % aumenta o numero na lista a verificar
       averificar(n_averificar)=i; %colocado na lista a verificar
       rotulo=rotulo+1;
       comp(i)=rotulo; % atribuimos o rotulo ao nodo i
    end
    while  n_averificar > 0
        j=averificar(n_averificar); % vamos  verificar o nodo j (ultimo da lista
        n_averificar=n_averificar-1; %removemos esse nodo da lista averificar
        % adicionar os vizinhos desse nodo a' lista a verificar
        for jv=1:nv(j)
            comp(listav(j,jv))=rotulo; % os vizinhos têm o mesmo rotulo
            if verificado(listav(j,jv))==0 % se o vizinho nao estiver verificado
                % adicionamos o vizinho a' lista a verificar
                n_averificar=n_averificar+1;
                averificar(n_averificar)=listav(j,jv); % adicionado a lista
                verificado(listav(j,jv))=1;
            end
        end        
  
    end
    
end

end
