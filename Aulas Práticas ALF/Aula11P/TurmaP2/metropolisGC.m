function  [Nt]=metropolisGC(npassos, nequi, N, V, bmu)
ni=zeros(V,1); % estado do sistema
lista=zeros(V,1); % registar o sitio onde se encontra cada uma das particulas
nmedidas=npassos-nequi;
Nt=zeros(nmedidas,1);

% distribuir as particulas ao acaso N particulas pelos V sitios
n=0;
while n< N
    % escolher sitio ao acaso
    is=randi(V,1);
    if ni(is) ==0
        ni(is)=1;
        n=n+1;
        lista(n)=is;
    end  
end
for t=1:npassos
    for act=1:V
        % escolher ao acaso adicionar ou remover
        u=rand();
        if u<=0.5
            % adicionar
            % escolher sitio ao acaso
            is=randi(V,1);
            if ni(is)==0
                pA=min([1, (V/(N+1))*exp(bmu)]);
                if rand() <=pA
                    ni(is)=1;
                    N=N+1;
                    lista(N)=is;
                end
            end
        else
            %remover
            ip=randi(N,1); %escolher particula
            pA=min([1,(N/V)*exp(-bmu)]);
            if rand()<=pA
                is=lista(ip); % sitio onde estava a particula a remover
                ni(is)=0;
                lista(ip)=lista(N); % atualiza a lista
                N=N-1;
                
            end
        end
        
    end
    if t> nequi
        % fazemos medidas
        Nt(t-nequi)=N;
    end
    
end


end