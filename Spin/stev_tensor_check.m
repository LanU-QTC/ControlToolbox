% Stevens Operators 

clc

% Check that the Stevens operator O^{k,q} is a linear combination of
% the tensors T^{k,q} +- T^{k,-q}
%
% (modulo signs and pre-factors)
%
% stev(S,k,q) is provided in easyspin
% 
% matrix_rep_for_tensor(S,k,q) implements T^{k,q} from Mehring & Weberruss
%

for k=0:9
    for q=0:k
        fprintf('Check k=%d, q=%d : ',k,q);
        
        a=stev(9/2,k,q);
        if q>0
            b=matrix_rep_for_tensor(9/2,k,q)-matrix_rep_for_tensor(9/2,k,-q);
        else
            b=matrix_rep_for_tensor(9/2,k,0);
        end
        
        idx_a=find(abs(a)>1e-4);
        idx_b=find(abs(b)>1e-4);
        
        if length(idx_a)~=length(idx_b)
            fprintf('Error in implementation\n');
        else
            non_zeros=abs(a(idx_a)./b(idx_b));
            
            if (max(non_zeros)-min(non_zeros))>1e-4
                fprintf('Matricies are not equal.\n',k,q);
                a
                b
            else
                fprintf('ratio stev/tensor = %s\n',pretty_frac(mean(abs(non_zeros))));
            end
        end
    end
    fprintf('\n');
end
