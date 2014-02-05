function [result]=matrix_rep_for_tensor_operator(S,weights)
% function [result]=matrix_rep_for_tensor_operator(S,weights)

k = (length(weights)-1)/2;
m_s = -k:k;

result = zeros(2*S+1);

for q=1:length(m_s)
    result = result + weights(q) * matrix_rep_for_tensor(S,k,m_s(q));
end

