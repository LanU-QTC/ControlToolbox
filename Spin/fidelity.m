function [f]=fidelity(rho1,rho2)
% function [f]=fidelity(rho1,rho2)

check_density_matrix(rho1,'rho1');
check_density_matrix(rho2,'rho2');

if rho1==rho2
    f=1
else
    sqrt_rho1=sqrtm(rho1);
    sqrt_f=trace(sqrtm(sqrt_rho1*rho2*sqrt_rho1));
    f=sqrt_f*sqrt_f;
end