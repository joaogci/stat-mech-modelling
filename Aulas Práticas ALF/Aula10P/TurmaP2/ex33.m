%ex33.m
clear all
close all
npassos=18000;
nequi=2000; nmedidas=npassos-nequi;
N=200; nmax=50;
Tc=0.671253*N^(2/3);


Ts=linspace(Tc/10,2*Tc,10);
% calculo de um vetor com as energias dos estados
ik=1:nmax^3;
nz=floor((ik-1)/nmax^2)+1;
ny=floor(mod(ik-1,nmax^2)/nmax)+1;
nx=mod(mod(ik-1,nmax^2), nmax)+1;
energias(ik)=nx.^2+ny.^2+nz.^2;


i=0;

for T=Ts
    fprintf(1,'Simulacao a T/Tc=%f\n',T/Tc);
    i=i+1;
    [Emedio(i),E2medio(i), nkmedio] = metropolis(T ,nequi, nmedidas,N, nmax);
     cv(i)=(E2medio(i)-Emedio(i)^2)/T^2;
     z(i)=nkmedio(1)/(nkmedio(1)+1); % calculo da fugacidade
     %considerando o zero de energia igual à energia do estado 
     %fundamental
    
     f0(i)=nkmedio(1)/N;
      % visualizacao de nkmedio em funcao da energia
     figure(1)
     semilogy(energias (energias<1000), nkmedio(energias<1000),'r.');
     xlabel('E'); ylabel('nkmedio')
     drawnow
end

  T=linspace(Tc/10,2.5*Tc,200);
  figure(4)
  zt1=ones(1,length(T));
  zt2=2.612*(Tc./T).^(3/2);
  plot(Ts/Tc,z,'kx',T/Tc,zt1,'r-', T/Tc, zt2,'r-')
  axis([0, T(end)/Tc, 0, 1.2])
  xlabel('T/Tc'); ylabel('z')
  legend(['N=' num2str(N)],'Location','Southeast')
  
  figure(2)
  Emt1=N*Tc*0.7701*(T/Tc).^(5/2);
  Emt2=(3/2)*N*T;
  
  plot(Ts/Tc,(Emedio-3*N)/N/Tc,'kx', T/Tc,Emt1/Tc/N,'r-', T/Tc, Emt2/Tc/N,'r-')
  axis([0,T(end)/Tc,0,3/2*T(end)/Tc]);
  xlabel('T/Tc'); ylabel('<E>/(N* Tc)')
  legend(['N=' num2str(N)],'Location','Southeast')
  
  figure(3)
  Cvt1=N*1.925*(T/Tc).^(3/2);
  Cvt2=3/2*N*ones(1,length(T)); 
  plot(Ts/Tc,cv/N,'kx', T/Tc,Cvt1/N,'r-',T/Tc,Cvt2/N,'r-')
  axis([0, T(end)/Tc, 0, 2]);
  xlabel('T/Tc'); ylabel('Cv/N')
  legend(['N=' num2str(N)],'Location','Southeast')
  
  figure(5)
  f0t=1-(T(T<=Tc)/Tc).^(3/2);
  f0t=[f0t, 0*T(T>Tc)];
  plot(Ts/Tc,f0,'kx',T/Tc,f0t,'r-')
  xlabel('T/Tc'); ylabel('f0')
  legend(['N=' num2str(N)],'Location','Southeast')
  
  
  
