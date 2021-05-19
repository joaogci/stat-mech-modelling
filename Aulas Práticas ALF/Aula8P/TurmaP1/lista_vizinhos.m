function [listav, nv]=lista_vizinhos(nmax)
listav=zeros(nmax^2,4); % guarda o indice dos vizinhos de cada estado
nv=zeros(nmax^2, 1); % bguarda o numero de vizinhos de cada estado
for i=1: nmax^2
    nx=mod(i-1,nmax)+1; ny=floor((i-1)/nmax)+1;
    nx1=nx+1; ny1=ny; %vizinho1
    if nx1 <= nmax
        nv(i)=nv(i)+1;
        iv=nx1+nmax*(ny1-1);
        listav(i,nv(i))=iv;
    end
    nx2=nx; ny2=ny+1; %vizinho2
    if ny2 <= nmax
        nv(i)=nv(i)+1;
        iv=nx2+nmax*(ny2-1);
        listav(i,nv(i))=iv;
    end
    nx3=nx-1; ny3=ny; %vizinho3
    if nx3 >=1
        nv(i)=nv(i)+1;
        iv=nx3+nmax*(ny3-1);
        listav(i,nv(i))=iv;
    end
    nx4=nx; ny4=ny-1; %vizinho4
    if ny4 >=1
        nv(i)=nv(i)+1;
        iv=nx4+nmax*(ny4-1);
        listav(i,nv(i))=iv;
    end
    
end

end