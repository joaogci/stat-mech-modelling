function [Edt,EGIt,ESEt] = Exercicio2Funcao(N,E0, tmax)

% N-Numero de particulas de cada sistema
% E0=Energia Inicial do Gas Ideal uE ; 

% inicializacao dos sistemas 
v0=sqrt(2*E0/N); % em unidades de uV
vGI=zeros(N,3);
vSE=zeros(N,3); rSE=zeros(N,3);
vGI(:,1)=v0;
dv=v0/10;
dr=dv;

Ed=0;

Edt=zeros(tmax,1);
EGIt=zeros(tmax,1); ESEt=zeros(tmax,1);

EGIt(1)=0.5*(sum(sum(vGI.^2)));
ESEt(1)=0.5*(sum(sum(vSE.^2))+sum(sum(rSE.^2)));


% t=0
t=0;
EGI=EGIt(1); ESE=ESEt(1);

for t=1:tmax
    for ip=1:N
    iGI=randi(N);
    dvGI=0.5*dv*(2*rand(1,3)-1);
    dEGI=dot(vGI(iGI,:),dvGI)+0.5*dot(dvGI,dvGI);
    
    
    if (dEGI <=0 || Ed-dEGI >0)
        Ed=Ed-dEGI;
        vGI(iGI,:)=vGI(iGI,:)+dvGI; 
        EGI=EGI+dEGI;
     end
   
    
    iSE=randi(N);
    dvSE=0.5*dv*(2*rand(1,3)-1);
    drSE=0.5*dr*(2*rand(1,3)-1);
    dESE=dot(vSE(iSE,:),dvSE)+0.5*dot(dvSE,dvSE);
    dESE=dESE+dot(rSE(iSE,:),drSE)+0.5*dot(drSE,drSE);
    
       
    if (dESE <=0 || Ed-dESE >0)
        Ed=Ed-dESE;
        vSE(iSE,:)=vSE(iSE,:)+dvSE; 
        rSE(iSE,:)=rSE(iSE,:)+drSE; 
        ESE=ESE+dESE;
    end
    
    Edt(t+1)=Ed; 
    EGIt(t+1)=EGI; ESEt(t+1)=ESE;
                    
    end
          
 end



         
    