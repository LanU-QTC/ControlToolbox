classdef SimRack < handle
   
    properties
        dev
        identities
        voltagePorts
        safeJump
    end
    
    methods
        
        function [obj] = SimRack(n)
            
            if exist('n','var')==0
                n=5;
            end
            
            obj.identities=cell(1,8);
            obj.dev = lgpib(n);    
            obj.voltagePorts = 0;
            obj.identify_simslots();
            %obj.jumpVoltages(0);
            obj.outputsOn();
            obj.safeJump = 0.1;
            
        end
        
        function [obj] = identify_simslots(obj)
            
            for j=1:8
                
                obj.dev.writef('CONN %d,"ESC"',j);
                obj.identities{j}='none';
           
                s=strtrim(obj.dev.query('*IDN?'));
                [a,b]=strtok(s,',');
                [a,sn]=strtok(b,',');
                
                if strcmp(a,'SIM928')==1
                    obj.voltagePorts = bitor(obj.voltagePorts,bitshift(1,j));
                end
                
                obj.identities{j}=s;
                obj.dev.write('ESC');
                
            end
               
        end
        
        function [obj] = setVoltage(obj,n,v)
            
            % Check the voltage is in range
            v = max([-20.0 min([v 20.0])]);
            % Check the channel is in range
            n = max([ 1 min([round(n) 8]) ] );
            
            % Get current voltage of the channel
            v_start = obj.queryVoltage(n);
            
            % How many steps do we need
            n_steps = ceil( abs(v_start - v) / obj.safeJump);
            
            if n_steps > 1
                
                v_sweep = linspace(v_start,v,n_steps);
                
                for j=v_sweep
                    obj.jumpVoltage(n,j);
                    pause(0.1);
                end
                
            else
                % We can jump immediately
                obj.jumpVoltage(n,v);
            end
            
            
        end
        
        function [obj] = jumpVoltage(obj,n,v)
            
            v = max([-20.0 min([v 20.0])]);
            n = max([ 1 min([round(n) 8]) ] );
            
            obj.dev.writef('CONN %d,"ESC"',n);
            obj.dev.writef('VOLT %e',v);
            obj.dev.write('ESC');
        end
        
        function [opj] = outputOn(obj,n)
            n = max([ 1 min([round(n) 8]) ] );
            
            obj.dev.writef('CONN %d,"ESC"',n);
            obj.dev.write('OPON');
            obj.dev.write('ESC');        
        end
        
        function [obj] = outputOff(obj,n)
            n = max([ 1 min([round(n) 8]) ] );
            
            obj.dev.writef('CONN %d,"ESC"',n);
            obj.dev.write('OPOF');
            obj.dev.write('ESC');        
        end
        
        function [obj] = outputsOn(obj)
            obj.dev.writef('BRER %d',obj.voltagePorts);
            obj.dev.writef('BRDC "OPON\n"');
        end
        
        function [obj] = outputsOff(obj)
            obj.dev.writef('BRER %d',obj.voltagePorts);
            obj.dev.writef('BRDC "OPOF\n"');
        end
        
        function [obj] = jumpVoltages(obj,v)
                       
            v = max([-20.0 min([v 20.0])]);

            obj.dev.writef('BRER %d',obj.voltagePorts);
            obj.dev.writef('BRDC "VOLT %e\n"',v);
            
        end
        
        function [v] = queryVoltage(obj,n)
            
            n = max([ 1 min([round(n) 8]) ] );
            
            obj.dev.writef('CONN %d,"ESC"',n);
            v=str2num(obj.dev.query('VOLT?'));
            obj.dev.write('ESC');        
            
        end
        
        
        
    end
    
end