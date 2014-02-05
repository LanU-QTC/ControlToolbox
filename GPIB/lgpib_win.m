classdef lgpib_win
    
    properties
        dev
    end
    
    methods
        
        function [obj] = lgpib_win(name)
            
            if exist('name','var')==0
                error 'Requires an address or a GPIB object';
            end
            
            if strcmp(class(name),'gpib')
                obj.dev = name;
                return
            end
            
            if isnumeric(name)
                prop = instrfind('Type','gpib','BoardIndex',0,'PrimaryAddres',name);
                if isempty(prop)
                    obj.dev = gpib(sprintf('GPIB-%d',name),0,name);
                else
                    obj.dev = prop;
                end
            end
                
        end
        
        function [result] = write(obj,message)
            fprintf(obj.dev,'%s',message);
            result = length(message);
        end
        
        function [result] = query(obj,message)
            obj.write(message);
            result = fgetl(obj.dev);
        end
        
        function [result] = xwrite(obj,varargin)
            result = obj.write(sprintf(varargin{:}));
        end
        
        function [result] = xquery(obj,varargin)
            result = obj.ask(sprintf(varargin{:}));
        end
        
        function [result] = interface_clear(obj)
            clrdevice(obj.dev);
        end
        
    end
    
end
        