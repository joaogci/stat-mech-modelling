clear all
close all

N=20;
tmax=5000;
tv=0:tmax;
ic=0;
Tv=0.1:0.01:1.0;
EGIteorico=3*N*Tv/2;
ESEteorico=3*N*Tv;
E0v=N/2:8:9*N/2;

for E0=E0v
 ic=ic+1;   
% Valor de T esperado para GIdeal om energia E0
T=2*E0/(3*N);
fprintf('N=%d, E0=%f,TGI=%f, TSE=%f\n',N,E0,T,0);

 [Edt,EGIt,ESEt] = Exercicio2Funcao(N,E0, tmax);

Edmed(ic)=mean(Edt(0.1*tmax:tmax+1));
EGImed(ic)=mean(EGIt(0.1*tmax:tmax+1));
ESEmed(ic)=mean(ESEt(0.1*tmax:tmax+1));
fprintf('Td=%f,EGI=%f, ESE=%f\n',Edmed(ic),EGImed(ic),ESEmed(ic));
fprintf('\n')

figure(1)
plot(tv,Edt,'r-',tv(0.1*tmax:tmax+1), ones(tmax+1-0.1*tmax+1,1)*Edmed(ic),'k-')

xlabel ('t'); ylabel('Ed(t)')
set(gcf,'Position',[10,400, 300, 200]);
figure(2)
plot(tv,EGIt,'g-',tv(0.1*tmax:tmax+1), ones(tmax+1-0.1*tmax+1,1)*EGImed(ic),'k-')

xlabel ('t'); ylabel(' EGI(t)')
set(gcf,'Position',[320,400, 300, 200]);

figure(3)
plot(tv,ESEt,'b-',tv(0.1*tmax:tmax+1), ones(tmax+1-0.1*tmax+1,1)*ESEmed(ic),'k-')

xlabel ('t'); ylabel('ESE(t)')
set(gcf,'Position',[640,400, 300, 200]);

figure(4)

plot(Edmed,EGImed,'r.', Tv, EGIteorico,'k-',Edmed,ESEmed,'b.',Tv, ESEteorico,'k-')

xlabel('T'); ylabel('<EGI>, <ESE>')
set(gcf,'Position',[950,400, 300, 200]);
drawnow

 figure(5)
 plot(E0v(1:ic),Edmed(1:ic),'r.',E0v,2*E0v/(9*N),'k-')

xlabel('E0'); ylabel('T')
set(gcf,'Position',[10,100, 300, 200]);
drawnow
    
    end



        
         
    