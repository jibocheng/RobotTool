function [tao1,tao2] = twolinkT2_tao_linear_seprate_cal(q11,dq11,ddq11,q22,dq22,ddq22)
    global g m1 m2 P01 P12 Pc11 Pc22;
    global Ii11 Ii22 U;
    Ii11xx = Ii11(1,1);Ii11xy = Ii11(1,2);Ii11xz = Ii11(1,3);
    Ii11yy = Ii11(2,2);Ii11yz = Ii11(2,3);Ii11zz = Ii11(3,3);
    Ii22xx = Ii22(1,1);Ii22xy = Ii22(1,2);Ii22xz = Ii22(1,3);
    Ii22yy = Ii22(2,2);Ii22yz = Ii22(2,3);Ii22zz = Ii22(3,3);
    % rotation handling 
    R01 = hrotZ3x3(q11); R10 = R01';
    R12 = hrotX3x3(-pi/2)*hrotZ3x3(q22); R21 = R12';
    R23 = hrotX3x3(pi/2); R32 = R23';
    
    % from inner to out 0->2:
    w00 = [0;0;0]; dw00 = [0;0;0]; dv00 = [0;0;g];
    Zv = [0;0;1];
    % motion1
    w11 = R10*w00 + dq11*Zv;
    dw11 = R10*dw00 + cross(R10*w00,dq11*Zv) + ddq11*Zv;
    dv11 = R10*(cross(dw00,P01) + cross(w00,cross(w00,P01)) + dv00);
    % motion2
    w22 = R21*w11 + dq22*Zv;
    dw22 = R21*dw11 + cross(R21*w11,dq22*Zv) + ddq22*Zv;
    dv22 = R21*(cross(dw11,P12) + cross(w11,cross(w11,P12)) + dv11);

    % body parameters
    phi1 =[m1 m1*Pc11(1) m1*Pc11(2) m1*Pc11(3) Ii11xx Ii11xy Ii11xz Ii11yy Ii11yz Ii11zz]';
    phi2 =[m2 m2*Pc22(1) m2*Pc22(2) m2*Pc22(3) Ii22xx Ii22xy Ii22xz Ii22yy Ii22yz Ii22zz]';
    phi = [phi1;phi2];
    
    % 6x1 = 6x10 * 10x1 for A 
    A1 = zeros(6,10);A2 = zeros(6,10);
    A1(1:3,1) = dv11;A1(1:3,2:4) = s_alg(dw11)+s_alg(w11)*s_alg(w11);
    A1(4:6,2:4) = -s_alg(dv11);A1(4:6,5:10) = k_alg(dw11)+s_alg(w11)*k_alg(w11);
    
    A2(1:3,1) = dv22;A2(1:3,2:4) = s_alg(dw22)+s_alg(w22)*s_alg(w22);
    A2(4:6,2:4) = -s_alg(dv22);A2(4:6,5:10) = k_alg(dw22)+s_alg(w22)*k_alg(w22);
    
    % Q matrix Q = 6x6
    Q21 = [R12 zeros(3,3); s_alg(P12)*R12 R12];
    % merge for U
    U11 = A1; U12 = Q21*A2; U21 = zeros(6,10); U22 = A2;
    U_ori = [U11 U12; U21 U22];
    U = [U_ori(6,:);U_ori(12,:)];
    f = U_ori * phi;
    tao1 = f(6); tao2 = f(12);
end

function T = k_alg(w)
    wx = w(1); wy = w(2); wz = w(3);
    T = [wx wy wz 0 0 0;
         0  wx 0  wy wz 0;
         0  0  wx 0 wy wz];
end

function T = s_alg(w)
    wx = w(1); wy = w(2); wz = w(3);
    T = [0 -wz wy;
         wz 0 -wx;
         -wy wx 0];
end

