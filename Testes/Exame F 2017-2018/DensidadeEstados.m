function [nestados,energias,lviz,nviz]=DensidadeEstados(nmin)

im=2*nmin+1;
nxv=-nmin:nmin; 
nestados=im^3;
energias=zeros(nestados,1); %energia de cada estado
lviz=zeros(nestados,6);
nviz=zeros(nestados,1);
estado=0;
for nz=nxv
    for ny=nxv
        for nx=nxv;
            estado=estado+1;
            %estadov=(nx+nmin+1)+im*(ny+nmin)+im^2*(nz+nmin);
            
            energias(estado)=2*pi*sqrt(nx^2+ny^2+nz^2);
                iv=0;
                for ic=1:3
                for dn=-1:2:1
                    nv=[nx,ny,nz];
                    nv(ic)=nv(ic)+dn;
                    if(nv(ic) <=nmin && nv(ic)>=-nmin)
                    iv=iv+1;
                    estadov=nv(1)+nmin+1+im*(nv(2)+nmin)+im^2*(nv(3)+nmin);
                    lviz(estado,iv)=estadov;
                    end
                end
                end
                nviz(estado)=iv;
                
                
        end
    end
end
figure(1)
energia=unique(energias);
g=zeros(length(energia),1);

for i=1:length(energia)  
    g(i)=sum(energias==energia(i));
end

x=0:energia(end)/200:energia(end);
dE=(energia(2)-energia(1))/2;
gteor=x.^2/(2*pi^2);
[hg,ee]=hist(energias,0:dE:energia(end));
plot(ee,hg,'r-', x,gteor*dE,'k-') % ,energia,g,'r-')
xlabel('E')
ylabel('g(E) dE')
set(gcf,'Position',[1,20, 300, 200]);

end

