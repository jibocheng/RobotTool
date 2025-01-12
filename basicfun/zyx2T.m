function T = zyx2T(vec)
    rx = vec(4); ry = vec(5); rz = vec(6);
    rot =  hrotZ4x4(rz) * hrotY4x4(ry) * hrotX4x4(rx);
    rot(1,4) = vec(1);
    rot(2,4) = vec(2);
    rot(3,4) = vec(3);
    T = rot;
end

