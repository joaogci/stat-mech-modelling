function [nE]=planck(npmed,energias, E)

dE=(E(2)-E(1));
np=length(E);
nE=zeros(np,1);
for ip=2:np 
    i=find(energias>E(ip-1)& energias <= E(ip));
    if ( ~isempty(i))
    nE(ip)=sum(npmed(i))/dE;      
    end
end
end
