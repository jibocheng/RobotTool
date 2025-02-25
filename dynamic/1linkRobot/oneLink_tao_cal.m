function [tao1] = oneLink_tao_cal(q11,dq1,ddq1)
   % variables
    global g m1 Ic11 P01 P12 Pc11 Pc11_test;
    % prepare rotation matrix
    R01 = hrotZ3x3(q11); R10 = R01';
    R12 = hrotX3x3(-pi/2); R21 = R12';
    
    % from inner to out 0->1:
    w00 = [0;0;0]; dw00 = [0;0;0]; dv00 = [0;0;-g];
    Zv = [0;0;1];
    % motion1
    w11 = R10*w00 + dq1*Zv;
    dw11 = R10*dw00 + cross(R10*w00,dq1*Zv) + ddq1*Zv;
    dv11 = R10*(cross(dw00,P01) + cross(w00,cross(w00,P01)) + dv00);
    dvc11 = cross(dw11,Pc11) + cross(w11,cross(w11,Pc11)) + dv11;
    %dvc11 = cross(dw11,Pc11_test) + cross(w11,cross(w11,Pc11_test)) + dv11;
    % force1
    F11 = m1*dvc11;
    N11 = Ic11*dw11 + cross(w11,Ic11*w11);
    
    %from outer to inner 1  
    f22 = [0;0;0]; n22 = [0;0;0];
    f11 = R12*f22 + F11;
    n11 = N11 + R12*n22 + cross(Pc11,F11) + cross(P12, R12*f22);
    %n11 = N11 + R12*n22 + cross(Pc11_test,F11) + cross(P12, R12*f22);
    tao1 = n11(3);

end

