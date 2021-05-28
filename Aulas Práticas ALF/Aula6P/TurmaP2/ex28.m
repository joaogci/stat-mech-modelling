clear all
close all
E0v=10*sqrt(2):10*sqrt(2):80*sqrt(2);
Emed=zeros(1,numel(E0v));
T=zeros(1,numel(E0v));

i=0;
for E0=E0v
    i=i+1;
    %[Emed(i), EDmed]=fex28b(E0);
    [Emed(i), EDmed, Ev,nE]=fex28c(E0);
    T(i)=EDmed;
    fprintf(1,'Temperatura da simulacao=%f\n',T(i))
    figure(2)
    semilogy( Ev, nE, 'x')
    xlabel('E'); ylabel('nE')
    
end

Tt=linspace(0,max(T),100);
Emedt=pi*Tt.^3*zeta(3);

figure(1)
plot(T,Emed,'x',Tt,Emedt,'r-')
xlabel('T'); ylabel('E media')

    

