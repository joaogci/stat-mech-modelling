clear all
close all
nequi=5000; nmedidas=20000; N=100; % 
i=0;
nTs=30;
Tv=linspace(3,300,nTs);
nmax=50;
Emedio=zeros(nTs,1); E2medio=zeros(nTs,1);
nkmedio=zeros(nmax,nmax,1);

for  T=Tv
    i=i+1;
  %calcula quantidades para cada temperatura
 [Emedio(i), E2medio(i), nkmedio]=metropolis(T,nequi,nmedidas,N,nmax);
 
 % calcula Cv usando a relaçao entre a capacidade termica e a variancia da energia
 Cv(i)=(E2medio(i)-Emedio(i)^2)/T^2; % Valor esperado para gas ideal classico a d=2 e' CV=N k_B
 Emedio(i)=Emedio(i)-2*N; % subtrai a energia do estado fundamental
 %calculo do valor medido de z
 zmedio(i)=nkmedio(1)/(1+nkmedio(1));
 
 %espressoes teoricas esperadas
 um_menos_z=exp(-4*N/Tv(i)/pi); 
 zteorv(i)=1-um_menos_z;
 Eteorv(i)=(pi/4)*Tv(i)*Tv(i)*dilog(um_menos_z);
 
 fprintf(1,'nmax=%d, T=%f,  <E>=%f , Eteor=%f z=%f,z_teor=%f\n',nmax,T, Emedio(i),Eteorv(i),zmedio(i),zteorv(i))
 figure(1)
 mesh(nkmedio) ;% representa
xlabel('kx') 
ylabel('ky')
zlabel('nk')
drawnow
end

% representaçao grafica dos resultados
figure(2)
plot(Tv,Eteorv,'k-',Tv,Emedio,'r.')
xlabel('T')
ylabel('<E>')  
figure(3)
plot(Tv,zteorv,'k-',Tv,zmedio,'r.')
axis([0,Tv(end),0,1])
xlabel('T')
ylabel('z')   

figure(4)
plot(Tv,Cv,'r.')

xlabel('T')
ylabel('Cv')  
        
        