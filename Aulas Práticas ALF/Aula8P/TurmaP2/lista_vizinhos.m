function [listav, nv]=lista_vizinhos(nmax)
nv=zeros(nmax^2,1);
listav=zeros(nmax^2,4);
for ik=1:nmax^2
    nx=mod(ik-1, nmax)+1; ny=floor((ik-1)/nmax)+1;
    % vizinho 1
    nx1=nx+1;  ny1=ny;
    if nx1 <=nmax
    ikv=nx1+(ny1-1)*nmax;
    nv(ik)=nv(ik)+1;
    listav(ik,nv(ik))=ikv;
    end
    % vizinho 2
    nx2=nx;  ny2=ny+1;
    if ny2 <=nmax
    ikv=nx2+(ny2-1)*nmax;
    nv(ik)=nv(ik)+1;
    listav(ik,nv(ik))=ikv;
    end
    % vizinho 3
    nx3=nx-1;  ny3=ny;
    if nx3 >=1
    ikv=nx3+(ny3-1)*nmax;
    nv(ik)=nv(ik)+1;
    listav(ik,nv(ik))=ikv;
    end
    % vizinho 4
    nx4=nx;  ny4=ny-1;
    if ny4 >=1
    ikv=nx4+(ny4-1)*nmax;
    nv(ik)=nv(ik)+1;
    listav(ik,nv(ik))=ikv;
    end
    
end

end