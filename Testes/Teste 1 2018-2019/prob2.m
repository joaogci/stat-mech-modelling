clear all
close all
nequi=2000; nmedidas=20000;
i=0;Tv=[0:0.1:3];
delta=0.2;

% alinea 2. c)
for E0=sqrt(2):10*sqrt(2):80*sqrt(2);
    i=i+1;
 [Emedio(i),Edmedio, nmax]=fprob2b(E0,nequi,nmedidas);
 T(i)=Edmedio-delta;
 Eteor=pi*T(i).*T(i).*T(i)*1.20206;

 fprintf(1,'E0=%f ,nmax=%d, T=%f,  <E>=%f , Eteor=%f\n',E0,nmax,T(i), Emedio(i),Eteor)
 
end

Eteor=pi*Tv.*Tv.*Tv*1.20206;
figure(2)
plot(Tv,Eteor,'k-',T,Emedio,'r.')
xlabel('T')
ylabel('<E>')

%alinea d)

for E0=linspace(20*sqrt(2),80*sqrt(2),3);
   
[Emedio,Edmedio,ne,E]=fprob2d(E0,nequi,nmedidas);
figure(3)
T=Edmedio-0.2;
neteor=((pi/2)*E./(exp(E/T)-1))*(E(2)-E(1));
semilogy(E,ne,'.', E,neteor,'k-')
xlabel('E'); ylabel('N(E,dE)')
hold on
drawnow 
end


            
           
        
        