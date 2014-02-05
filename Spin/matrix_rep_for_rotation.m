function [result] = matrix_rep_for_rotation(rank,rotation)
% function [result] = matrix_rep_for_rotation(rank,rotation)
%
% rank = 1,2,3,... rank of tensor to rotate
% rotation=[alpha,beta,gamma] : Euler angles of rotation
%
% weights' = weights * matrix_rep_for_tensor(rank(weights),rotation) 
%
% rank = (length(weights)-1)/2

m_s = -rank:rank;
result = exp(i*rotation(1)*m_s)'*exp(i*rotation(3)*m_s) .* expm( - i * rotation(2) * J_y_matrix(rank) ); 
