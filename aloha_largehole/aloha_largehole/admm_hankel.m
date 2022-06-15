function X=admm_hankel(U,V,meas,meas_id,mu,muiter,Nimg,Nfir,Nc,H,Hi)

r=size(U,2);
I_gpu=(eye(r,'single'));
X=(zeros(Nimg,Nimg,Nc,'single'));
L=(zeros((Nimg-Nfir+1)^2,Nfir^2*Nc,'single'));
Hx=L;

for iter=1:muiter
    
    X=Hi(U*V'-L);
    X(meas_id)=meas;
    
    Hx=H(X);
    HXL=mu*(Hx+L);
    U=HXL*V/(I_gpu+mu*V'*V);
    V=HXL'*U/(I_gpu+mu*U'*U);
    
    % QR and SVD inversion
    %{
    [Qv,Rv]=qr(V,0);
    [uv, sv, vv]=svd(Rv,0);
    i1=Qv*uv*(sv./(1+mu*sv.^2))*vv';
    U=HXL*i1;
    
    [Qu,Ru]=qr(U,0);
    [uu, su, vu]=svd(Ru,0);
    i2=Qu*uu*(su./(1+mu*su.^2))*vu';
    V=HXL'*i2;
    %}
    L=Hx-U*V'+L;
    
    %direct inversion
%     U=mu*(Hx+L)*V*inv(I_gpu+mu*V'*V);
%     V=mu*(Hx+L)'*U*inv(I_gpu+mu*U'*U);
end

X(meas_id)=meas;
