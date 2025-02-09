function tao = new_town_dynamic(q, dq, ddq)
    global g m1 m2 m3 m4 m5 m6;
    global ic1 ic2 ic3 ic4 ic5 ic6;
    global Pc1 Pc2 Pc3 Pc4 Pc5 Pc6;
    global P01 P12 P23 P34 P45 P56 P67;
    q1 = q(1); q2 = q(2); q3= q(3); q4 = q(4); q5 = q(5); q6 = q(6);
    dq1 = dq(1); dq2 = dq(2); dq3 = dq(3); dq4 = dq(4); dq5 = dq(5); dq6 = dq(6);
    ddq1 = ddq(1); ddq2 = ddq(2); ddq3 = ddq(3); ddq4 = ddq(4); ddq5 = ddq(5); ddq6 = ddq(6);
    
    % define rot matrix and also transform
    R01 = hrotX3x3(q1); R10 = R01';
    R12 = hrotX3x3(pi/2)*hrotZ3x3(q2+pi/2); R21 = R12';
    R23 = hrotZ3x3(q3 - pi/2); R32 = R23';
    R34 = hrotX3x3(q4); R43 = R34';
    R45 = hrotX3x3(-pi/2)*hrotZ3x3(q5+pi/2); R54 = R45';
    R56 = hrotX3x3(pi/2)*hrotZ3x3(q6+pi); R65 = R56';
    % rotation axis for each coordinate
    Z11 = [0;0;1]; Z22 = [0;0;1]; Z33 = [0;0;1]; Z44 = [0;0;1]; Z55 = [0;0;1]; Z66 = [0;0;1];
    w00 = [0;0;0]; dw00 = [0;0;0]; v00 = [0;0;0]; dv00 = [0;0;g];
    % motion and force from 0->5
    [w11, dw11, dv11, dvc11] = cal_signal_motion(dq1,ddq1,w00,dw00,dv00,P01,Pc1,R10);
    [Fc11, Nc11] = cal_signal_FN(w11,dw11,dvc11,ic1,m1);
    [w22, dw22, dv22, dvc22] = cal_signal_motion(dq2,ddq2,w11,dw11,dv11,P12,Pc2,R21);
    [Fc22,Nc22] = cal_signal_FN(w22,dw22,dvc22,ic2,m2);
    [w33,dw33,dv33,dvc33] = cal_signal_motion(dq3,ddq3,w22,dw22,dv22,P23,Pc3,R32);
    [Fc33,Nc33] = cal_signal_FN(w33,dw33,dvc33,ic3,m3);
    [w44,dw44,dv44,dvc44] = cal_signal_motion(dq4,ddq4,w33,dw33,dv33,P34,Pc4,R43);
    [Fc44,Nc44] = cal_signal_FN(w44,dw44,dvc44,ic4,m4);
    [w55,dw55,dv55,dvc55] = cal_signal_motion(dq5,ddq5,w44,dw44,dv44,P45,Pc5,R54);
    [Fc55,Nc55] = cal_signal_FN(w55,dw55,dvc55,ic5,m5);
    [w66,dw66,dv66,dvc66] = cal_signal_motion(dq6,ddq6,w55,dw55,dv55,P56,Pc6,R65);
    [Fc66,Nc66] = cal_signal_FN(w66,dw66,dvc66,ic6,m6);
    %cal inner force 6->1
    R67 = eye(3);f77 = [0;0;0];n77=[0;0;0];
    [f66,n66] =  cal_signal_fn(f77,n77,Fc66,Nc66,P67,Pc6,R67);
    [f55,n55] =  cal_signal_fn(f66,n66,Fc55,Nc55,P56,Pc5,R56);
    [f44,n44] =  cal_signal_fn(f55,n55,Fc44,Nc44,P45,Pc4,R45);
    [f33,n33] =  cal_signal_fn(f44,n44,Fc33,Nc33,P34,Pc3,R34);
    [f22,n22] =  cal_signal_fn(f33,n33,Fc22,Nc22,P23,Pc2,R23);
    [f11,n11] =  cal_signal_fn(f22,n22,Fc11,Nc11,P12,Pc1,R12);
    % cal tao
    tao(1) = n11(3);
    tao(2) = n22(3);
    tao(3) = n33(3);
    tao(4) = n44(3);
    tao(5) = n55(3);
    tao(6) = n66(3);
    
end

function [w, dw, dv, dvc]= cal_signal_motion(dq, ddq, w_pre, dw_pre, dv_pre,P, Pc, R)
    w = R * w_pre + dq * [0;0;1];
    dw = R * dw_pre + cross(R*w_pre,dq*[0;0;1]) + ddq*[0;0;1];
    dv = R * (cross(dw_pre,P) + cross(w_pre,cross(w_pre,P) + dv_pre));
    dvc = cross(dw, Pc) + cross(w,cross(w,Pc))+dv;
end

function [Fc, Nc] = cal_signal_FN(w, dw, dvc, ic, m)
    Fc = m * dvc;
    N = ic * dw + cross(w,ic)*w;
end

function [f,n] = cal_signal_fn(f_next, n_next, F, N, P, Pc, R)
    f = R * f_next + F;
    n = N + R * n_next + cross(Pc,F) + cross(P,R*f);
end
