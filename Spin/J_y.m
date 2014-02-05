function [Jy]=J_y(J)

if exist('J','var')==0
    J=1/2;
end

Jy=(J_plus(J)-J_minus(J))/(2*i);