function tao = lagrange_forward(q11,dq11,ddq11)
    global Ts pi g L1 m1 Ic11 P01 P12 Pc11 Pc11_test;
    xc11 = Pc11(1);
    yc11 = Pc11(2);
    Ic11zz = Ic11(3,3);
    tao = ddq11*(m1*xc11^2 + m1*yc11^2 + Ic11zz);
end

