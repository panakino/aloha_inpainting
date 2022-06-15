function X=admm_hankel(U,V,meas,meas_id,id_cmat,mu,muiter,Nimg)

H   = @(inp) bl2cmtx(inp,id_cmat);
Hi  = @(inp) cmtx2bl(inp,id_cmat,Nimg);

r=size(U,2);
X=zeros(Nimg);
L=zeros(size(id_cmat));
for iter=1:muiter
    X=Hi(U*V'-L);
    X(meas_id)=meas;
    Hx=H(X);
    U=mu*(Hx+L)*V*inv(eye(r)+mu*V'*V);
    V=mu*(Hx+L)'*U*inv(eye(r)+mu*U'*U);
    L=Hx-U*V'+L;
end

X(meas_id)=meas;