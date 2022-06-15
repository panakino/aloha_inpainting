function out = hank2patch(inp,M,N,NC,m,n)

out = zeros(M,N,NC);
W = out;

inp = reshape(inp,size(inp,1),[],NC);

inc=0;
for niter=1:n
    for miter=1:m
        inc = inc+1;
        out(miter:M-m+miter,niter:N-n+niter,:) = out(miter:M-m+miter,niter:N-n+niter,:) + reshape(inp(:,inc,:),(M-m+1),(N-n+1),NC);
        W(miter:M-m+miter,niter:N-n+niter,:) = W(miter:M-m+miter,niter:N-n+niter,:)+1;
    end
end

out = out./W;
