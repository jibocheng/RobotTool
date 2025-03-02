clear; clc; close all;
syms Pc11 Pc22;
syms xc11 yc11 zc11 xc22 yc22 zc22 real;
syms Pc01 Pc02;
syms vc01 vc02;
syms Ic11 Ic22;
syms Ic11xx Ic11yy Ic11zz real;
syms Ic11xy Ic11xz Ic11yz real;
syms Ic22xx Ic22yy Ic22zz real;
syms Ic22xy Ic22xz Ic22yz real;
syms q11 dq11 ddq11 real;
syms q22 dq22 ddq22 real;
syms m1 m2 real;
syms g real;
syms L0 L1 L2 real;

Pc11 = [xc11;yc11;zc11];
Pc22 = [xc22;yc22;zc22];
Ic11 = [Ic11xx -Ic11xy -Ic11xz;
        -Ic11xy Ic11yy -Ic11yz;
        -Ic11xz -Ic11yz Ic11zz];
Ic22 = [Ic22xx  -Ic22xy  -Ic22xz;
       -Ic22xy  Ic22yy  -Ic22yz;
       -Ic22xz -Ic22yz  Ic22zz];
T01 = hrotZ4x4(q11); 
T01(3,4) = L0;
T12 = [cos(q22) -sin(q22) 0 0;0 0 1 L1;-sin(q22) -cos(q22) 0 L0;0 0 0 1];
T21 = T12';
Pc01 = T01*[Pc11;1];
Pc01 = [Pc01(1);Pc01(2);Pc01(3)];
T02 = T01 * T12;
Pc02 = T02 * [Pc22;1];
Pc02 = [Pc02(1);Pc02(2);Pc02(3)];
R12 = T12(1:3,1:3);
R21 = R12';
w11 = [0;0;dq11]; 
w22 = R21*w11 + [0;0;dq22];
% center velocity
vc01 = jacobian(Pc01, [q11; q22]) * [dq11; dq22];
vc02 = jacobian(Pc02, [q11; q22]) * [dq11; dq22];
%transform_energy
k1_trans = 0.5 * m1 * vc01'*vc01;
k2_trans = 0.5 * m2 * vc02'*vc02;
%rotation_energy
k1_rot = 0.5*w11.'*Ic11*w11;
k2_rot = 0.5*w22.'*Ic22*w22;
% kinetic
k = k1_trans + k1_rot + k2_trans + k2_rot;
k = simplify(k);
% Potential energy
u1 = m1*[0;0;g]'*Pc01;
u2 = -m2*[0;0;g]'*Pc02; % £¿£¿£¿£¿£¿£¿
u = u1+u2;
u = simplify(u);

L = k - u;
L = simplify(L); 
dL_d_dq = jacobian(L,[dq11;dq22]);
d_dt_dL_d_dq = jacobian(dL_d_dq,[q11;q22])*[dq11;dq22]...
                + jacobian(dL_d_dq,[dq11;dq22])*[ddq11;ddq22];
dL_d_q = jacobian(L,[q11,q22]);
d_dt_dL_d_dq = simplify(d_dt_dL_d_dq);
dL_d_q = simplify(dL_d_q);
tao = d_dt_dL_d_dq - dL_d_q';
tao = simplify(tao);
disp('The expression of tao is');
disp(tao);