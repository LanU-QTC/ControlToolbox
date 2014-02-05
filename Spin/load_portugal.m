function [field,g_factor,x,y,par] = load_portugal(fname)
% function [field,g_factor,x,y,par] = load_portugal(fname)

if exist('fname','var')==0
    [path,name]=uigetfile('Choose a text file','*.txt');
end

data = dlmread(fname,sprintf('\t'),4,0);

field = data(:,1)';
g_factor = data(:,2)';
x = data(:,3)';
y = data(:,4)';

try
    par = parse_settings_file(fname);
catch
    par = 0;
end