classdef lgpib_win
    
    properties
        gDevice
    end
    
    methods
        
        function [obj] = lgpib_win(address)
            
            if exist('name','var')==0
                error 'Requires a name';
            end
            
            obj.gDevice = gpibio(0,address,0,13,1,0);
            
        end
        
        function [result] = write(obj,message)
            result = obj.gDevice.write(message);
        end
        
        function [result] = query(obj,message)
            result = obj.gDevice.ask(message);
        end
        
        function [result] = xwrite(obj,varargin)
            result = obj.gDevice.write(sprintf(varargin{:}));
        end
        
        function [result] = xquery(obj,varargin)
            result = obj.gDevice.ask(sprintf(varargin{:}));
        end
        
        function [result] = interface_clear(obj)
            result = obj.gDevice.ibclr();
        end
        
    end
    
end
        