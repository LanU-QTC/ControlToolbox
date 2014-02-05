function [result]=matrix_rep_for_tensor(S,k,q)
% function matrix_rep_for_tensor(S,k,q)
%
% Calculate the matrix elements of T^(k,q) between the basis states of
%
% |S,m_s><S,m_s|
result=zeros(2*S+1,2*S+1);

if abs(q)>k
    fprintf('Error: |q| > k at matrix_rep_for_tensor(S=%s,k=%s,q=%s)\n',pretty_frac(S),pretty_frac(k),pretty_frac(q));
else
    
    if k>2*S
        fprintf('Error: k > 2S at matrix_rep_for_tensor(S=%s,k=%s,q=%s)\n',pretty_frac(S),pretty_frac(k),pretty_frac(q));
    else        
        m_s=-S:S;
        rme=reduced_matrix_element(S,k);
        for m2=1:length(m_s)
            for m1=1:length(m_s)
                result(m1,m2)=((-1)^(S-m_s(m2)))*wigner3j(S,S,k,m_s(m2),-m_s(m1),-q)*rme;
            end
        end
        
    end
    
end
