function [result] = J_x_matrix(S)
% function [result] = J_x_matrix(S)

result = 1/sqrt(2)*( -matrix_rep_for_tensor(S,1,1) + matrix_rep_for_tensor(S,1,-1));