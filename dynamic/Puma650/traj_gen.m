%+---+-----------+-----------+-------+
%| j |theta | d | a | alpha | offset |
%+---+-----------+-----------+-------+
%|  1|     0|  0|0.0|    0.0|       0|
%|  2|     0| d2|0.0|    -90|       0|
%|  3|  -180|  0| a3|    0.0|       0|
%|  4|     0| d4|  0|    -90|       0|
%|  5|     0|  0|0.0|     90|       0|
%|  6|   180| d6|0.0|    -90|       0|
%+---+-----------+-----------+-------+

clear; clc; close all;
% Hardware 
global m1 m2 m3 m4 m5 m6;
global Pc11 Pc22 Pc33 Pc44 Pc55 Pc66;
global Ic11 Ic22 Ic33 Ic44 Ic55 Ic66;
global Ic11xx Ic11yy Ic11zz Ic11xy Ic11xz Ic11yz;
global Ic22xx Ic22yy Ic22zz Ic22xy Ic22xz Ic22yz;
global Ic33xx Ic33yy Ic33zz Ic33xy Ic33xz Ic33yz;
global Ic44xx Ic44yy Ic44zz Ic44xy Ic44xz Ic44yz;
global Ic55xx Ic55yy Ic55zz Ic55xy Ic55xz Ic55yz;
global Ic66xx Ic66yy Ic66zz Ic66xy Ic66xz Ic66yz; 
global Pc11x Pc11y Pc11z Pc22x Pc22y Pc22z Pc33x Pc33y Pc33z Pc44x Pc44y Pc44z Pc55x Pc55y Pc55z Pc66x Pc66y Pc66z;
global Ii11 Ii22 Ii33 Ii44 Ii55 Ii66;
global P001 P112 P223 P334 P445 P556 P667;
global g;
g = -9.8065;

m1 = 4.43412756;  m2 = 16.84660904;  m3 = 4.60251258;  m4 = 0.47079045; m5 = 0.07740646; m6 = 0.00343612;%m5 = 0.077;m4 = 0.471;m3 = 4.603;m2 = 16.847;m1 = 4.434;
Ic11xx = 27327.74254539/1e6;  Ic11xy = 0.01004954/1e6;        Ic11xz = -0.00779330/1e6;        Ic11yy = 13316.18396352/1e6;      Ic11yz = 278.53998863/1e6;       Ic11zz = 27164.17826539/1e6;
Ic22xx = 97229.72023998/1e6;  Ic22xy = 7.88590602/1e6;        Ic22xz = 4347.46076297/1e6;      Ic22yy = 596573.36974102/1e6;     Ic22yz = 48.38291302/1e6;        Ic22zz = 659758.11150989/1e6;
Ic33xx = 82615.26803540/1e6;  Ic33xy = -0.48370451/1e6;       Ic33xz = -0.36529045/1e6;        Ic33yy = 9191.62918392/1e6;       Ic33yz = -2.27394513/1e6;        Ic33zz = 87354.59533550/1e6;
Ic44xx = 772.88609433/1e6;    Ic44xy = 0.0;                   Ic44xz = 0.0;                    Ic44yy = 737.71865597/1e6;        Ic44yz = 0.0;                    Ic44zz = 466.83449961/1e6;
Ic55xx = 43.03191218/1e6;     Ic55xy = 0.00000113/1e6;        Ic55xz = -0.00001206/1e6;        Ic55yy = 16.96626524/1e6;         Ic55yz = 0.0;                    Ic55zz = 45.41353352/1e6;
Ic66xx = 0.16156936/1e6;      Ic66xy = -0.00000078/1e6;       Ic66xz = 0.00002638/1e6;         Ic66yy = 0.16156919/1e6;          Ic66yz = -0.00003322/1e6;        Ic66zz = 0.13635579/1e6;
Pc11x = 0.0;                  Pc11y = 22.50469351/1e3;        Pc11z = -2.79144309/1e3;
Pc22x = 82.73652456/1e3;      Pc22y = -0.04677543/1e3;        Pc22z = 75.58039753/1e3;
Pc33x = -0.00117880/1e3;      Pc33y = 88.77417776/1e3;        Pc33z = -10.15843771/1e3;
Pc44x = 0.00;                 Pc44y = 0.0;                    Pc44z = -32.40904555/1e3;
Pc55x = 0.00;                 Pc55y = 10.97413693/1e3;        Pc55z = 0.0;
Pc66x = -0.00143273/1e3;      Pc66y = 0.00162829/1e3;         Pc66z = -1.68591556/1e3;

