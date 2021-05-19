%ex32.m
clear all
close all
nequi=5000; nmedidas=20000;
N=100; nmax=50;
Ts=linspace(3,300,10);
i=0;
for T=Ts
    fprintf(1,'Simulacao a T=%f\n',T);
    i=i+1;
     [Emedio(i),E2medio(i), nkmedio] = metropolis(T ,nequi, nmedidas,N, nmax);
     cv(i)=(E2medio(i)-Emedio(i)^2)/T^2;
     z(i)=exp(0/T)*nkmedio(1)/(nkmedio(1)+1);
     % visualizacao de nkmedio
     figure(1)
     mesh(reshape(nkmedio,nmax,nmax));
     xlabel('nx'); ylabel('ny')
     drawnow
end
  figure(2)
  T=linspace(3,300,100);
  zt=1-exp(-4*N./(pi*T));
  Emt=(pi/4)*T.^2.*dilog(1-zt);
  plot(Ts,Emedio-2*N,'kx', T,Emt,'r-')
  xlabel('T'); ylabel('<E>')
  
  figure(3)
  plot(Ts,cv,'kx')
  xlabel('T'); ylabel('Cv')
  figure(4)
  plot(Ts,z,'kx',T,zt,'r-')
  xlabel('T'); ylabel('z')
