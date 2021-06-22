clear all
close all
N=10000;tmax=10; f=0.01;
N1t=zeros(tmax+1,1); N2t=N1t; N3t=N2t;
tempo=zeros(tmax+1,1);
N1=N-floor(f*N); N2=floor(f*N); N3=0;
N1t(1)=N1; N2t(1)=N2; N3t(1)=N3;
s=ones(N,1); s(1:N2)=2;

alfa=0.2; %contactos por dia vezes probabilidade de infeção num contacto 
beta=1/15; % probabilidade de recuperação por dia
dt=1/(N*beta);
R0=alfa*N1/(N*beta);
fprintf(1,'R0=%f\n',R0)
for t=1:tmax
    for act=1:N
        
        %escolher uma particula
        i=randi(N,1);
        if (s(i) ==2)
            s(i)=3;
            N2=N2-1; N3=N3+1; 
        elseif s(i)==1
            u=rand(1);
            %N2//N representa a fração dos contactos infeciosos
            if u<= (alfa/N)*N2/beta
                s(i)=2;
                N1=N1-1; N2=N2+1;
            end
        end
         
             
    end
    N1t(t+1)=N1; N2t(t+1)=N2; N3t(t+1)=N3;
    tempo(t+1)=tempo(t)+N*dt;
end

plot(tempo, N1t/N, 'kx', tempo, N2t/N,'rx', tempo, N3t/N,'bx')
hold on
xlabel('t'); ylabel('xi')

% integração equações diferenciais
tspan=[0, 150]; x0=[N1t(1),N2t(1),N3t(1)]/N;
[t,x] = ode45(@(t,x) F(t,x,alfa,beta), tspan, x0);
plot(t,x(:,1),'k-', t,x(:,2),'r-', t,x(:,3),'b-')

function Fv=F(t,x,alfa, beta)
Fv(1,1)=-alfa*x(1)*x(2);
Fv(2,1)=alfa*x(1)*x(2)-beta*x(2);
Fv(3,1)=beta*x(2);
end


