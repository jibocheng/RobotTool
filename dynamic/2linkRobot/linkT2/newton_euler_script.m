syms q11 dq11 ddq11 real;
syms q22 dq22 ddq22 real;
syms g real;
syms L0 L1 L2 real;
syms Pc11 Pc22;
syms xc11 yc11 zc11 xc22 yc22 zc22 real;
syms m1 m2 real;
syms Ic11 Ic22;
syms Ic11xx Ic11yy Ic11zz real;
syms Ic11xy Ic11xz Ic11yz real;
syms Ic22xx Ic22yy Ic22zz real;
syms Ic22xy Ic22xz Ic22yz real;

%gravity vector
Pc11 =[xc11;yc11;zc11]; Pc22 = [xc22;yc22;zc22];
Ic11 = [Ic11xx -Ic11xy -Ic11xz;
        -Ic11xy Ic11yy -Ic11yz;
        -Ic11xz -Ic11yz Ic11zz];
Ic22 = [Ic22xx  -Ic22xy  -Ic22xz;
       -Ic22xy  Ic22yy  -Ic22yz;
       -Ic22xz -Ic22yz  Ic22zz];
%rotation matrix
R01 = hrotZ3x3(q11); R10 = R01';
R12 = [cos(q22), -sin(q22), 0;0 0 1;-sin(q22) -cos(q22) 0]; R21 = R12';
R23 = [1 0 0; 0 0 -1; 0 1 0];

%transform vector
P01 = [0;0;L0];
P12 = [0;L1;0];
P23 = [0;-L2;0];

Zv = [0;0;1];
w00 = [0;0;0];dw00 = [0;0;0];v00=[0;0;0];dv00=[0;0;-g];
% inner to outer 0->2
% inner 0->1
w11 = R10 * w00 + dq11 * Zv;
dw11 = R10*dw00 + cross((R10*w00),(dq11*Zv)) + ddq11*Zv;
dv11 = R10*(cross(dw00,P01) + cross(w00,cross(w00,P01))+dv00);
dvc11 = cross(dw11,Pc11) + cross(w11,cross(w11,Pc11)) + dv11;
F11 = m1*dvc11;
N11 = Ic11 * dw11 + cross(w11,Ic11*w11);
% inner 1->2
w22 = R21 * w11 + dq22 * Zv;
dw22 = R21 * dw11 + cross(R21*w11,dq22*Zv) + ddq22*Zv;
dv22 = R21*(cross(dw11,P12) + cross(w11,cross(w11,P12)) + dv11);
dvc22 = cross(dw22,Pc22)+cross(w22,cross(w22,Pc22)) + dv22;
F22 = m2 * dvc22;
N22 = Ic22*dw22 + cross(w22,Ic22*w22);

%outer->inner 3->1
f33 = [0;0;0]; n33 = [0;0;0];
%3->2
f22 = R01*f33+F22;
n22 = N22 + R12*n33 + cross(Pc22,F22) + cross(P23,R12*f33);
%2->1
f11 = R12*f22 + F11;
n11 = N11 + R12*n22 + cross(Pc11,F11) + cross(P12,R12*f22);

tao1 = n11(3);
tao2 = n22(3);
tao1 = simplify(tao1);
tao2 = simplify(tao2);
disp('The Expression of tao1 is ');
disp(tao1);
disp('The Expression of tao2 is ');
disp(tao2);
