function [result]=engineering_format(n,units,p1,p2,multiplier)

if n==0
    s=sprintf('0 %s',units);
    return
end

if exist('p1','var')==0
    p1=3;
end

if exist('p2','var')==0
    p2=1;
end

if exist('multiplier','var')==0
    multiplier = 0;
end

if n<0
    s=engineering_format(-n,units,p1,p2,multiplier);
end

if n<1
    s=engineering_format(n*1000,units,p1,p2,multiplier-1);
else
    if n>1000
        s=engineering_format(n/1000,units,p1,p2,multiplier+1);
    else
        multipliers={'a','f','p','n','u','m','','k','M','G','T'};
        s=sprintf(sprintf('%%%d.%dg %%s%%s',p1,p2),n,multipliers{multiplier+7},units);
    end
end

result=strtrim(s);