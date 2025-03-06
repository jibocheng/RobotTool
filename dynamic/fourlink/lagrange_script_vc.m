clear;clc;close all;
% all the needed parameters for both newton-euler and lagrange
syms m1 m2 m3 m4 real;
syms Pc11 Pc22 Pc33 Pc44;
syms Pc11x Pc11y Pc11z Pc22x Pc22y Pc22z Pc33x Pc33y Pc33z Pc44x Pc44y Pc44z real;
Pc11 = [Pc11x;Pc11y;Pc11z]; Pc22 = [Pc22x;Pc22y;Pc22z];Pc33 = [Pc33x;Pc33y;Pc33z];Pc44 = [Pc44x;Pc44y;Pc44z];
syms Ic11 Ic22 Ic33 Ic44;
syms Ic11xx Ic11yy Ic11zz Ic11xy Ic11xz Ic11yz real;
syms Ic22xx Ic22yy Ic22zz Ic22xy Ic22xz Ic22yz real;
syms Ic33xx Ic33yy Ic33zz Ic33xy Ic33xz Ic33yz real;
syms Ic44xx Ic44yy Ic44zz Ic44xy Ic44xz Ic44yz real;
Ic11 = [Ic11xx -Ic11xy -Ic11xz; -Ic11xy Ic11yy -Ic11yz; -Ic11xz -Ic11yz Ic11zz];
Ic22 = [Ic22xx -Ic22xy -Ic22xz; -Ic22xy Ic22yy -Ic22yz; -Ic22xz -Ic22yz Ic22zz];
Ic33 = [Ic33xx -Ic33xy -Ic33xz; -Ic33xy Ic33yy -Ic33yz; -Ic33xz -Ic33yz Ic33zz];
Ic44 = [Ic44xx -Ic44xy -Ic44xz; -Ic44xy Ic44yy -Ic44yz; -Ic44xz -Ic44yz Ic44zz];
syms P001 P112 P223 P334 P445;
syms a3 d2 d4 real;
P001 = [0 0 0]';P112 = [0 d2 0]';P223 = [a3 0 0]';P334 = [0 d4 0]';P445 = [0 0 0]';
syms g real;
syms q11 q22 q33 q44 real;
syms dq11 dq22 dq33 dq44 real;
syms ddq11 ddq22 ddq33 ddq44 real;

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
% R56 = [-cos(q66) sin(q66) 0;
%         0 0 1;
%         sin(q66) cos(q66) 0];
R45 = eye(3);
R10 = R01'; R21=R12'; R32=R23'; R43=R34';;
Zv = [0 0 1]';

T01 = [ cos(q11) -sin(q11) 0 P001(1); 
        sin(q11) cos(q11) 0 P001(2); 
        0 0 1 P001(3);
        0 0 0 1];
Pc01 = T01 * [Pc11;1];

T12 = [cos(q22) -sin(q22) 0 P112(1);
       0 0 1 P112(2);
       -sin(q22) -cos(q22) 0 P112(3);
       0 0 0 1];
T02 = T01 * T12;
Pc02 = T02 * [Pc22;1];

T23 = [-cos(q33) sin(q33) 0 P223(1);
    -sin(q33) -cos(q33) 0 P223(2);
    0 0 1 P223(3);
    0 0 0 1];
T03 = T01 * T12 *T23;
Pc03 = T03 * [Pc33;1];

T34 = [cos(q44) -sin(q44) 0 P334(1);
       0 0 1 P334(2);
       -sin(q44) -cos(q44) 0 P334(3);
       0 0 0 1];
T04 = T01 * T12 * T23 * T34;
Pc04 = T04 * [Pc44;1];

Pc01 = [Pc01(1);Pc01(2);Pc01(3)];
Pc02 = [Pc02(1);Pc02(2);Pc02(3)];
Pc03 = [Pc03(1);Pc03(2);Pc03(3)];
Pc04 = [Pc04(1);Pc04(2);Pc04(3)];

