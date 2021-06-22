
close all
clear all
clc

c = 2; N=1000; npassos = 10000;  nequi = 1000;
T = 1.5:0.1:2.5;
ic = 1;

%[listv,nv,lista_sitios] = rg(N,c);
% for T1 = T
%     fprintf(1,'Simulacao T=%f\n',T1)
%     
%    [mag(ic),susc(ic),e(ic),cv(ic)] = ex3a(N,npassos,nequi,T1,listv);
%    ic = ic +1;
%    
% end
load dadosN1000


figure(1)
plot(T,mag,'b.');xlabel('T');ylabel('M/N');
figure(2)
plot(T,susc,'b.');xlabel('T');ylabel('susc/N');
figure(3)
plot(T,e,'b.');xlabel('T');ylabel('E/N');
figure(4)
plot(T,cv,'b.');xlabel('T');ylabel('Cv/N');

%save dadosN1000



