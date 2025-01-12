function rot = hrotZ4x4( a )
    c = cos(a);
    s = sin(a);
    rot = [
           c, -s, 0, 0;
           s, c, 0, 0;
           0, 0, 1, 0;
           0, 0, 0, 1
           ];
end

