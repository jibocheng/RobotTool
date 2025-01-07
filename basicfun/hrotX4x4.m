function rot = hrotX4x4(a)
    c = cos(a);
    s = sin(a);
    rot = [
           1, 0, 0, 0;
           0, c, -s, 0;
           0, s, c, 0;
           0, 0, 0, 1
           ];


end

