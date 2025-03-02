function [x] = hrotZ3x3(a)
    
    x = eye(3);
    
    x(1,1) = cos(a);   x(1,2) = -sin(a);  x(1,3) = 0.0;              
    x(2,1) = sin(a);   x(2,2) = cos(a);   x(2,3) = 0.0;                
    x(3,1) = 0.0;      x(3,2) = 0.0;      x(3,3) = 1.0;                
    
    for i = 1:3
        for j = 1:3
            if abs(x(i,j))<eps
                x(i,j) = 0.0;
            end
        end
    end
end

