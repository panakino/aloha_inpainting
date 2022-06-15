%% ALOHA - inpainting - RGB channel
% 21 APR 2015
% written by Kyong Hwan, Jin
% If you have any question, please contact to 
% kyonghwan.jin@gmail.com
% jong.ye@kaist.ac.kr

restoredefaultpath;clear;home;%close all;

%% load mask & image - Nfir should be odd number.
%%%%% barbara(512x512) image %%%%%%%%%%%%%
a2=load('mask512_x5.mat'); 
mask=repmat(a2.mask,[1 1 3]);
img = double(imread('barbara512rgb.jpg'));img = img/max(img(:));
dimg=img.*mask;
Nimg=45;
Nfir=13;    % should be odd
param=struct('iname','barabra','mask',mask,'dimg',dimg,'mu',1e1,...
    'muiter',50,'Nimg',Nimg,'Nfir',Nfir);     % house
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% house(256x256) image %%%%%%%%%%%%%%%
% a2=load('mask256_x5.mat'); 
% mask=repmat(a2.mask,[1 1 3]);
% img = double(imread('house256rgb.png'));img = img/max(img(:));
% dimg=img.*mask;
% Nimg=37;
% Nfir=13;    % should be odd
% param=struct('iname','house','mask',mask,'dimg',dimg,'mu',1e1,...
%     'muiter',50,'Nimg',Nimg,'Nfir',Nfir);     % house


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% patch based ALOHA
[recon,t_pro] = aloha_rgb(param);
display(['Elapsed time : ' num2str(t_pro,4) 's'])

%% display results
error = img - dimg; error=error(2:end-1,2:end-1);
psnr_dimg = 10*log10(1/mean((error(:)).^2));
error = img - recon; error=error(2:end-1,2:end-1);
psnr_rec = 10*log10(1/mean((error(:)).^2));

fontname = 'Times'; %'Times', 'Helvetica'
set(0,'defaultaxesfontname',fontname);set(0,'defaulttextfontname',fontname);set(0,'defaulttextfontsize',10)
set(0,'defaultaxesfontsize',15)

figure,colormap gray
subplot(131), imagesc(img,[0 1]),axis square,title({'ORIG'})
set(gca,'xtick',[],'ytick',[])
subplot(132), imagesc(dimg,[0 1]),axis square
set(gca,'xtick',[],'ytick',[])
title({['MISSING (' num2str((1-sum(mask(:))/numel(mask))*100,3) '%)'];['PSNR : ' num2str(psnr_dimg,4)]})
subplot(133), imagesc(recon,[0 1]),axis square,
set(gca,'xtick',[],'ytick',[])
title({['Proposed (' num2str(t_pro) 's)'];['PSNR:' num2str(psnr_rec,4)]})

figure, colormap gray
imagesc(recon,[0 1]),axis square,
set(gca,'xtick',[],'ytick',[])
title({['Proposed (' num2str(t_pro) 's)'];['PSNR:' num2str(psnr_rec,4)]})
