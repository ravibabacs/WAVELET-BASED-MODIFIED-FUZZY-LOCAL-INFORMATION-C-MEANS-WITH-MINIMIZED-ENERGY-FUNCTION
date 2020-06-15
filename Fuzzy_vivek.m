clc;
I=imread('im1.bmp');


if( size(I,3)>1 )
    I=rgb2gray(I);
end
figure,imshow(I);
I=cast(I,'double');
%I=[10 16 66 72 84;32 40 69 81 73;25 31 27 42 76;72 81 32 44 22;64 79 84 19 27];
[m,n]=size(I);
cls=3;
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
obj_fun1=[];
obj_fun2=[];
iter=[];
for k=1:500,
    u_old=u_new;
    for i=1:cls,
        alpha=Alpha_vivek(u_old(:,:,i),m,n,md,I);
        x=sum(sum(((u_old(:,:,i).^md).*I)+ alpha));
        beta=Beta_vivek(u_old(:,:,i),m,n,md);
        y=sum(sum((u_old(:,:,i).^md)+beta));
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
    fuzzy=Vivek_fac(u_old,m,n,md,cls,dist);
    obj_new=sum(sum(sum((dist.^2).*(u_old.^md)+fuzzy)))%object function calculation
    obj_fun1(k)=obj_new;
    obj_fun2(k)=sum(sum(sum(fuzzy)));
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
		if abs(obj_new - obj_old) < 1e-3, break; end,
    end
end
k
figure,plot(iter,obj_fun1,iter,obj_fun2,'r--')
xlabel('Iteration')
ylabel('Energy Function')
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
%col=250/cls;
%I_tmp=I_new;
%I_fin=[];
%for i=1:2
    %for j=1:cls
        %for k=1:m
            %for l=1:n
                %if I_tmp(k,l)==j
                    %if i==1
                        %I_tmp(k,l)=col*j;
                    %else
                        %I_tmp(k,l)=col*(cls-j+1);
                    %end
                %end
            %end
        %end
    %end
    %I_fin(:,:,i)=I_tmp;
%end
%I_fin(:,:,3)=I_new*60;
%I_fin=cast(I_fin,'uint8');
%figure,imshow(I_fin)col=250/cls;
col=250/cls;
I_fin=I_new*col;
I_fin=cast(I_fin,'uint8');
figure,imshow(I_fin)


            
    
