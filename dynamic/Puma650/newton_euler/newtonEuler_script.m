clear;clc;close all;
% all the needed parameters for both newton-euler and lagrange
syms m1 m2 m3 m4 m5 m6 real;
syms Pc11 Pc22 Pc33 Pc44 Pc55 Pc66;
syms Pc11x Pc11y Pc11z Pc22x Pc22y Pc22z Pc33x Pc33y Pc33z Pc44x Pc44y Pc44z Pc55x Pc55y Pc55z Pc66x Pc66y Pc66z real;
Pc11 = [Pc11x;Pc11y;Pc11z]; Pc22 = [Pc22x;Pc22y;Pc22z];Pc33 = [Pc33x;Pc33y;Pc33z];Pc44 = [Pc44x;Pc44y;Pc44z];Pc55 = [Pc55x;Pc55y;Pc55z];Pc66 = [Pc66x;Pc66y;Pc66z];
syms Ic11 Ic22 Ic33 Ic44 Ic55 Ic66;
syms Ic11xx Ic11yy Ic11zz Ic11xy Ic11xz Ic11yz real;
syms Ic22xx Ic22yy Ic22zz Ic22xy Ic22xz Ic22yz real;
syms Ic33xx Ic33yy Ic33zz Ic33xy Ic33xz Ic33yz real;
syms Ic44xx Ic44yy Ic44zz Ic44xy Ic44xz Ic44yz real;
syms Ic55xx Ic55yy Ic55zz Ic55xy Ic55xz Ic55yz real;
syms Ic66xx Ic66yy Ic66zz Ic66xy Ic66xz Ic66yz real;
Ic11 = [Ic11xx -Ic11xy -Ic11xz; -Ic11xy Ic11yy -Ic11yz; -Ic11xz -Ic11yz Ic11zz];
Ic22 = [Ic22xx -Ic22xy -Ic22xz; -Ic22xy Ic22yy -Ic22yz; -Ic22xz -Ic22yz Ic22zz];
Ic33 = [Ic33xx -Ic33xy -Ic33xz; -Ic33xy Ic33yy -Ic33yz; -Ic33xz -Ic33yz Ic33zz];
Ic44 = [Ic44xx -Ic44xy -Ic44xz; -Ic44xy Ic44yy -Ic44yz; -Ic44xz -Ic44yz Ic44zz];
Ic55 = [Ic55xx -Ic55xy -Ic55xz; -Ic55xy Ic55yy -Ic55yz; -Ic55xz -Ic55yz Ic55zz];
Ic66 = [Ic66xx -Ic66xy -Ic66xz; -Ic66xy Ic66yy -Ic66yz; -Ic66xz -Ic66yz Ic66zz];
syms P001 P112 P223 P334 P445 P556 P667;
syms a3 d2 d4 d6 real;
P001 = [0 0 0]';P112 = [0 d2 0]';P223 = [a3 0 0]';P334 = [0 d4 0]';P445 = [0 0 0]';P556 = [0 d6 0]'; P667 = [0 0 0]';
syms g;
syms q11 q22 q33 q44 q55 q66 real;
syms dq11 dq22 dq33 dq44 dq55 dq66 real;
syms ddq11 ddq22 ddq33 ddq44 ddq55 ddq66 real;
% rotation matrix for newton-euler 
% R01 = hrotZ3x3(q11); R12 = hrotX3x3(-pi/2)*hrotZ3x3(q22); R23 = hrotZ3x3(-pi)*hrotZ3x3(q33);
% R34 = hrotX3x3(-pi/2)*hrotZ3x3(q44);R45 = hrotX3x3(pi/2)*hrotZ3x3(q55);R56 = hrotX3x3(-pi/2)*hrotZ3x3(pi)*hrotZ3x3(q66);
R01 = [ cos(q11) -sin(q11) 0; 
        sin(q11) cos(q11) 0; 
        0 0 1 ];
R12 = [cos(q22) -sin(q22) 0;
       0 0 1;
       -sin(q22) -cos(q22) 0];
R23 = [-cos(q33) sin(q33) 0;
    -sin(q33) -cos(q33) 0;
    0 0 1];
R34 = [cos(q44) -sin(q44) 0;
       0 0 1;
       -sin(q44) -cos(q44) 0];
R45 = [cos(q55) -sin(q55) 0;
       0 0 -1;
       sin(q55) cos(q55) 0];
R56 = [cos(q66) -sin(q66) 0;
        0 0 1;
        -sin(q66) -cos(q66) 0];
R67 = eye(3);
R10 = R01'; R21=R12; R32=R23'; R43=R34'; R54=R45'; R65=R56';

Zv = [0 0 1]';

