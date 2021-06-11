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

    
