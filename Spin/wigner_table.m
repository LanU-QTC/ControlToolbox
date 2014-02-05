clc;

k1=1;
q1=1;

k2=1;
q2=-1;

fprintf('Non-zero combinations of T^{%g,%g} T^{%g,%g}\n',k1,q1,k2,q2);
for k3=abs(k1-k2):abs(k1)+abs(k2)
    
    if (q1==0) & (q2==0)
        q3=0;
    else
        q3=-q1-q2;
    end
    
    if abs(q3)<=k3
        
        wv=wigner3j(k1,k2,k3,q1,q2,q3);
        
        if wv~=0
            
            fprintf('T^{%g,%g} : %s\n',k3,q3,pretty_frac(wv));
        end
    end
end


