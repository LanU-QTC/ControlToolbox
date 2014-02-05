function [str]=pretty_frac(n)
% function [str]=pretty_frac(n)

if imag(n)~=0
    if real(n)==0
        str = [pretty_frac(imag(n)),'i'];
    else
        if imag(n)>0
            str = [pretty_frac(real(n)),'+',pretty_frac(imag(n)),'i'];
        else
            str = [pretty_frac(real(n)),pretty_frac(imag(n)),'i'];    
        end
    end
    return
end

if n==0
    str='0';
else
    if n<0
        str=['-',pretty_frac(-n)];
    else
        [a,b]=rat(n);
        [a_sq,b_sq]=rat(n^2);
      
        if b>b_sq
            if b_sq==1
                str=sprintf('sqrt(%d)',a_sq);
            else
                str=sprintf('sqrt(%d/%d)',a_sq,b_sq);
            end
        else
            if b==1
                str=sprintf('%d',a);
            else
                str=sprintf('%d/%d',a,b);
            end
        end
    end
end
