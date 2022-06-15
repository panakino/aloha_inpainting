function [recon,t_rec]=aloha(param)

Nfir    = param.Nfir;
Nimg    = param.Nimg;
mu      = param.mu;
muiter  = param.muiter;
mask    = param.mask;
dimg    = param.dimg;
[Ny,Nx] = size(dimg);

%% select scanning positions
[dimgp,vid,mid] = make_dsr(dimg,Nimg,Nfir);

%% obtain 2D convlution matrix index
[id_cmat]   = make_2dhankel(Nfir,Nimg);

%% ALOHA - initialization, patch based low rank matrix completion
tic;
rimg        = aloha_patch(dimgp,id_cmat,mask,mid,Nimg,Nfir,mu,muiter);
t_rec=toc;

recon   = reshape(rimg(vid),Ny,Nx);


