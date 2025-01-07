function rot = hrotY3x3( a )
    c = cos(a);
    s = sin(a);
    rot = [
           c, 0, s;
           0, 1, 0;
           -s, 0, c;
           ];


end

