function [result]=check_density_matrix(rho,name)
% function [result]=check_density_matrix(rho,name)

if exist('name','var')==0
    name='rho';
end

tr_a=trace(rho);
tr_a_sq=trace(rho*rho);

if (tr_a~=1) | (tr_a_sq>1) | (tr_a_sq<0)
    fprintf('Warning! trace of %s = %g, trace(%s^2)=%g\n',name,tr_a,name,tr_a_sq);
    result=1;    
else
    result=0;    
end

