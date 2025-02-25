clear; clc; close all;

syms q11 dq1 ddq1; 
syms g;
syms m1;
syms x11 y11 z11;
syms L1;
syms Pc11 P12;
syms Ic11;
syms Ic11xx Ic11yy Ic11zz Ic11xy Ic11xz Ic11yz

Pc11 = [x11;y11;z11];
P01 = [0;0;0]; P12 = [0;L1;0];
Ic11 = [Ic11xx  -Ic11xy  -Ic11xz;
        -Ic11xy  Ic11yy  -Ic11yz;
        -Ic11xz -Ic11yz  Ic11zz];

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
    tao = simplify(tao1);
    disp('The expression of tao is:');
    disp(tao);