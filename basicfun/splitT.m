function [R,P] = splitT(T)
    
    R = zeros(3,3);
    P = zeros(3,1);
    
    R = T(1:3,1:3);
    P = T(1:3,4);


end

