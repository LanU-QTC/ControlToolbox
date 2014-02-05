function [Jminus]=J_minus(J)

if exist('J','var')==0
    J=1/2;
end

Jminus=zeros(2*J+1);

for i=1:(2*J+1)-1
    m=J-(i-1);
    Jminus(i+1,i)=sqrt(J*(J+1) - m*(m-1));
end
