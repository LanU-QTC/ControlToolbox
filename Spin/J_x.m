function [Jx]=J_x(J)

if exist('J','var')==0
    J=1/2;
end

Jx=(J_plus(J)+J_minus(J))/2;