function [ beta ] = My_Beta(  U_old,m,n,md )
%It calculates beta matrix during center calculation where U_old is
%partition matrix,m and n are image dimensions,md is index.
Nei=[-1 -1;-1 0;-1 1; 0 -1;0 1;1 -1; 1 0;1 1];
One=ones(m,n);
U_tmp=U_old;
U_tmp=(One-U_tmp).^md;
I_tmp=zeros(m,n);
    for i=2:m-1
        for j=2:n-1
            for k=1:8
                i_tmp=Nei(k,1);
                j_tmp=Nei(k,2);
                D=1+Eud_dis(i,j,i_tmp+i,j_tmp+j);
                I_tmp(i,j)=I_tmp(i,j)+(U_tmp(i+i_tmp,j+j_tmp)/D);
            end
        end
    end
beta=I_tmp;

end

