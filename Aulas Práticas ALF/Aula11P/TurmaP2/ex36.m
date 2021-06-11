%ex36.m
V=100;
N=10;
npassos=5e4; nequi=1e3;
nmedidas=npassos-nequi;

bmu=1;
Nt=metropolisGC(npassos, nequi, N, V, bmu);
Nmed=sum(Nt)/nmedidas;
rhom=Nmed/V;
fprintf(1,'beta mu=%f, <N>=%f, rho=%f \n', bmu,Nmed,rhom);
