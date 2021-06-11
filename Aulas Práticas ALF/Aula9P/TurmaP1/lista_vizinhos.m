function [listav, nv]=lista_vizinhos(nmax)
nv=zeros(nmax^3,1);
listav=zeros(nmax^3,6);
for ik=1:nmax^3
    nz=floor((ik-1)/nmax^2)+1;
    ny=floor(mod(ik-1,nmax^2)/nmax)+1;
    nx=mod(mod(ik-1,nmax^2), nmax)+1;
    % vizinho 1
    nx1=nx+1;  ny1=ny; nz1=nz;
    if nx1 <=nmax
    ikv=nx1+(ny1-1)*nmax+(nz1-1)*nmax^2;
    nv(ik)=nv(ik)+1;
    listav(ik,nv(ik))=ikv;
    end
    % vizinho 2
    nx2=nx;  ny2=ny+1;nz2=nz;
    if ny2 <=nmax
    ikv=nx2+(ny2-1)*nmax+(nz2-1)*nmax^2;
    nv(ik)=nv(ik)+1;
    listav(ik,nv(ik))=ikv;
    end
    % vizinho 3
    nx3=nx-1;  ny3=ny; nz3=nz;
    if nx3 >=1
    ikv=nx3+(ny3-1)*nmax+(nz3-1)*nmax^2;
    nv(ik)=nv(ik)+1;
    listav(ik,nv(ik))=ikv;
    end
    % vizinho 4
    nx4=nx;  ny4=ny-1; nz4=nz;
    if ny4 >=1
    ikv=nx4+(ny4-1)*nmax+(nz4-1)*nmax^2;
    nv(ik)=nv(ik)+1;
    listav(ik,nv(ik))=ikv;
    end
    % vizinho 5
    nx5=nx;  ny5=ny; nz5=nz-1;
    if nz5>=1
    ikv=nx5+(ny5-1)*nmax+(nz5-1)*nmax^2;
    nv(ik)=nv(ik)+1;
    listav(ik,nv(ik))=ikv;
    end
    % vizinho 6
    nx6=nx;  ny6=ny; nz6=nz+1;
    if nz6<=nmax
    ikv=nx6+(ny6-1)*nmax+(nz6-1)*nmax^2;
    nv(ik)=nv(ik)+1;
    listav(ik,nv(ik))=ikv;
    end
    
end

end