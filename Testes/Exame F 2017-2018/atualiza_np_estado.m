function [np]=atualiza_np_estado(np,estado,T,energias)
             dn=2*(randi(2)-1)-1;
             if (np(estado)==0)
                 dn=1;
             end
             dE=energias(estado)*dn;
             if (np(estado)>0)
                 pa=min([1,exp(-dE/T)]);
                 if(np(estado)==1 && dn==-1)
                    pa=min([1,2*exp(-dE/T)]);
                 end
              else
                  pa=min([1,0.5*exp(-dE/T)]);
             end
             if rand(1) < pa
                 np(estado)=np(estado)+dn;
             end
    end