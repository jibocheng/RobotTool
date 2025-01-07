function rot = hrotX3x3(a)
    c = cos(a);
    s = sin(a);
    rot = [
           1, 0, 0;
           0, c, -s;
           0, s, c
           ];
    
end

