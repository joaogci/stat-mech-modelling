close all
clear all
clc

p = 1/3;
M = 1000;
n = 20;
P01=zeros(n,1);P10=zeros(n,1);P00=zeros(n,1);P11=zeros(n,1);
for i=1:n
 for j=1:M
     na=rand(1);
     if na<1/2
            s0 = 0;
     else
            s0 = 1;
     end
     sn = ex2a(i,p,s0);
        
     if s0==0 && sn==0
            P00(i) = P00(i) + 1;
        elseif s0==0 && sn==1
            P01(i) = P01(i) + 1;
        elseif s0==1 && sn==0
            P10(i) = P10(i) + 1;
        else
            P11(i) = P11(i) + 1;
      end
    end
    P00(i) = P00(i)/M;
    P01(i) = P01(i)/M;
    P10(i) = P10(i)/M;
    P11(i) = P11(i)/M;
end

figure(1)

i=1:n;
semilogy(i,P00,'r-',i,P11,'g-', i,P10,'b-',i,P01,'k-')
hold on
xlabel('n'); ylabel('P(s0,sn)')
legend('P00 ','P11 ','P10 ','P01 ','Location','SouthEast')
 %p=1/3   
 %P00(1)=P11(1) deve ser     1/2 (1-p) = 1/3   
  %P01(1)=P10(1) deve ser     1/2p = 1/6   
  
 % Para n grande P00(n)=P10(n)=P11(n)=P00(n)=1/4
        
        
        
        