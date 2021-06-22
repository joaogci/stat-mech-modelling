function [sn] = ex2a(n,p,s0)
    sn = s0;
    for i=1:n
        if rand(1)<p
            if sn==1
                sn=0;
            elseif sn==0
                sn=1;
            end
        end
    end
end

