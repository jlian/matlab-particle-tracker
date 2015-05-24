classdef convert
    
    properties (Constant)
        % 1 pixel = 0.0001461870504 meters
        a = 0.8636/923;
        
        % 1 frame = 1/600 seconds
        b = 1/600;
        
        % set the equillibrium position in meters
        eq = 0;
        
        % set mass of one magnet in kg
        m = 0.009601;
        
        % set the offset of the bottom fixed magent in number of pixels
        o = 20.5;
        
        % set the pull force in lbs
        pf = 11.33;
    end
    
    methods (Static)
     
        function output = pixelsToMeters(X, pxperm)
            for i=1:size(X,2)
                for j = 1:size(X,1)
                output(j,i) = X(j,i)*pxperm; 
                end
            end 
        end
        
        function output = framesToSeconds(Y)
            for i=1:size(Y,2)
                output(i) = Y(i)*convert.b; 
            end 
        end
        
        function output = velToMetric(vel)
            for i=1:size(vel,2)
                output(i) = vel(i)*convert.a/convert.b;
            end
        end
        
        function output = accToMetric(acc)
            for i=1:size(acc,2)
                output(i) = acc(i)*convert.a/convert.b/convert.b;
            end 
        end
        
        function output = NTolb(force) 
            for i=1:size(force,2) 
                output(i) = force(i)*0.22481;
            end
        end
        
        function output = metersToInches(disp)
            for i=1:size(disp, 2) 
                output(i) = disp(i)*39.3701; 
            end
        end
            
    end
    
end

