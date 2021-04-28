%teste1 questao 2
clear all
close all
N=100;

ic=0;
for E0=[-N+N/10:N/10:-N+9*N/10]
 fprintf(1,'Calculos para E0=%f\n',E0);
 ic=ic+1;
 nequi=1000; npassos=4000;
[Emedio,EDmedio]=fteste1_2a(N,E0,nequi, npassos);

Ta(ic)=2/log((EDmedio+2)/EDmedio);
Ema(ic)=Emedio;
nequi=1000; npassos=4000;
[Emedio,EDmedio]=fteste1_2b(N,E0,nequi, npassos);

Tb(ic)=2/log((2+EDmedio)/EDmedio);

Emb(ic)=Emedio;

end

% alinea c
Tva=0.1: 0.01: max(Ta);
a=exp(-1./Tva);
n1a=(N./a)*1./(a+1./a);

EmaT=-N*tanh(1./Tva);

Tvb=0.1: 0.01: max(Tb);
b=exp(2./Tvb);

EmbT=-N+2./(b-1);

h3=figure(3);
set(h3, 'Units','normalized', 'Position',[2/3,1/3, 1/4,1/3])

plot(Ta,Ema,'kx', Tva, EmaT,'k-')
text(0.5,1/3,'particulas discerniveis','Units','normalized')
xlabel('T'); ylabel('E media')
h4=figure(4);
set(h4, 'Units','normalized', 'Position',[1/3,1/3, 1/4,1/3])
plot(Tb,Emb,'r+',Tvb, EmbT,'r-') 
text(0.5,1/3,'particulas indiscerniveis','Units','normalized')
xlabel('T'); ylabel('E media')


