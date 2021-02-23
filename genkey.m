function x = genkey(s,c,n) 
    % Generates n bits of the recursively defined key  
    % using initial string s and vector c.  
    % The result is returned as a vector  
    % so it's usually good to wrap it in   
    % transpose or ' it to look at it.  
    % Usage:  
    % >> genkey([1;0;1;1],[1;1;0;0],10)'  
    % ans =  
    %   1     0     1     1     1     1     0     0     0     1  
    x = s;  
    l = length(s); 
    for j = [l+1:n]   
        x = [x;mod(transpose(x(j-l:j-1))*c,2)]; 
    end
end