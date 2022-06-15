function [recon,t_rec]=aloha_rgb(param)

Nfir    = param.Nfir;
Nimg    = param.Nimg;
mu      = param.mu;
muiter  = param.muiter;
mask    = param.mask;
dimg    = param.dimg;
[Ny,Nx,Nc] = size(dimg);

%% select scanning positions
[dimgp,vid,mid] = make_dsr_rgb(dimg,Nimg,Nfir);

%% ALOHA - initialization, patch based low rank matrix completion
t_all=tic;
rimg        = aloha_patch_rgb(dimgp,mask,mid,Nimg,Nfir,mu,muiter);
t_rec=toc(t_all);

recon   = reshape(rimg(vid),Ny,Nx,Nc);

recon(mask==1)=dimg(mask==1);
