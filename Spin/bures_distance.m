function [db]=bures_distance(rho1,rho2)
% function [db]=bures_distance(rho1,rho2)

if rho1==rho2
    db=0.0;
else
    db=sqrt(2-2*sqrt(fidelity(rho1,rho2)));
end