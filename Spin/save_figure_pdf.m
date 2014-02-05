function [fname]=save_figure_pdf(hfig,fnout,overwrite,quiet)
% function [fname]=save_figure_pdf(hfig,fnout)
%
% hfig = handle of figure
%
% fnout = output filename (eg. 'output.pdf')
%
% quiet =0 : suppress text output
%       =1 : show some messages

if exist('overwrite','var')==0
    overwrite=true;
end

if overwrite==false
    if exist(fnout,'file')~=0
        fprintf('File `%s'' already exists, not overwriting.\n',fnout);
        return
    end
end

if exist('/etc/','file')~=0
    del='rm -f ';
    move='mv ';
    magic='export PATH=/usr/local/bin:$PATH;';
else
    del='del';
    move='move';
    magic='';    
end

if exist('quiet','var')==0
    quiet=0;
end

if exist('fnout','var')==0
    fprintf('Error! You did not specify an output filename, or forgot the handle variable!\n');
    fname='';
    return
end


try
    if quiet==0
        fprintf('Saving figure %d to file `%s''...',floor(hfig),fnout);
    end
    
    tempstub=tempname;
    fnps=sprintf('%s.ps',tempstub);
    fnpdf=sprintf('%s.pdf',tempstub);
    print(hfig,'-dpsc2',fnps);
    %action=sprintf('export PATH=/usr/local/bin:$PATH;ps2pdf %s %s;rm %s;mv %s %s;',fnps,fnpdf,fnps,fnpdf,fnout);
    action=sprintf('%sps2pdf %s %s',magic,fnps,fnpdf);
    system(action);
    action=sprintf('%s %s',del,fnps);
    system(action);
    action=sprintf('%s %s %s',move,fnpdf,fnout);
    system(action);
    
    if quiet==0
        fprintf(' Done.\n');
    end
    fname=fnout;
catch
    fprintf('save_figure_pdf: could not save figure\n');
    fname='';
end