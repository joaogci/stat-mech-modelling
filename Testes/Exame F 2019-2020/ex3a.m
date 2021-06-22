function [mag,susc,e,cv] = ex3a(N,npassos,nequi,T,listav)
    s = 2*(randi(2,1,N)-1)-1;
    E = 0;
    M = 0;
    nv=zeros(N,1); %ALF
    for i=1:N
        k = find(listav(i,:));
        for j = 1:length(listav(i,:))
            if listav(i,j)~=0
                E = E-1/2*s(i)*s(listav(i,j));
                nv(i)=nv(i)+1; 
            end
        end
        M = M + s(i);
    end
    
    e = 0;cv = 0; mag = 0; susc = 0;
    for t = 1:npassos
        for act = 1:N
            i = randi(N,1);
            sl = -s(i);
            dM = sl - s(i);
        
            hi=0;
            for j = 1:nv(i)
                hi=hi+s(listav(i,j));
            end
            dE = (-sl+s(i))*hi;
            if rand(1)<min([1,exp(-dE/T)])
                s(i) = sl;
                E = E+dE; M = M+dM;
            end
        end
        if t>nequi
            e = e+E;cv = cv + E^2; mag = mag +abs(M); susc = susc + M^2; 
        end
    end

    e=e/(npassos-nequi);  cv=cv/(npassos-nequi); mag=mag/(npassos-nequi);susc=susc/(npassos-nequi);
    cv=cv-e*e; susc=susc-mag*mag;

    e = e/N; cv = cv/N; mag = mag/N; susc = susc/N;
        
            
end

