function k=selecao_aleatoria(p)
p=p/sum(p);
nr=numel(p);
u=rand(1);
s=0;
i=1;
while u>s+p(i)
    s=s+p(i);
    i=i+1;
end
k=i;
% faz o mesmo que a funcao Matlab y = randsample(nr,1,true,p)
end
