function [result] = latex_format(n,prec,ensure_math)

if exist('ensure_math','var')==0
    ensure_math = 1;
end

if ensure_math == 1;
    a='\ensuremath{';
    b='}';
else
    a='';
    b='';
end

if n==0
    result = strtrim( [ a '0' b] );
    return;
end

if exist('prec','var')==0
    prec=4;
end

if n<0
    result = strtrim( [ a '-' latex_format(-n,prec,0) b ] );
    return
end

prec_str=sprintf('%%%d.%dg',prec,prec-1);

if (n>=0.01) & (n<1000.0)
    result = strtrim( sprintf(prec_str,n) );
    return;
else

    p=0;
    
    while ((n<1) | (n>=10))
        if n<1
            n=n*10;
            p=p-1;
        end
        if n>=10
            n=n/10;
            p=p+1;
        end
    end
    
    result = strtrim( [ a sprintf([prec_str ' \\times 10^{%d}'],n,p) b ] );
    
end



