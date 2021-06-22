clear all
close all
nmax=10; Tmax=1;
nequi=10000; nmedidas=10000;
Tt=linspace(0,Tmax,100);
Et=(pi^5/15)*Tt.^4;

it=0;
Tv=linspace(0.1,Tmax,10);
for T=Tv
    it=it+1;
    fprintf(1, 'Simulacao %d a T=%f \n', it,T);
  [Emedio(it)] = ex2a(T ,nequi, nmedidas, nmax);
  plot(  Tv(1:it),Emedio(1:it),'k.', Tt, Et, 'r-')
  xlabel('T')
  ylabel ('<E>')
  drawnow
end
