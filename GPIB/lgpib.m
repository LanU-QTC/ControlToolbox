classdef lgpib
    
    properties
        handle
        name
        eos_mode
        verbose
    end
    
    methods
        
        function [obj] = lgpib(name,eos_mode)
            
            if exist('gpib_function')~=3
                lgpib.Compile();
            end
            
            if exist('name','var')==0
                error 'Requires a name';
            end
            
            if exist('eos_mode','var')==0
                eos_mode = 0;
            end
            
            obj.eos_mode = eos_mode;
            
            obj.verbose = 0;
            
            if isstr(name)
                %fprintf('Treating name as a string\n');
                obj.handle = gpib_function('ibfind',name);
                obj.name = name;
                
                if (obj.handle<0)
                   fprintf('lgpib Error: Could not open device ''%s''\n',name);
                end

            else
                if isnumeric(name)
                    obj.handle = gpib_function('ibdev',0,name,0,9,hex2dec('400')+hex2dec('800')+hex2dec('1000'),1);
                    obj.name = num2str(name);
                end
                
                if (obj.handle<0)
                   fprintf('lgpib Error: Could not open device at address %d\n',name);
                end
            end
                    
            
        end
        
        function [obj] = set_eos_mode(obj)
            obj.eos_mode = 1;
        end
        
        
        function [result] = set_eoi(obj,send_eoi_if_nonzero)
        
            if exist('send_eoi_if_nonzero','var')==0
            end
            
            if send_eoi_if_nonzero==0
                send_eoi_if_nonzero_16 = zeros(1,1,'uint16');
            else
                send_eoi_if_nonzero_16 = ones(1,1,'uint16');
            end
                     
            result=gpib_function('ibeot',obj.handle,send_eoi_if_nonzero_16);            
        end
        
        function check_for_error(obj)
            
            result = obj.xquery(':SYST:ERR?');
            if (isempty(result))
                error(':SYST:ERR query failed');
            end
            
            if (~strcmp(result(1:2), '0,'))
                error('Error with previous command: Result = %s\n', result);
            end
            
        end
        
        function [result] = set_eos(obj,ch,read_eos,transmit_eos,binary)
        
            if exist('ch','var')==0
                ch = sprintf('\n');
            else
                ch = sprintf(ch);
            end
            
            if exist('read_eos','var')==0
                read_eos = 1;
            end
            
            if exist('transmit_eos','var')==0
                transmit_eos = 1;
            end
            
            if exist('binary','var')==0
                binary = 0;
            end
            
            eos_value = zeros(1,1,'uint16');
            eos_value(1) = ch(1);
            eos_value(1)= bitand(eos_value(1),255);
             
            if read_eos ~= 0
                eos_value = bitor(eos_value,hex2dec('400'));
            end
            
            if transmit_eos ~= 0
                eos_value = bitor(eos_value,hex2dec('800'));
            end
            
            if binary ~= 0
                eos_value = bitor(eos_value,hex2dec('1000'));
            end
            
            result=gpib_function('ibeos',obj.handle,eos_value);            
        end
        
        function [status,write_count] = xfprintf(obj,varargin)
            [status,write_count] = obj.write(sprintf(varargin{:}));
        end
                        
        
        function [status,write_count] = writef(obj,varargin)
            [status,write_count] = obj.write(sprintf(varargin{:}));
        end
        
        function [status,write_count] = xwrite(obj,varargin)
            [status,write_count] = obj.write(sprintf(varargin{:}));
        end
        
        function [status,write_count] = write(obj,message)          
     
            if obj.verbose==1
                fprintf('lgpib:%s %s\n',obj.name,message);
            end
            
            [gpib_status,gpib_count] = gpib_function('ibwrt',obj.handle,message);
            
            if nargout>=1
                status = gpib_status;
            end
            
            if nargout>=2
                write_count=gpib_count;
            end      
        end
        
        function [n]=discard_bytes_via_serial_poll(obj)
            
            n=0;
            while bitand(obj.serial_poll(),2)==2
               stale = obj.read(1);
               n=n+1;
            end
            
        end
        
        function [result] = wait_for_message_available(obj)
            n=0;
            result = 0;
            
            while (n<30)
                
                pause(0.1);
                
                if bitand(obj.serial_poll(),16)==16
                    result = 1;
                    break
                end
                
                n=n+1;
            end
        end
        
        function [reply,read_count] = oi_xquery(obj,varargin)
            if obj.eos_mode == 1 
                [reply,read_count] = obj.oi_xquery_eos(varargin{:});
            else
                [reply,read_count] = obj.oi_xquery_no_eos(varargin{:});
            end
        end
        
        function [reply,read_count] = oi_xquery_eos(obj,varargin)
            
            % Make sure there are no unread queries
            obj.discard_bytes_via_serial_poll();

            % Write a new query
            obj.xwrite(varargin{:});
            
            % Block for Message Available Flag
            obj.wait_for_message_available();
            
            %
            [reply,read_count] = obj.read_to_eos('\r');
        end
        
        function [reply,read_count] = oi_xquery_no_eos(obj,varargin)
            
            % Make sure there are no unread queries
            obj.discard_bytes_via_serial_poll();

            % Write a new query
            obj.xwrite(varargin{:});
            
            % Block for Message Available Flag
            obj.wait_for_message_available();
            
            %
            [reply,read_count] = obj.read_to_eos('\r');
        end
        
        
        function [reply,read_count] = read_to_eos(obj,eos)
        
            reply = '';
           
            
            if length(eos)>1
                eos = sprintf(sprintf('%s',eos));
            end
                        
            while (1==1)
                [gpib_reply,gpib_status,gpib_count] = gpib_function('ibrdl',obj.handle,1);
                
                
                %fprintf('%s',gpib_reply);
                
                if gpib_count<1
                    break
                end
                
                if strcmp(gpib_reply,eos)==1
                    reply = [reply eos];
                    break
                end
                
                reply = [reply gpib_reply];
                
            end
            
            read_count = length(reply);            
        end
        
        function [status,write_count]=binblockwrite(obj,header,block)
            
            block_length = sprintf('%d',length(block));
            preamble = sprintf('%s #%d%s',header,length(block_length),block_length);
            
            if obj.verbose>0
                fprintf('Sending  : %s<...>\n',preamble);
            end
            
            header_sixteen = zeros(1,length(preamble),'uint16');
            header_sixteen(1:end) = preamble(1:end);
            
            block_sixteen = zeros(1,length(block),'uint16');
            block_sixteen(1:end) = block(1:end);
            
            %obj.data_output_stream.write(header_eight);
            %obj.data_output_stream.write(block,0,length(block));
            %obj.data_output_stream.flush();
            
            %header_sixteen
            %block_sixteen
            
            [status,write_count] =gpib_function('ibwrt',obj.handle,[header_sixteen block_sixteen]);
            
        end
        
        function [reply,status,read_count] = read(obj,l)  
            
            if nargin==1
                l=8192;
            end
            
            [gpib_reply,gpib_status,gpib_count] = gpib_function('ibrdl',obj.handle,l);
            
            reply = gpib_reply;
                        
            if nargout>=2
                status = gpib_status;
            end
            
            if nargout>=3
                write_count=gpib_count;
            end
        end
        
        function [reply] = xquery(obj,varargin)
            reply = obj.query(sprintf(varargin{:}));
        end
        
        function [reply] = query(obj,message,l)
            
            if nargin==2
                l = 8192;
            end
            
            obj.write(message);
            
            reply = obj.read(l);
        end
        
        function [reply] = set_timeout(obj,tmo)
            reply = gpib_function('ibtmo',obj.handle,tmo);
        end
                
        function [reply] = serial_poll(obj)
            reply = gpib_function('ibrsp',obj.handle);
        end
        
        function [status] = get_status(obj)
            status = gpib_function('ibsta',obj.handle);
        end
        
        function [cntl] = get_counter(obj)
            status = gpib_function('ibcntl',obj.handle);
        end
        
        function [status] = clear(obj)
            status = gpib_function('ibclr',obj.handle);
        end
        
        function [status] = interface_clear(obj)
            status = obj.clear();
        end
        
    end      
    
    methods (Static)
        function Compile
            fprintf('Compiling gpib_function.c\n');
            mex gpib_function.c dispatch.c -lgpib
        end
    end
    
end
        