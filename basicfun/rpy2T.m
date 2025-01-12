function T = rpy2T(vec)
    T = eye(4);
    T(1:3,1:3) = hrotZ3x3(vec(6))*hrotY3x3(vec(5))*hrotX3x3(vec(4));
    T(1,4) = vec(1); T(2,4) = vec(2); T(3,4) = vec(3);

end

