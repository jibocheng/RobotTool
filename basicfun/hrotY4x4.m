function rot = hrotY4x4(a)
    c = cos(a);
    s = sin(a);
    rot = [
           c, 0, s, 0;
           0, 1, 0, 0;
           -s, 0, c, 0;
           0, 0, 0, 1
           ];

end

