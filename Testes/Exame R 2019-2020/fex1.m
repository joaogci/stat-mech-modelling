function x=fex1(n, k,lambda,x0)
%if (x0>=(k-1)/lambda && k>=1 && lambda>0)
if ( k>=1 && lambda>0)
    for i=1:n
        u=rand(1);
        x(i)=gammaincinv((1-u)*gammainc(lambda*x0,k,'upper'),k,'upper')/lambda;
    end
   else
   fprintf(1,'Valor nao definido \n');
    x=0;
end
end
