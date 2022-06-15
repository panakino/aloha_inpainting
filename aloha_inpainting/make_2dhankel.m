function [id_mat]=make_2dhankel(Nfir,Nimg)

m=(Nfir-1)/2;
n=m;

id_img=reshape(1:Nimg^2,Nimg,Nimg);
id_mat=zeros((Nimg-Nfir+1)^2,Nfir^2);

for iter=1:Nimg
    evec=id_img(:,iter);
    eh=hankel(evec(1:Nimg-2*m),evec(end-2*m:end));    
    
    btmp=zeros(Nimg,1);
    btmp(iter)=1;
    bvec=hankel(btmp(1:Nimg-2*n),btmp(end-2*n:end));    

    tmp_res=kron(bvec,eh);
    id_mat=id_mat+tmp_res;
end