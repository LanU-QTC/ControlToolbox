function [Jz]=J_z(J)

if exist('J','var')==0
    J=1/2;
end

Jz=zeros(2*J+1);

for i=1:(2*J+1)
    m=J-(i-1);
    Jz(i,i)=m;
end
