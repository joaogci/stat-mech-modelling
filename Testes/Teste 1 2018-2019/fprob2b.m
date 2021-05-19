function [Emedio,Edmedio,nmax]=fprob2b(E0,nequi,nmedidas)


nmax=min([ceil(sqrt(E0*E0-1)),50]);

Ed=E0;
nk=zeros(nmax,nmax);

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
       
    end
end
Edmedio=Edmedio/nmedidas;
Emedio=Emedio/nmedidas;


figure(1)
plot(1:npassos,Edt,'k.')
xlabel('t')
ylabel('<Ed>')

            
           
        
        