w00 = [0;0;0];dw00=[0;0;0];dv00 = [0;0;g];dvc00 = [0;0;0];
% inner to outer 0->5
w11 = R10 * w00 + dq11 * Zv;
dw11 = R10 * dw00 + cross(R10*w00,dq11*Zv)+ddq11*Zv;
dv11 = R10 * (cross(dw00,P001) + cross(w00,cross(w00,P001)) + dv00);
dvc11 = cross(dw11,Pc11) + cross(w11,cross(w11,Pc11)) + dv11;
F11 = m1 * dvc11;
N11 = Ic11*dw11 + cross(w11,Ic11*w11);

w22 = R21 * w11 + dq22 * Zv;
dw22 = R21 * dw11 + cross(R21*w11,dq22*Zv)+ddq22*Zv;
dv22 = R21 * (cross(dw11,P112) + cross(w11,cross(w11,P112)) + dv11);
dvc22 = cross(dw22,Pc22) + cross(w22,cross(w22,Pc22)) + dv22;
F22 = m2 * dvc22;
N22 = Ic22*dw22 + cross(w22,Ic22*w22);

w33 = R32 * w22 + dq33 * Zv;
dw33 = R32 * dw22 + cross(R32*w22,dq33*Zv)+ddq33*Zv;
dv33 = R32 * (cross(dw22,P223) + cross(w22,cross(w22,P223)) + dv22);
dvc33 = cross(dw33,Pc33) + cross(w33,cross(w33,Pc33)) + dv33;
F33 = m3 * dvc33;
N33 = Ic33*dw33 + cross(w33,Ic33*w33);

w44 = R43 * w33 + dq44 * Zv;
dw44 = R43 * dw33 + cross(R43*w33,dq44*Zv)+ddq44*Zv;
dv44 = R43 * (cross(dw33,P334) + cross(w33,cross(w33,P334)) + dv33);
dvc44 = cross(dw44,Pc44) + cross(w44,cross(w44,Pc44)) + dv44;
F44 = m4 * dvc44;
N44 = Ic44 * dw44 + cross(w44,Ic44*w44);

w55 = R54 * w44 + dq55 * Zv;
dw55 = R54 * dw44 + cross(R54*w44,dq55*Zv)+ddq55*Zv;
dv55 = R45 * (cross(dw44,P445) + cross(w44,cross(w44,P445)) + dv44);
dvc55 = cross(dw55,Pc55) + cross(w55,cross(w55,Pc55)) + dv55;
F55 = m5 * dvc55;
N55 = Ic55 * dw55 + cross(w55,Ic55*w55);

w66 = R65 * w55 + dq66 * Zv;
dw66 = R65 * dw55 + cross(R65*w55,dq66*Zv)+ddq66*Zv;
dv66 = R65 * (cross(dw55,P556) + cross(w55,cross(w55,P556)) + dv55);
dvc66 = cross(dw66,Pc66) + cross(w66,cross(w66,Pc66)) + dv66;
F66 = m6 * dvc66;
N66 = Ic66 * dw66 + cross(w66,Ic66*w66);

%outer to inner 6->1
f77 = [0;0;0]; n77 = [0;0;0]; 

f66 = R67 * f77 + F66;
n66 = N66 + R67 * n77 + cross(Pc66,F66) + cross(P667,R67*f77);
tao6 = n66(3);
%tao6 = simplify(tao6);
disp('tao6 is : ')
disp(tao6);

f55 = R56 * f66 + F55;
n55 = N55 + R56 * n66 + cross(Pc55,F55) + cross(P556, R56 * f66);
tao5 = n55(3);
%tao5 = simplify(tao5);
disp('tao5 is : ')
disp(tao5);

f44 = R45 * f55 + F44;
n44 = N44 + R45 * n55 + cross(Pc44,F44) + cross(P445, R45 * f55);
tao4 = n44(3);
%tao4 = simplify(tao4);
disp('tao4 is : ')
disp(tao4);

f33 = R34 * f44 + F33;
n33 = N33 + R34 * n44 + cross(Pc33,F33) + cross(P334, R34 * f44);
tao3 = n33(3);
%tao3 = simplify(tao3);
disp('tao3 is : ')
disp(tao3);

f22 = R23 * f33 + F22;
n22 = N22 + R23 * n33 + cross(Pc22,F22) + cross(P223, R23 * f33);
tao2 = n22(3);
%tao2 = simplify(tao2);
disp('tao2 is : ')
disp(tao2);

f11 = R12 * f22 + F11;
n11 = N11 + R12 * n22 + cross(Pc11,F11) + cross(P112, R12 * f22);
tao1 = n11(3);
%tao1 = simplify(tao1);
disp('tao1 is : ')
disp(tao1);




