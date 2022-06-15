function out = patch2hank(inp,M,N,NC,m,n)

out = zeros((M-m+1)*(N-n+1),m*n,NC);
inc=0;
for niter=1:n
    for miter=1:m
        inc = inc+1;
        out(:,inc,:) = reshape(inp(miter:M-m+miter,niter:N-n+niter,:),(M-m+1)*(N-n+1),1,NC);
    end
end

out = reshape(out,size(out,1),[]);