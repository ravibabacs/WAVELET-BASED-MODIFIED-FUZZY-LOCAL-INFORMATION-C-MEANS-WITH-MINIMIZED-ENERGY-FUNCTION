clc;
I=imread('gn_0_.01.jpg');
I=rgb2gray(I);
imshow(I);
I=cast(I,'double');
%I=[4 5 6 7;20 21 22 23;60 61 62 63];
[m,n]=size(I);
cls=2;
md=2;
u1=rand(m,n,cls);
u2_old=sum(u1,3);
u2=u2_old;
for i=2:cls
    u2=cat(3,u2,u2_old);
end
u_new=u1./u2; %initial membership matrix
cen=[];
obj_new=0.0;
obj_fun=[];
iter=[];
for k=1:100,
    u_old=u_new;
    for i=1:cls,
        x=sum(sum((u_old(:,:,i).^md).*I));
        y=sum(sum((u_old(:,:,i).^md)));
        cen(i,1)=x/y;    %center calculation
    end
    A=ones(m,n)*cen(1,1);    
    I1=I;
    for i=2:cls
    tmp=ones(m,n)*cen(i,1);
    A=cat(3,A,tmp);
    I1=cat(3,I1,I);
    end
    dist=abs(A-I1); %distance matrix dist calculation
    obj_old=obj_new;
    k
    obj_new=sum(sum(sum((dist.^2).*u_old)))%object function calculation
    obj_fun(k)=obj_new;
    iter(k)=k;
    tmp= dist.^(-2/(md-1));
    tmp1 = sum(tmp,3);
    tmp2=tmp1;
    for i=2:cls
        tmp2=cat(3,tmp2,tmp1);
    end
    u_new=tmp./tmp2;
    % check termination condition
	if k > 1,
		if abs(obj_new - obj_old) < 1e-5, break; end,
	end
end
plot(iter,obj_fun,'r')
xlabel('iteration')
ylabel('objective funtion')
title('convergence')
I_new=I;
for i=1:m
    for j=1:n
        ind=1;
        mem=u_new(i,j,1);
        for k=2:cls
            if u_new(i,j,k)>mem
                mem=u_new(i,j,k);
                ind=k;
            end
        end
        I_new(i,j)=ind;
    end
end
col=250/cls;
I_fin=I_new*col;
I_fin=cast(I_fin,'uint8');
figure,imshow(I_fin)

            
    
