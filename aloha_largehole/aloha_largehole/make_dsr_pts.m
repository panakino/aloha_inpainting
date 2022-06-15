function [dimgp,vid,mid]=make_dsr_pts(dimg,pts,Nimg)
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

mmask=padarray(pts,[hNimg,hNimg]);
mid=find(mmask==1);


%{
map_count=zeros(size(dimg));
Ny_ex=size(dimg,1);
 hNfir=(Nfir-1)/2;
omat=ones(Nimg-2*hNfir);

for iter=1:length(mid(:))
    ucur=mid(iter)-1;
    uy=mod(ucur,Ny_ex)+1;
    ux=fix(ucur/Ny_ex)+1;

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
    map_count(roiys,roixs)  = map_count(roiys,roixs)+omat;
end
figure, 
subplot(131),imagesc(map_count)
subplot(132),imagesc(map_count+vmask)
subplot(133),imagesc(mmask)

%}