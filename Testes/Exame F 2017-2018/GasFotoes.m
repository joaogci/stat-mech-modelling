clear all
close all


it=0;

tmax=1000;
nmin=5; nestados=(2*nmin+1)^3;


fprintf('Numero de estados considerado=%d\n',nestados)

fprintf('Numero de passos de simulacao=%d\n',tmax)


Tmax=5;
for T=2:Tmax/50:Tmax
    it=it+1;
    Tv(it)=T;
       
    [energia,np_med,emed2(it),nestados]=GasFotoesv1(T,tmax,nmin);
    
     figure(2)
     semilogy(energia,np_med,'r.')
     xlabel('Energia')
     ylabel('<n>')
     set(gcf,'Position',[1,320, 300, 200]);
    
   N(it)=sum(np_med(:));
 
 emed(it)=sum(energia.*np_med); %energia media
 emed2(it)=emed2(it);
 cv(it)=(emed2(it)-emed(it)^2)/Tv(it)^2;
 
 fprintf('T=%f\n',T)
 Tt=[0.05:0.05:Tmax];

figure(3)
%energia 
eteor=pi^2/30*Tt.^4; 


plot(Tv(1:it),emed(1:it),'r.',Tt,eteor,'k-')
xlabel('T')
ylabel('<E>')
set(gcf,'Position',[620,320, 300, 200]);

figure(4)
cvteor=4*pi^2/30*Tt.^3;


plot(Tv(1:it),cv(1:it),'r.',Tt,cvteor,'-k')
xlabel('T')
ylabel('CV')
set(gcf,'Position',[930,320, 300, 200]);
drawnow

figure(5)
Nteor=2*(1.2020569)/(2*pi^2)*Tt.^3;

plot(Tv(1:it),N(1:it),'r.',Tt,Nteor,'-k')
xlabel('T')
ylabel('N')
set(gcf,'Position',[310,20, 300, 200]);

figure(6)
dE=3;
ener=0:dE:max(energia);

[dist]=planck(np_med,energia,ener);

e=0.01:0.1:max(energia);

     dist_teor=e.^2./((exp(e/T)-1)*(2*pi^2));
     plot(ener,dist,'r.', e,dist_teor,'k-')
     xlabel('Energia')
     ylabel('n(E)')
     set(gcf,'Position',[320,320, 300, 200]);


drawnow



end
     





     
        
    



