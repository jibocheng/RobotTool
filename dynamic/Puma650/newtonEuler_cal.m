function [tao] = newtonEuler_cal(q,dq,ddq)
    global g m1 m2 m3 m4 m5 m6;
  	global Ic11 Ic22 Ic33 Ic44 Ic55 Ic66;
    global Pc11 Pc22 Pc33 Pc44 Pc55 Pc66;
    global P001 P112 P223 P334 P445 P556 P667;

    qq1 = q(1);
    qq2 = q(2);
    qq3 = q(3);
    qq4 = q(4);
    qq5 = q(5);
    qq6 = q(6);

    dqq1 = dq(1);
    dqq2 = dq(2);
    dqq3 = dq(3);
    dqq4 = dq(4);
    dqq5 = dq(5);
    dqq6 = dq(6);

    ddqq1 = ddq(1);
    ddqq2 = ddq(2);
    ddqq3 = ddq(3);
    ddqq4 = ddq(4);
    ddqq5 = ddq(5);
    ddqq6 = ddq(6);
    
    R01 = hrotZ3x3(qq1);                        R10 = R01';
    R12 = hrotX3x3(-90)*hrotZ3x3(qq2);          R21 = R12';
    R23 = hrotZ3x3(qq3-180);                    R32 = R23';
    R34 = hrotX3x3(-90)*hrotZ3x3(qq4);          R43 = R34';
    R45 = hrotX3x3(90)*hrotZ3x3(qq5);           R54 = R45';
    R56 = hrotX3x3(-90)*hrotZ3x3(qq6+180);      R65 = R56';


    Z111 = [0 0 1]'; Z222 = [0 0 1]'; Z333 = [0 0 1]'; Z444 = [0 0 1]'; Z555 = [0 0 1]'; Z666 = [0 0 1]'; 

    w00 = [0 0 0]';     dw00 = [0 0 0]';     v00 = [0 0 0]';    dv00 = [0 0 g]';

    %1->6.c
    [w11, dw11 ,dv11 ,dvc11]=cal_single_motion(R10,w00,dw00,dqq1,Z111,ddqq1,P001,dv00,Pc11);
    [F11,N11] = cal_single_FN(m1,dvc11,Ic11,dw11,w11);
    [w22, dw22 ,dv22 ,dvc22]=cal_single_motion(R21,w11,dw11,dqq2,Z222,ddqq2,P112,dv11,Pc22);
    [F22,N22] = cal_single_FN(m2,dvc22,Ic22,dw22,w22);
    [w33, dw33 ,dv33 ,dvc33]=cal_single_motion(R32,w22,dw22,dqq3,Z333,ddqq3,P223,dv22,Pc33);
    [F33,N33] = cal_single_FN(m3,dvc33,Ic33,dw33,w33);
    [w44, dw44 ,dv44 ,dvc44]=cal_single_motion(R43,w33,dw33,dqq4,Z444,ddqq4,P334,dv33,Pc44);
    [F44,N44] = cal_single_FN(m4,dvc44,Ic44,dw44,w44);
    [w55, dw55 ,dv55 ,dvc55]=cal_single_motion(R54,w44,dw44,dqq5,Z555,ddqq5,P445,dv44,Pc55);
    [F55,N55] = cal_single_FN(m5,dvc55,Ic55,dw55,w55);
    [w66, dw66 ,dv66 ,dvc66]=cal_single_motion(R65,w55,dw55,dqq6,Z666,ddqq6,P556,dv55,Pc66);
    [F66,N66] = cal_single_FN(m6,dvc66,Ic66,dw66,w66);

    %6->1
    R67 = eye(3);n77 = [0 0 0]';f77 = [0 0 0]';
   
    [f66,n66] = cal_single_fn(R67,f77,F66,N66,n77,Pc66,P667);
    [f55,n55] = cal_single_fn(R56,f66,F55,N55,n66,Pc55,P556);
    [f44,n44] = cal_single_fn(R45,f55,F44,N44,n55,Pc44,P445);
    [f33,n33] = cal_single_fn(R34,f44,F33,N33,n44,Pc33,P334);
    [f22,n22] = cal_single_fn(R23,f33,F22,N22,n33,Pc22,P223);
    [f11,n11] = cal_single_fn(R12,f22,F11,N11,n22,Pc11,P112);

    tao(1) = n11(3);
    tao(2) = n22(3);
    tao(3) = n33(3);
    tao(4) = n44(3);
    tao(5) = n55(3);
    tao(6) = n66(3);


end

function [w, dw ,dv ,dvc]=cal_single_motion(R,w0,dw0,dq,Z,ddq,P01,dv0,Pc)
    w = R*w0+dq*Z;
    dw = R*dw0+cross(R*w0,dq*Z)+ddq*Z;
    dv = R*(cross(dw0,P01)+cross(w0,cross(w0,P01))+dv0);
    dvc = cross(dw,Pc)+cross(w,cross(w,Pc))+dv;
end

function [F,N] = cal_single_FN(m,dvc,Ic,dw,w)
    F = m*dvc;
    N = Ic*dw+cross(w,Ic*w);
end

function [f,n] = cal_single_fn(R,f1,F1,N1,n2,Pc,P)
    f = R*f1 + F1;
    n = N1 + R*n2 + cross(Pc,F1) +cross (P,R*f1) ;
end