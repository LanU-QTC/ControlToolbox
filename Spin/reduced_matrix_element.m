function [rme]=reduced_matrix_element(S,k)
% function [rme]=reduced_matrix_element(S,k)
%
% Evaluate the reduced matrix element < S || T^(k) || S >
%
rme = exp( 0.5*(2*gammaln(k+1)+gammaln(2*S+k+2)-gammaln(2*k+1)-gammaln(2*S-k+1)-k*log(2) ));