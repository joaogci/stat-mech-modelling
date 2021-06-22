clear all
close all

N=200;
it=0;
TF=N^(2/3)*(3/(4*pi))^(2/3);
tmax=10000;
nmin=30; nestados=(2*nmin+1)^3;
fprintf('Numero de particulas=%d\n',N)

fprintf('Numero de estados considerado=%d\n',nestados)

fprintf('Numero de passos de simulacao=%d\n',tmax)
fprintf('Temperatura de Fermi, TF=%f\n',TF)
Tmax=2*TF;
for T=TF/20:Tmax/40:Tmax
    it=it+1;
    Tv(it)=T;
       
    [energia,np_med,emed2(it),nestados]=GasFermiDiracv1(N,T,tmax,nmin);
    
     figure(2)
     semilogy(energia,np_med,'r.')
     xlabel('Energia')
     ylabel('<n>')
     set(gcf,'Position',[1,320, 300, 200]);
     
 i=find(energia==0);
 
 f0(it)=np_med(i)/N;
 emed(it)=sum(energia.*np_med)/N; %energia media por particula
 emed2(it)=emed2(it)/N^2;
 cv(it)=N*(emed2(it)-emed(it)^2)/Tv(it)^2;
 mu(it)=T*log(f0(it)/(-f0(it)+1/N));
 fprintf('T=%f, mu(T)=%f\n',T,mu(it))
 Tt=[0.05:0.05:TF];
%  figure(3)
  
%  f0t=1-(Tt/Tc).^(3/2);
% plot(Tv(1:it)/TF,f0(1:it),'r.',Tt/TF,f0t,'k-')
% axis([0, Tmax/Tc, 0 1])
% xlabel('T/Tc')
% ylabel('<n(0)>/N')
% set(gcf,'Position',[310,320, 300, 200]);
% drawnow
figure(4)
%energia por particula
eteor=(3/5)*(1+(5*pi^2)/12*(Tt/TF).^2)*N^(2/3)*(3/(4*pi))^(2/3); % T<<TF
Tt2= [1.5*TF:0.1:1.1*Tmax];
egasideal=(3/2)*Tt2;
plot(Tv(1:it),emed(1:it),'r.',Tt,eteor,'k-',Tt2,egasideal,'k-')
xlabel('T')
ylabel('<E>/N')
set(gcf,'Position',[620,320, 300, 200]);
figure(5)
cvteor=(pi^2/2)*(Tt/TF); % T<<TF
cvgasideal=3/2*ones(1,length(Tt2));

plot(Tv(1:it),cv(1:it),'r.',Tt,cvteor,'-k',Tt2,cvgasideal,'-k')
xlabel('T')
ylabel('CV/N')
set(gcf,'Position',[930,320, 300, 200]);
drawnow

figure(6)
muteor=TF*(1-(pi^2/12)*(Tt/TF).^2); % T<<TF
%Tt2= [2*TF:0.1:4*TF];
mugasideal=Tt2.*log((4/(3*pi^(1/2)))*(TF./Tt2).^(3/2));


plot(Tv(1:it),mu(1:it),'r.',Tt,muteor,'-k',Tt2,mugasideal,'-k')
xlabel('T')
ylabel('mu')
set(gcf,'Position',[310,20, 300, 200]);
drawnow

end
     





     
        
    



