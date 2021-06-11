close all
clear all
N=10;
L=10; V=L^2;
npassos=5e4; nequi=1e3;
nmedidas=npassos-nequi;
i=0;
bmuv=[-5,-1.5:0.50:-0.5,0,0.5:0.5:1.5,5,];
for bmu=bmuv
i=i+1;    
    [Nt]=metropolisGC(N, V, bmu,npassos, nequi);

Nmed(i)=sum(Nt)/nmedidas;

fprintf(1,'beta mu=%f , <N>=%f \n',bmu, Nmed(i));

rhot=Nt/V;
nbins=20; rhomax=max(rhot); rhomin=min(rhot);
drho=(rhomax-rhomin)/nbins;
bins=rhomin+drho/2: drho: rhomax-drho/2;
[h]=hist(rhot,bins);
h=h/sum(h)/drho;

figure(1)
x=rhomin:0.01:rhomax;
xm=exp(bmu)/(exp(bmu)+1);
sigmaN=sqrt(V*exp(bmu)/(exp(bmu)+1)^2);

prhot=exp(-V^2* (x-xm).^2/(2* sigmaN^2))* ...
    (V/sqrt(2*pi*sigmaN^2));


plot(bins,h,'x', x,prhot,'r-')

xlabel('rho'); ylabel('p(rho)')

figure(2)
x=bmuv(1):0.01:bmuv(end);
Nmedt=V* exp(x)./(1+exp(x));
plot(bmuv(1:i), Nmed,'kx', x, Nmedt,'r-')
xlabel('beta mu'); ylabel('<N>')
drawnow
pause(5)

end
