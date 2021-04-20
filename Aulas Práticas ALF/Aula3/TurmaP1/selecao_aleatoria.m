function [i]=selecao_aleatoria(p)
p=p/sum(p);
u=rand(1);
s=p(1);
i=1;
while u > s 
    i=i+1;
    s=s+p(i);   
end
% faz o mesmo que
%
% n=length(p);
% i = randsample(n,1,true,p)
end