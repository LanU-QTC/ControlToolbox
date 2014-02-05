function [result] = reduced_d_matrix(S,beta)
% function [result] = reduced_d_matrix(S,beta)

result = expm( - i * beta * J_y_matrix(S) ); 
