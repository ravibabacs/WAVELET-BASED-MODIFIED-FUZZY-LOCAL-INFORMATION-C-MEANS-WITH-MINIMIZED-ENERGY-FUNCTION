function [ fuzzy ] = Vivek_fac( U_old,m,n,md,cls,dist )
% This function calculates the vivek factor matrix G.Inputs have their
% usual meaning.
Nei=[-1 -1;-1 0;-1 1; 0 -1;0 1;1 -1; 1 0;1 1];
%One=ones(m,n,cls);
U_tmp=U_old;
U_tmp=(U_tmp).^md;
U_tmp=U_tmp.*(dist.^2);
I_tmp=zeros(m,n,cls);
for c=1:cls
    for i=2:m-1
        for j=2:n-1
            for k=1:8
                i_tmp=Nei(k,1);
                j_tmp=Nei(k,2);
                D=1+Eud_dis(i,j,i_tmp+i,j_tmp+j);
                I_tmp(i,j,c)=I_tmp(i,j,c)+(U_tmp(i+i_tmp,j+j_tmp,c)/D);
            end
        end
    end
end
fuzzy=I_tmp;

end

