function rx=fex1_alternativo(Nxa, k,lambda,x0)
l=lambda;
xmax=x0+100; xmin=x0; %
nr=20; % numero de retangulos
lr=(xmax-xmin)/nr;
xr=xmin:lr:xmax;

p=inline('l^k*x.^(k-1).*exp(-l*x)/(gammainc(l*x0,k)*gamma(k))','k','l','x','x0');
x=xmin:0.01:xmax;
for i=1:nr
    ir=find(x>=xr(i) & x<= xr(i+1)); % indices do vetor x com x dentro do retangulo
    hr(i) = max(p(k,l,x(ir),x0)); % valor maximo dentro do retangulo
end

% area dos retangulos
a=hr*lr; pr=a/sum(a);

na=0;
while (na <Nxa)
   
    % escolher um retangulo
    ir=roleta(nr,pr);
    % gerar x e y uniformes dentro do retangulo.
    xa=xr(ir)+lr*rand(1); ya=hr(ir)*rand(1);
   
    % verificar se aceitamos
    if (ya <= p(k,l,xa,x0) )
        %aceitamos
         na=na+1;
          rx(na)=xa; % valor guardado do numero aleatorio gerado
    
    end
    
end
end

function caso=roleta(nr,pr)
% escolhe um de nr casos com probabilidade de cada caso no vetor pr
u=rand(1);
pacum=0;
for i=1:nr
    pacum=pacum+pr(i);
    if u<=pacum;
        caso=i;
        return
    end
end
end
