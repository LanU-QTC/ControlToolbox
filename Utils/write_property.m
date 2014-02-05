function [new_value] = write_property(name,value)

if exist('~/.matlab_properties','dir')==0
    system('mkdir ~/.matlab_properties');
end

if isstr(value)
    hf = fopen(sprintf('~/.matlab_properties/%s.txt',calc_md5(['type of ' strtrim(name)])),'w');
    fprintf(hf,'0');
    fclose(hf);

    hf = fopen(sprintf('~/.matlab_properties/%s.txt',calc_md5(strtrim(name))),'w');
    fprintf(hf,'%s',value);
    fclose(hf);

else
    
    hf = fopen(sprintf('~/.matlab_properties/%s.txt',calc_md5(['type of ' strtrim(name)])),'w');
    fprintf(hf,'1');
    fclose(hf);

    hf = fopen(sprintf('~/.matlab_properties/%s.txt',calc_md5(strtrim(name))),'w');
    fprintf(hf,'%e',value);
    fclose(hf);
end

