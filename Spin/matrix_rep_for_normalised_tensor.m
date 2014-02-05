function [result]=matrix_rep_for_normalised_tensor(S,k,q)
% function matrix_rep_for_normalised_tensor(S,k,q)
%
% Calculate the matrix elements of T_u^(k,q) between the basis states of
%
% |S,m_s><S,m_s|

n=exp( 0.5*( ...
    k*log(2)+log(2*k+1)+gammaln(2*S-k+1)+gammaln(2*k+1)-gammaln(2*S+k+2)) ...
    - gammaln(k+1) );

%n = sqrt(2^k*(2*k+1)*factorial(2*S-k)*factorial(2*k)/factorial(2*S+k+1))/factorial(k);

result=n*matrix_rep_for_tensor(S,k,q);

                  