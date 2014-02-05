function [this_tarball] = save_matlab_tree()
	
	% This function will create an archive file containing every .m file that could be run from the callee
	%
	% e.g. 
	% 
	% Suppose you want to take a record of each script and .m file used in a particular measurement
	%
	% add the command 
	%
	% save_matlab_tree()
	%
	% into your script; this code will then search out the dependents of your script, and bundle them into an archive
	%

    S = dbstack('-completenames');

    if length(S)<2
        fprintf('Call this function from an external routine\n');
        this_tarball = '';
        return;
    end
    
    % We want to store all callee's of this file
    target_m_file = S(2).file;
    fprintf('Saving dependencies of `%s''\n',target_m_file);
    
    % This returns a cell array of file names
    result = walk_depfun(target_m_file);
    
    % Write a list of files to keep
    fname = tempname();
    hf = fopen(fname,'w');
    for j=1:length(result);
        fprintf(hf,'%s\n',result{j});
    end
    fprintf(hf,'receipt.txt');
    fclose(hf);
    
    hf = fopen('receipt.txt','w');
    for j=1:length(result);
        fprintf(hf,'%s\n%s\n',result{j},calc_md5(result{j}));
    end
    fclose(hf);
    
    % Run the command to create the archive - only works on mac
    this_tarball = [regexprep(target_m_file,'\.m$','') '_calltree_' datestr(now(),'ddmmyy_HHMMSS') '.tar.bz2'];    
    cmd_string = sprintf('tar --files-from %s -jcf "%s" 2>/dev/null > /dev/null',fname,this_tarball);
    system(cmd_string);
end
