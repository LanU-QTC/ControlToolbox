d=dir('*.DTA');

system2=@(x)(fprintf('%s\n',x));
new_title=cell(1,length(d));

renaming=0;

for j=1:length(d)
    hfig=figure;
    [b,y,par]=eprload(d(j).name);
    
    if size(b,2)==1
        plot(b,real(y));    
        title(sprintf('filename = %s\ntitle = %s',regexprep(d(j).name,'_','\\_'),regexprep(par.TITL,'_','\\_')));
        drawnow();
        print(hfig,'-dpdf',regexprep(d(j).name,'\.DTA$','.pdf'));
    else
        waterfall(b{2},b{1},real(y));    
        title(sprintf('filename = %s\ntitle = %s',regexprep(d(j).name,'_','\\_'),regexprep(par.TITL,'_','\\_')));
        drawnow();
        %print(hfig,'-dpdf',regexprep(d(j).name,'\.DTA$','.pdf'));    
    end
    close(hfig);
    new_title{j} = regexprep(regexprep(regexprep(regexprep(regexprep(strtrim(par.TITL),' ','_'),'\.','dot'),'=','eq'),':','_'),',','_'); 
end


for j=1:length(d)
     if renaming==1
         
        new_dta_name = [new_title{j},'.DTA'];
        new_pdf_name = [new_title{j},'.pdf'];
        new_dsc_name = [new_title{j},'.DSC'];
        new_ygf_name = [new_title{j},'.YGF'];
    
        system(sprintf('mv %s %s',d(j).name,new_dta_name));
        system(sprintf('mv %s %s',regexprep(d(j).name,'DTA$','DSC'),new_dsc_name));
        system(sprintf('mv %s %s',regexprep(d(j).name,'DTA$','pdf'),new_pdf_name));
        system(sprintf('mv %s %s',regexprep(d(j).name,'DTA$','YGF'),new_ygf_name));
     end
     
end


