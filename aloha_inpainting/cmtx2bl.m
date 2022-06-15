function [bl_out]=cmtx2bl(cmtx,id_cmat,Nimg)

%{
bl_out=zeros(Nimg,Nimg);
for iter=1:Nimg^2
    id=find(id_cmat==iter);
    setval=cmtx(id);
    bl_out(iter)=mean(setval);
%     bl_out(iter)=median(setval);
end
%}

bl_out=zeros(Nimg,Nimg);
map=zeros(Nimg,Nimg);
for iter=1:size(id_cmat,2)
    cur_col=id_cmat(:,iter);
    cur_val=cmtx(:,iter);
    ids=find(cur_col~=0);
    map(cur_col(ids))=map(cur_col(ids))+ones(length(ids),1);
    bl_out(cur_col(ids))=bl_out(cur_col(ids))+cur_val(ids);
end

id_o=find(map==0);
map(id_o)=1;
bl_out=bl_out./map;