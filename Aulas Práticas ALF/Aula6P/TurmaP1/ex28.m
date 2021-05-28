clear all
close all
i=0; 

E0v=linspace(2*sqrt(2),100,10);

T=zeros(1,numel(E0v)); Emed=T;
fprintf(1, 'Aviso: O programa demora um pouco a executar\n')
for E0=E0v
    i=i+1;
    %[Emed(i),EDmed]=fex28b(E0); % alinea b)
    [Emed(i),EDmed, Ev, nE]=fex28c(E0); % alinea c)
    T(i)=EDmed-0.2; % Verifica-se um melhor acordo entre os resultados
    %obtidos do algoritmo e a expressao teorica usando T(i)=EDmed-0.2 
    %em lugar de T(i)=EDmed. Isto pode dever-se a que a energia
    % do Demon não toma de facto valores continuos como se assume
    % para obter T(i)=EDmed 
    
    fprintf('Temperatura da simulacao T=%f\n',T(i))
    
    % alinea c
    figure(2) % representação grafica do numero medio de fotoes com 
   % energia E em funcao da energia
    semilogy(Ev, nE,'k+')
    xlabel('E'); ylabel('nE')
    title(['T=' num2str(T(i))])
    drawnow
    
    
end
Tt=linspace(T(1),T(end),40);
EmedT=pi*Tt.^3*zeta(3);
figure(1)
plot(T, Emed,'bx', Tt, EmedT, 'r-')
xlabel('T'); ylabel('Emed')
