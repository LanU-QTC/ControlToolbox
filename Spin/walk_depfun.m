function [result] = walk_depfun(fname,result)

% Get the full path
fname = which(fname);

% Get a list of already-checked files
if exist('result','var')==0
    result = {fname};
else
    result = unique({ result{:} fname });
end

% Find the dependencies of this function
[possibles] = depfun(fname,'-toponly','-quiet');

% For each dependency
for j=1:length(possibles)
    
    % only follow M files
    if isempty(regexp(possibles{j},'\.m$', 'once'))
        continue;
    end
    
    % Don't count files that came installed with matlab
    if ~isempty(regexp(possibles{j},'^/Applications', 'once'))
        continue;
    end
    
    % No duplicates
    if ~isempty(intersect(possibles{j},result))
        continue;
    end
    
    % Walk the dependencies of this file
    subresult = walk_depfun(possibles{j},result);
    % Merge the result
    result = { result{:} subresult{:} };
    
end

result = unique(result);



