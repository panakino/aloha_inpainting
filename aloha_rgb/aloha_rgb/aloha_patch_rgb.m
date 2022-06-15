function [rimg_n,iterset]=...
    aloha_patch_rgb(dimg,mask,mid,Nimg,Nfir,mu,muiter)

if mod(Nimg,2)==0
    hNimg=Nimg/2;
else
    hNimg=(Nimg-1)/2;
end

hNfir=(Nfir-1)/2;
Ny=size(dimg,1);
rimg=zeros(size(dimg));
map_count=zeros(size(dimg));
N=length(mid(:));
maskp=padarray(mask,[hNimg,hNimg]);
Nc=size(dimg,3);
H   = @(inp) patch2hank(inp,Nimg,Nimg,Nc,Nfir,Nfir);
Hi  = @(inp) hank2patch(inp,Nimg,Nimg,Nc,Nfir,Nfir);

%% set parameters for LMaFit
opts = [];
opts.maxit = 1e4;
opts.Zfull = 1;
opts.DoQR  = 1;
opts.print = 0;
opts.est_rank = 2;

%% patch based ALOHA
iterset=zeros(N,1);
for iter=1:N
    ucur=mid(iter)-1;
    uy=mod(ucur,Ny)+1;
    ux=fix(ucur/Ny)+1;
    
    if mod(Nimg,2)==0
        roiy=uy-hNimg:uy+hNimg-1;
        roix=ux-hNimg:ux+hNimg-1;
        roiys=roiy(hNfir+1:end-hNfir);
        roixs=roix(hNfir+1:end-hNfir);
    else
        roiy=uy-hNimg:uy+hNimg;
        roix=ux-hNimg:ux+hNimg;
        roiys=roiy(hNfir+1:end-hNfir);
        roixs=roix(hNfir+1:end-hNfir);
    end
    
    rmask       = maskp(roiy,roix,:);
    mask_cmtx   = H(rmask);
    rval        = dimg(roiy,roix,:);
    cmtx        = H(rval);
    Known       = find(mask_cmtx==1);
    data        = cmtx(Known);
    [m,n]=size(cmtx);
    
    %% Initialization with LMaFit for initial U and V
    [U,V,~] = lmafit_mc_adp(m,n,1,Known,data,opts);
    iterset(iter)=size(U,2);
    V=V';
    meas_id=find(rmask);
    meas=rval(meas_id);
    
    %% Hankel structured matrix completion using ADMM
    X=admm_hankel(U,V,meas,meas_id,mu,muiter,Nimg,H,Hi);

    rimg(roiys,roixs,:)       = rimg(roiys,roixs,:)+X(hNfir+1:end-hNfir,hNfir+1:end-hNfir,:);
    map_count(roiys,roixs,:)  = map_count(roiys,roixs,:)+1;
    display([num2str(iter) '/' num2str(N) ', rank : ' num2str(size(U,2))]);
end

%% normalization about overlapping
id=(map_count==0);
map_count(id)=1;
rimg_n=rimg./map_count;
