function [cmtx]=bl2cmtx(bl,id)

cmtx=zeros(size(id));
id_nz=find(id~=0);
cmtx(id_nz) = bl( id(id_nz) );
