function [result] = J_y_matrix(S)
% function [result] = J_y_matrix(S)

result = i/sqrt(2)*( matrix_rep_for_tensor(S,1,1) + matrix_rep_for_tensor(S,1,-1));