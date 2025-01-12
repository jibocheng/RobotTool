function vec = htr2zyx(T)
    x = T(1,4);
    y = T(2,4);
    z = T(3,4);

    m = T;
    Angle = linspace(0,0,3);
    if (abs(m(1,1)) < eps && abs(m(2,1)) < eps)
        % singularity
        if (abs(m(3, 1) - 1) < eps)
            Angle(1) = 0.0;
            Angle(2) = -pi / 2.0;
            Angle(3) = -atan2(m(1, 2), m(2, 2));
        else
            Angle(1) = 0.0;
            Angle(2) = pi / 2.0;
            Angle(3) = atan2(m(1, 2), m(2, 2));
        end
    else
        Angle(2) = atan2(-m(3, 1), sqrt(m(1, 1)*m(1, 1) + m(2, 1)*m(2, 1)));
        beta = Angle(2);
        Angle(1) = atan2(m(2, 1) / cos(beta), m(1, 1) / cos(beta));
        Angle(3) = atan2(m(3, 2) / cos(beta), m(3, 3) / cos(beta));
    end

    rx = Angle(1);ry = Angle(2);rz = Angle(3);

    vec = [x;y;z;rx;ry;rz];
end