disp('Pc01:');
disp(Pc01);
disp('Pc02:');
disp(Pc02);
disp('Pc03:');
disp(Pc03);
disp('Pc04:');
disp(Pc04);


Vc01 = jacobian(Pc01,q11)*dq11; 
Vc02 = jacobian(Pc02,q11)*dq11 + jacobian(Pc02,q22)*dq22;
Vc03 = jacobian(Pc03,q11)*dq11 + jacobian(Pc03,q22)*dq22 + jacobian(Pc03,q33)*dq33;
Vc04 = jacobian(Pc04,q11)*dq11 + jacobian(Pc04,q22)*dq22 + jacobian(Pc04,q33)*dq33 + jacobian(Pc04,q44)*dq44;

Vc01 = simplify(Vc01);
Vc02 = simplify(Vc02);
Vc03 = simplify(Vc03);
Vc04 = simplify(Vc04);

Vc01 = [Vc01(1);Vc01(2);Vc01(3)];
Vc02 = [Vc02(1);Vc02(2);Vc02(3)];
Vc03 = [Vc03(1);Vc03(2);Vc03(3)];
Vc04 = [Vc04(1);Vc04(2);Vc04(3)];

disp('Vc01');
disp(Vc01);
disp('Vc02');
disp(Vc02);
disp('Vc03');
disp(Vc03);
disp('Vc04');
disp(Vc04);

w11 = [0;0;dq11]; 
w22 = R21 * w11 + dq22 * Zv;
w33 = R32 * w22 + dq33 * Zv;
w44 = R43 * w33 + dq44 * Zv;

k1 = 0.5 * m1 * Vc01'*Vc01 + 0.5 * w11'*Ic11*w11;
k2 = 0.5 * m2 * Vc02'*Vc02 + 0.5 * w22'*Ic22*w22;
k3 = 0.5 * m3 * Vc03'*Vc03 + 0.5 * w33'*Ic33*w33;
k4 = 0.5 * m4 * Vc04'*Vc04 + 0.5 * w44'*Ic44*w44;

%k1 = simplify(k1);
disp('k1 is ');
disp(k1);
%k2 = simplify(k2);
disp('k2 is ');
disp(k2);
%k3 = simplify(k3);
disp('k3 is ');
disp(k3);
%k4 = simplify(k4);
disp('k4 is ');
disp(k4);

k = k1 + k2 + k3 + k4;
disp('k is ');
disp(k);

% potential energy
G = [0;0;g];
u1 = m1 * G'*Pc01;
disp('u1 is ');
disp(u1);
u2 = m2 * G'*Pc02;
disp('u2 is ');
disp(u2);
u3 = m3 * G'*Pc03;
disp('u3 is ');
disp(u3);
u4 = m4 * G'*Pc04;
disp('u4 is ');
disp(u4);

u = u1 + u2 + u3 + u4;

%lagrange function
L = k - u;
dL_d_dq = jacobian(L,[dq11;dq22;dq33;dq44]);
d_dL_d_dq_dt = jacobian(dL_d_dq,[q11;q22;q33;q44])*[dq11;dq22;dq33;dq44;]...
               + jacobian(dL_d_dq,[dq11;dq22;dq33;dq44])*[ddq11;ddq22;ddq33;ddq44];
dL_d_q = jacobian(L,[q11;q22;q33;q44]);

tao = d_dL_d_dq_dt - dL_d_q';
%tao = simplify(tao);
disp('The expression of tao is ');
disp(tao);

fileID = fopen('Parameters recording.txt', 'w');
fprintf(fileID, 'The expression of tao1 is:\n');
fprintf(fileID, '%s\n', char(tao(1)));
fprintf(fileID, 'The expression of tao2 is:\n');
fprintf(fileID, '%s\n', char(tao(2)));
fprintf(fileID, 'The expression of tao3 is:\n');
fprintf(fileID, '%s\n', char(tao(3)));
fprintf(fileID, 'The expression of tao4 is:\n');
fprintf(fileID, '%s\n', char(tao(4)));
