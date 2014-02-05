function [result]=to_engineering_format(value,units,scale)

multipliers={'a','f','p','n','u','m','','k','M','G','T','Y'};

if value==0.0
    result=strtrim(sprintf('0 %s',units));
    return
end

if value<0.0
    result=strtrim(['-',to_engineering_format(-value,units)]);
    return;
end

if exist('scale','var')==0
    result=strtrim(to_engineering_format(value,units,0));
    return
end

this_value=value/(10^(scale*3));

if (1.0<=this_value)
    if (this_value<1000.0)
        result=sprintf('%5.4g %s%s',this_value,multipliers{7+scale},units);
    else
        result=to_engineering_format(value,units,scale+1);    
    end
else
    result=to_engineering_format(value,units,scale-1);    
end