Pc11 = [Pc11x;Pc11y;Pc11z];
Pc22 = [Pc22x;Pc22y;Pc22z];
Pc33 = [Pc33x;Pc33y;Pc33z];
Pc44 = [Pc44x;Pc44y;Pc44z];
Pc55 = [Pc55x;Pc55y;Pc55z];
Pc66 = [Pc66x;Pc66y;Pc66z];

Ic11=[Ic11xx -Ic11xy -Ic11xz;
 -Ic11xy Ic11yy -Ic11yz;
 -Ic11xz -Ic11yz Ic11zz];  

Ic22=[Ic22xx -Ic22xy -Ic22xz;
 -Ic22xy Ic22yy -Ic22yz;
 -Ic22xz -Ic22yz Ic22zz];

Ic33=[Ic33xx -Ic33xy -Ic33xz;
 -Ic33xy Ic33yy -Ic33yz;
 -Ic33xz -Ic33yz Ic33zz];   

Ic44=[Ic44xx -Ic44xy -Ic44xz;
 -Ic44xy Ic44yy -Ic44yz;
 -Ic44xz -Ic44yz Ic44zz];

Ic55=[Ic55xx -Ic55xy -Ic55xz;
 -Ic55xy Ic55yy -Ic55yz;
 -Ic55xz -Ic55yz Ic55zz];

Ic66=[Ic66xx -Ic66xy -Ic66xz;
 -Ic66xy Ic66yy -Ic66yz;
 -Ic66xz -Ic66yz Ic66zz];

I = eye(3);
Ii11 = Ic11 + m1*(Pc11'*Pc11*I - Pc11*Pc11');
Ii22 = Ic22 + m2*(Pc22'*Pc22*I - Pc22*Pc22');
Ii33 = Ic33 + m3*(Pc33'*Pc33*I - Pc33*Pc33');
Ii44 = Ic44 + m4*(Pc44'*Pc44*I - Pc44*Pc44');
Ii55 = Ic55 + m5*(Pc55'*Pc55*I - Pc55*Pc55');
Ii66 = Ic66 + m6*(Pc66'*Pc66*I - Pc66*Pc66');
% DH-parameters
global a3 d2 d4 d6;
d2 = 0.12954;
a3 = 0.4318;
d4 = 0.4337;
d6 = 0.05588;
P001 = [0;0;0];
P112 = [0;d2;0];
P223 = [a3;0;0];
P334 = [0;d4;0];
P445 = [0;0;0];
P556 = [0;d6;0];
P667 = [0;0;0];

global Ts;
Ts = 0.01;
total_time = 10.0;
t = 0:Ts:total_time;

%position for each joint
pos1 = 0.4*sin(t); vel1 = 0.4*sin(t+pi/2); acc1 = 0.4*sin(t+pi);
pos2 = 1.2*pos1; vel2 = 1.2*vel1; acc2 = 1.2*acc1;
pos3 = 0.5*pos1; vel3 = 0.5*vel1; acc3 = 0.5*acc1;
pos4 = 0.5*pos1; vel4 = 0.5*vel1; acc4 = 0.5*acc1;
pos5 = -2.0*pos1; vel5 = -2.0*vel1; acc5 = -2.0*acc1;
pos6 = 2.5*pos1; vel6 = 2.5*vel1; acc6 = 2.5*acc1;

q1 = [t',pos1']; dq1 = [t',vel1']; ddq1 = [t',acc1'];
q2 = [t',pos2']; dq2 = [t',vel2']; ddq2 = [t',acc2'];
q3 = [t',pos3']; dq3 = [t',vel3']; ddq3 = [t',acc3'];
q4 = [t',pos4']; dq4 = [t',vel4']; ddq4 = [t',acc4'];
q5 = [t',pos5']; dq5 = [t',vel5']; ddq5 = [t',acc5'];
q6 = [t',pos6']; dq6 = [t',vel6']; ddq6 = [t',acc6'];
