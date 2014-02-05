function [m]=lie_lambda(n,ii)
% function [m]=lie_lambda(n,i)
%
% return the generator lambda_i belonging to the algebra SU(n)

if exist('n','var')==0
    n=3;
end

if exist('ii','var')==0
    ii=4;
end

m=zeros(n);

xy_max=n*(n-1);

z_value=2;
ii_check=z_value*z_value-1;

k=1;
skip=0;

for a=2:n
    for b=1:(a-1)
        
        fprintf('k=%d, a=%d,b=%d\n',k-skip,a,b);
        
        if k==ii_check
            fprintf('z-matrix\n');
            skip=skip+1;
            continue;
        end
        
        k=k+1;
        
        fprintf('k=%d, a=%d,b=%d\n',k-skip,a,b);
        
        if k==ii_check
            fprintf('z-matrix\n');
            skip=skip+1;
            continue;
        end
        
        k=k+1;
        
        
    end
end