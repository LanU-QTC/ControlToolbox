function [Jp]=J_plus(J)

if exist('J','var')==0
    J=1/2;
end

Jp=zeros(2*J+1);

for i=2:(2*J+1)
    m=J-(i-1);
    Jp(i-1,i)=sqrt(J*(J+1) - m*(m+1));
end
