function X=admm_hankel(U,V,meas,meas_id,mu,muiter,Nimg,H,Hi)

r=size(U,2);
X=zeros(Nimg);
L=zeros(size(U,1),size(V,1));
for iter=1:muiter
    X=Hi(U*V'-L);
    X(meas_id)=meas;
    Hx=H(X);
    U=mu*(Hx+L)*V*inv(eye(r)+mu*V'*V);
    V=mu*(Hx+L)'*U*inv(eye(r)+mu*U'*U);
    L=Hx-U*V'+L;
end

X(meas_id)=meas;