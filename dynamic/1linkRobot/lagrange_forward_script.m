clear; clc; close all;
syms m1 q11 dq11 ddq11 real   
syms Ic11xx Ic11yy Ic11zz Ic11xy Ic11xz Ic11yz real
syms xc11 yc11 zc11 g real

R01 = [cos(q11) -sin(q11) 0;      
       sin(q11)  cos(q11) 0;
       0         0        1];
Pc11 = [xc11; yc11; zc11];        
Pc01 = R01 * Pc11;                 

Vc01 = jacobian(Pc01, q11) * dq11; 
w11 = [0; 0; dq11];              

Ic11 = [Ic11xx  -Ic11xy  -Ic11xz;
       -Ic11xy  Ic11yy  -Ic11yz;
       -Ic11xz -Ic11yz  Ic11zz];
R01_Ic11_R01T = R01 * Ic11 * R01.'; 


k1_trans = 0.5 * m1 * (Vc01.' * Vc01);
k1_rot = 0.5 * w11.' * R01_Ic11_R01T * w11;
k1 = simplify(k1_trans + k1_rot);


u = -m1 * g * Pc01(3); 

L = k1 - u;

partial_L_partial_dq11 = diff(L, dq11); 

d_partial_L_partial_dq11_dt = diff(partial_L_partial_dq11, q11)*dq11 + ...
                              diff(partial_L_partial_dq11, dq11)*ddq11;

partial_L_partial_q11 = diff(L, q11);

tao = simplify(d_partial_L_partial_dq11_dt - partial_L_partial_q11);
disp('The lagramge Expression of tao:');
disp(tao)