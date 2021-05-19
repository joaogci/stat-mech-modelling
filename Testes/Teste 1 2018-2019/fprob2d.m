function [Emedio,Edmedio,ne,E]=fprob2d(E0,nequi,nmedidas)


nmax=min([ceil(sqrt(E0*E0-1)),50]);

Ed=E0;
nk=zeros(nmax,nmax);


E=sqrt(2):sqrt(2):sqrt(nmax*nmax+1);
ne=zeros(length(E),1);
iE=zeros(nmax,nmax);
for nx=1:nmax
    for ny=1:nmax
       
        iE(nx,ny)=floor((sqrt(nx*nx+ny*ny)-E(1))/(E(2)-E(1)))+1;
    end
end
        
npassos=nmedidas+nequi;
Edmedio=0; Emedio=0; 
Edt=zeros(npassos,1);
for t=1:npassos

    for k=1:nmax*nmax
        ux=rand(1); uy=rand(1);
        nx=floor(ux*nmax)+1;
        ny=floor(uy*nmax)+1;
        
        p=floor(2*rand(1));
        if p==1
            dE=sqrt(nx*nx+ny*ny);
            if (dE<=Ed)
                Ed=Ed-dE;
                nk(nx,ny)=nk(nx,ny)+1;
            end
        else
            if (nk(nx,ny)>=1) 
                dE=-sqrt(nx*nx+ny*ny);
                Ed=Ed-dE;
                nk(nx,ny)=nk(nx,ny)-1;
            end
        end
    end
    Edt(t)=Ed;
    if t>nequi
        Edmedio=Edmedio+Ed;
        Emedio=Emedio+E0-Ed;
        for nx=1:nmax
            for ny=1:nmax
                 if(iE(nx,ny)<=length(E))
                    ne(iE(nx,ny))=ne(iE(nx,ny))+nk(nx,ny);
                 end
            end
        end
    end
end
Edmedio=Edmedio/nmedidas;
Emedio=Emedio/nmedidas;
ne=ne/nmedidas;

figure(1)
plot(1:npassos,Edt,'k.')
xlabel('t')
ylabel('<Ed>')

            
           
        
        