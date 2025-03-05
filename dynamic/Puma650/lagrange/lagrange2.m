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
syms g real;
syms q11 q22 q33 q44 q55 q66 real;
syms dq11 dq22 dq33 dq44 dq55 dq66 real;
syms ddq11 ddq22 ddq33 ddq44 ddq55 ddq66 real;

