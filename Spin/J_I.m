function [ji]=J_I(J)

if exist('J','var')==0
    J=1/2;
end

ji=eye(2*J+1);
