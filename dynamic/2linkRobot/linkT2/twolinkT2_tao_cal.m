function [tao1, tao2] = twolinkT2_tao_cal(q11,dq1,ddq1,q22,dq2,ddq2)
    % variables
    global g m1 m2 Ic11 Ic22 P01 P12 P23 Pc11 Pc22;
    % prepare rotation matrix
    R01 = hrotZ3x3(q11); R10 = R01';
    R12 = hrotZ3x3(q22); R21 = R12';
    R23 = hrotX3x3(-pi/2); R32 = R23';
    
    % from inner to out 0->2:
    w00 = [0;0;0]; dw00 = [0;0;0]; dv00 = [0;0;g];
    Zv = [0;0;1];
    % motion1
    w11 = R10*w00 + dq1*Zv;
    dw11 = R10*dw00 + cross(R10*w00,dq1*Zv) + ddq1*Zv;
    dv11 = R10*(cross(dw00,P01) + cross(w00,cross(w00,P01)) + dv00);
    dvc11 = cross(dw11,Pc11) + cross(w11,cross(w11,Pc11)) + dv11;
    % force1
    F11 = m1*dvc11;
    N11 = Ic11*dw11 + cross(w11,Ic11*w11);
    % motion2
    w22 = R21*w11 + dq2*Zv;
    dw22 = R21*dw11 + cross(R21*w11,dq2*Zv) + ddq2*Zv;
    dv22 = R21*(cross(dw11,P12) + cross(w11,cross(w11,P12)) + dv11);
    dvc22 = cross(dw22,Pc22) + cross(w22,cross(w22,Pc22)) + dv22;
    % force2
    F22 = m2*dvc22;
    N22 = Ic22*dw22 + cross(w22,Ic22*w22);
    
    %from outer to inner 2 -> 1
    f33 = [0;0;0]; n33 = [0;0;0];
    f22 = R23*f33 + F22;
    n22 = N22 + R23*n33 + cross(Pc22,F22) + cross(P23, R23*f33);
    tao2 = n22(3);
    f11 = R12*f22 + F11;
    n11 = N11 + R12*n22 + cross(Pc11,F11) + cross(P12, R12*f22);
    tao1 = n11(3);
    
end

