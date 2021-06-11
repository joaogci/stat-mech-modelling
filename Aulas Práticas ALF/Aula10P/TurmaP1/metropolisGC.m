function [Nt]=metropolisGC(N, V, bmu,npassos, nequi)
nmedidas=npassos-nequi;
Nt=zeros(nmedidas,1);

ni=zeros(V,1); % variavel que regista se existe particula num dado sitio
%da rede
% colocacao inicial das particulas na rede  escolhendo N sitios
% ao acaso
particula_sitio=zeros(V,1);
n=0;
while n< N
    is=randi(V,1);
    if ni(is)==0
        ni(is)=1;
        n=n+1;
        particula_sitio(n)=is;
    end
end

for t=1:npassos
    for act=1:V 
        u1=rand();
        if u1 <= 0.5
            % adicionamos
            % escolher um sitio ao acaso
            is=randi(V,1);
            if ni(is)==0
                pA=min([1,V/(N+1) * exp(bmu) ]);
                if rand() <= pA
                    N=N+1;
                    ni(is)=1;
                    particula_sitio(N)=is;
                end
            end
        else
            %removemos
            if N>=1
            ip=randi(N,1); % escolhemos uma das N particulas
            pA=min([1, N/V * exp(-bmu)]);
            if rand() <= pA
                is=particula_sitio(ip);
                ni(is)=0;
                particula_sitio(ip)=particula_sitio(N);
                N=N-1;
                
            end    
            end
    end
   
    end
    if t> nequi
       Nt(t-nequi)=N;
    end
   end
end

