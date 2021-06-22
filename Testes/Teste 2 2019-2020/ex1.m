function ex1()
clear all
close all


npassos=1000000; nequi=10000;
it=0;
Tv=[0.01:0.05:2];
for T=Tv
    it=it+1;
[h,xh,xt,Et]=mc(npassos,nequi,T);
Em(it)=mean(Et);
x=linspace(xh(1),xh(end),numel(xh)*10);
Pst=exp(-energia(x)/T); Pst=Pst/(sum(Pst)*(x(2)-x(1)));
figure(1)
plot(xh,h,'k.',x,Pst,'r-'); 
xlabel('x'); ylabel('p(x)')
figure(2)
plot(Tv(1:it),Em(1:it),'k.')
xlabel('T'); ylabel('Em')

drawnow
end
end

function [h,xh,xt,Et]=mc(npassos,nequi,T)
x=-1; dx=0.5;E=energia(x);
nm=0; nac=0;
for t=1:npassos
    xn=x+ dx*(rand(1)-0.5); En=energia(xn);
    dE=En-E;
    if rand(1) < min(1,exp(-dE/T))
        x=xn;
        E=En;
        nac=nac+1;
    end
  
    if t> nequi
        nm=nm+1;
        xt(nm)=x; Et(nm)=E;
            
    end
     if t==nequi
       nac=0;
   end
end
fprintf(1,'T=%f, delta=%f, Probabilidade Aceitar=%f\n', T,dx,  nac/nm)
xh=-2:0.05:2;
[h]=hist(xt,xh); h=h/(sum(h)*(xh(2)-xh(1)));
end
    


function [V]=energia(x)
b=-1; a=0.2; c=2;
V=a*x+b*x.^2 + c*x.^4;
end