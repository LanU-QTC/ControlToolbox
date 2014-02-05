function [new_value] = read_property(name,default)

new_value = '';

if exist('~/.matlab_properties','dir')==0
    return
end

type_of_value = 0;

hf = fopen(sprintf('~/.matlab_properties/%s.txt',calc_md5(['type of ' strtrim(name)])),'r');

if hf>0
    l = fgetl(hf);
    type_of_value = str2double(l);
    fclose(hf);
else
    if exist('default','var')
        new_value = default;
        return;
    end
end

hf = fopen(sprintf('~/.matlab_properties/%s.txt',calc_md5(strtrim(name))),'r');

if hf>0
    switch type_of_value
        case 0
            new_value = fgetl(hf);
        case 1
            new_value = str2double(fgetl(hf));
    end
    fclose(hf);
end


