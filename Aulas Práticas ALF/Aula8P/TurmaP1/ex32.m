clear all
close all

nequi=5000; nmedidas=20000;
nmax=50;
N=100;
Ts=linspace(3,300,30);
i=0;
for T=Ts
    i=i+1;
    [Emedio(i),E2medio(i), nkmed] = metropolis(T ,nequi, nmedidas,N, nmax);
    Cv(i)=(E2medio(i)-Emedio(i)^2)/ T^2; % calculo da capacidade termica
    Emedio(i)=Emedio(i)-2*N; % para comparar com as expressoes teoricas
    
    fprintf(1,'Simulacao=%d, T=%f\n',i,T);
    figure(1)
    mesh(reshape(nkmed,nmax,nmax));
    xlabel('nx'); ylabel('ny');zlabel('<nk>');
    drawnow
    figure(2)
    plot(Ts(1:i),Emedio(1:i),'kx')
    xlabel('T'); ylabel('<E>')
    figure(3)
    plot(Ts(1:i),Cv(1:i),'kx')
    xlabel('T'); ylabel('Cv')
    
    
end