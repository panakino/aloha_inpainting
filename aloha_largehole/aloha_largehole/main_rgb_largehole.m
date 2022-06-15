%% ALOHA - CPU
% 21 APR 2015
% written by Kyong Hwan, Jin

restoredefaultpath;clear;close all;home;

%% load mask & image - Nfir should be odd number.
%%% running
mask1   = double(imread('226033_gray_mask.bmp')>=150);
mask1=repmat(mask1,[1 1 3]);
pts1    = double(imread('226033_gray_pts.bmp')==0);
img1    = double(imread('226033.jpg'));img1 = img1/max(img1(:));
img{1}=img1;
dimg{1}   = img1.*mask1;
param(1)= struct('iname','running','mask',mask1,'dimg',dimg{1}, 'mu',1e3,'muiter',5e2,...
    'Nimg',120,'Nfir',55,'pts',pts1,'tolE',1e-2);   

%%% moor
mask2   = 1-double(rgb2gray(imread('moor_mask.bmp'))<255);
mask2   = repmat(mask2,[1 1 3]);
pts2    = double(rgb2gray(imread('moor_pts.bmp'))==0);
img2    = double(imread('moor_inp.jpg'));img2 = img2/max(img2(:));
img{2}  = img2;
dimg{2} = img2.*mask2;
param(2)= struct('iname','moor','mask',mask2,'dimg',dimg{2}, 'mu',1e3,'muiter',5e2,...
    'Nimg',120,'Nfir',51,'pts',pts2,'tolE',1e-2);

%%% baseball
mask3   = 1-double(imread('151087_gray_mask.bmp')<255);
mask3   = repmat(mask3,[1 1 3]);
pts3    = double(imread('151087_gray_pts.bmp')==0);
img3    = double(imread('151087.jpg'));img3 = img3/max(img3(:));
img{3}  = img3;
dimg{3} = img3.*mask3;
param(3)=struct('iname','baesball','mask',mask3,'dimg',dimg{3}, 'mu',1e3,'muiter',5e2,...
    'Nimg',140,'Nfir',65,'pts',pts3,'tolE',1e-2);

%%% savana
mask4   = 1-double(imread('253036_gray_mask.bmp')<255);
mask4   = repmat(mask4,[1 1 3]);
pts4    = double(imread('253036_gray_pts.bmp')==0);
img4    = double(imread('253036.jpg'));img4 = img4/max(img4(:));
img{4}  = img4;
dimg{4} = img4.*mask4;
param(4)=struct('iname','savana','mask',mask4,'dimg',dimg{4}, 'mu',1e3,'muiter',5e2,...
    'Nimg',120,'Nfir',51,'pts',pts4,'tolE',1e-2);   

%%% bungee
mask5   = 1-double(rgb2gray(imread('bungee_mask.bmp'))<255);
mask5   = repmat(mask5,[1 1 3]);
pts5    = double(rgb2gray(imread('bungee_pts.bmp'))==0);
img5    = double(imread('bungee_inp.png'));img5 = img5/max(img5(:));
img{5}  = img5;
dimg{5} = img5.*mask5;
param(5)= struct('iname','bungee','mask',mask5,'dimg',dimg{5}, 'mu',1e3,'muiter',5e2,...
    'Nimg',120,'Nfir',51,'pts',pts5,'tolE',1e-2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% patch based ALOHA & display results
for iter=2
    img_cur=img{iter};
    param_cur=param(iter);
    
    %% patch based ALOHA
    [recon,t_pro] = aloha_large(param_cur);
    
    display(['Elapsed time : ' num2str(t_pro,4) 's'])
    recon2=param_cur.dimg+(1-param_cur.mask).*recon;
    figure,colormap gray
    subplot(131), imagesc(img_cur,[0 1]),axis equal tight,title({'ORIG'})
    set(gca,'xtick',[],'ytick',[])
    subplot(132), imagesc(param_cur.dimg+(1-param_cur.mask),[0 1]),axis equal tight
    set(gca,'xtick',[],'ytick',[])
    title({['MISSING (' num2str((1-sum(param_cur.mask(:))/numel(param_cur.mask))*100,3) '%)']})
    subplot(133), imagesc(recon2,[0 1]),axis equal tight,
    set(gca,'xtick',[],'ytick',[])
    title({'Proposed'})
    print('-dpng','-r600',[ param_cur.iname '_rgb.png'])
    close
    save([ param_cur.iname '_rgb.mat'])
end

