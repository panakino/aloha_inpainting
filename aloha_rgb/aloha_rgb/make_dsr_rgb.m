function [dimgp,vid,mid]=make_dsr_rgb(dimg,Nimg,Nfir)
Nshrink=Nimg-Nfir+1;
if mod(Nimg,2)==0
    hNimg=Nimg/2;
else
    hNimg=(Nimg-1)/2;
end

[Ny,Nx,Nc]=size(dimg);
dimgp=padarray(dimg,[hNimg,hNimg]);

vmask=ones(size(dimg));
vmask=padarray(vmask,[hNimg,hNimg]);
vid=find(vmask==1);

mmask=zeros(size(dimg,1),size(dimg,2));
eNshrink=fix(Nshrink/2);
% hNshrink=eNshrink;
hNshrink=fix(Nshrink/1);
if mod(Nshrink,2)==0
    mmask(eNshrink+1:hNshrink:Ny-eNshrink+1,eNshrink+1:hNshrink:Nx-eNshrink+1)=1;
    mmask(eNshrink+1:hNshrink:Ny-eNshrink+1,Nx-eNshrink+1)=1;
    mmask(Ny-eNshrink+1,eNshrink+1:hNshrink:Nx-eNshrink+1)=1;
    mmask(Ny-eNshrink+1,Nx-eNshrink+1)=1;
else
    mmask(eNshrink+1:hNshrink:Ny-eNshrink,eNshrink+1:hNshrink:Nx-eNshrink)=1;
    mmask(eNshrink+1:hNshrink:Ny-eNshrink,Nx-eNshrink)=1;
    mmask(Ny-eNshrink,eNshrink+1:hNshrink:Nx-eNshrink)=1;
    mmask(Ny-eNshrink,Nx-eNshrink)=1;
end
mmask=padarray(mmask,[hNimg,hNimg]);
mid=find(mmask==1);

