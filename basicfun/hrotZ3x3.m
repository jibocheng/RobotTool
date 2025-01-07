function [rot] = hrotZ3x3(a)
    c = cos(a);
    s = sin(a);
    rot = [
           c, -s, 0;
           s, c, 0;
           0, 0, 1
           ];
end

