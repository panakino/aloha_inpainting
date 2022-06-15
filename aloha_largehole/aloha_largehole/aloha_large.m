function [recon,t_rec]=aloha_large(param)

Nfir    = param.Nfir;
Nimg    = param.Nimg;
mu      = param.mu;
muiter  = param.muiter;
mask    = param.mask;
dimg    = param.dimg;
pts     = param.pts;
tolE    = param.tolE;
[Ny,Nx,Nc] = size(dimg);

%% select scanning positions
if isempty(pts)
    [dimgp,vid,mid] = make_dsr(dimg,Nimg,Nfir);
else
    [dimgp,vid,mid] = make_dsr_pts(dimg,pts,Nimg);
end

%% setting Kernel

H   = @(inp) patch2hank(inp,Nimg,Nimg,Nc,Nfir,Nfir);
Hi  = @(inp) hank2patch(inp,Nimg,Nimg,Nc,Nfir,Nfir);

%% ALOHA - initialization, patch based low rank matrix completion
tic;
rimg        = aloha_patch_large(dimgp,mask,mid,Nimg,Nfir,Nc,mu,muiter,tolE,H,Hi);
t_rec=toc;

recon   = reshape(rimg(vid),Ny,Nx,Nc);


