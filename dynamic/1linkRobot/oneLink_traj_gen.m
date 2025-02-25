clear; clc;
global Ts pi g L1 m1 Ic11 P01 P12 Pc11 Pc11_test;
global Ic11_m Ic11_p;
global Ii11;

Ts = 0.01;
pi = 3.1415926;
g = 9.80665;
m1 = 12.65615427;
L1 = 1;

Ic11 = [ 77887.93599651e-6, -0.00013107e-6, 0.00000935e-6;
			-0.00013107e-6, 38765.56757892e-6, -1024.13710067e-6;
			0.00000935e-6, -1024.13710067e-6, 76421.19395059e-6 ];
      
Ic11_m = [Ic11(1,1) Ic11(2,2) Ic11(3,3)]';
Ic11_p = [Ic11(1,2) Ic11(1,3) Ic11(2,3)]';
          
P01 = [0;0;0]; P12 = [0;L1;0]; P23 = [0;1;0];

Pc11 = [ 0;18.97808196e-3;-4.26387031e-3 ];

%Pc11_test = [0;0.5;0];
Pc11_gen2 = [Pc11(1) -Pc11(3) Pc11(2)-0.5];


Ii11 = Ic11 + m1 * (Pc11'*Pc11*eye(3) - Pc11*Pc11');

total_time = 10.0;
i = 1;
t = 0:Ts:total_time;

pos1 = 0.8*sin(t); vel1 = 0.8*sin(t+pi/2); acc1 = 0.8*sin(t+pi);

q1 = [t',deg2rad(pos1)']; dq1 = [t',deg2rad(vel1)']; ddq1 = [t',deg2rad(acc1)'];