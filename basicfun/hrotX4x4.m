function rot = hrotX4x4(a)
    x = eye(4);

    x(1,1) = 1.0;                x(1,2) = 0.0;                x(1,3) = 0.0;                x(1,4) = 0.0;
    x(2,1) = 0.0;                x(2,2) = cos(a);      x(2,3) = -sin(a);   x(2,4) = 0.0;
    x(3,1) = 0.0;                x(3,2) = sin(a);      x(3,3) = cos(a);    x(3,4) = 0.0;
    x(4,1) = 0.0;                x(4,2) = 0.0;                x(4,3) = 0.0;                x(4,4) = 1.0;
    
   for i = 1:4
        for j = 1:4
            if abs(x(i,j))<eps
                x(i,j) = 0.0;
            end
        end
    end


end

