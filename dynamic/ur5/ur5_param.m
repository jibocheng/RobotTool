clc; clear; close all;
% set param that needed
global g m1 m2 m3 m4 m5 m6;
global ic1xx ic1xy ic1xz ic1yy ic1yz ic1zz ic2xx ic2xy ic2xz ic2yy ic2yz ic2zz ic3xx ic3xy ic3xz ic3yy ic3yz ic3zz;
global ic4xx ic4xy ic4xz ic4yy ic4yz ic4zz ic5xx ic5xy ic5xz ic5yy ic5yz ic5zz ic6xx ic6xy ic6xz ic6yy ic6yz ic6zz;
global ic1 ic2 ic3 ic4 ic5 ic6;
global Pc1 Pc2 Pc3 Pc4 Pc5 Pc6;
global P01 P12 P23 P34 P45 P56 P67;
global i1 i2 i3 i4 i5 i6;
% ur5 model
alpha = [0,-90,0,0,90,-90];
a = [0,0,0.425,0.392,0,0];
d = [0.0892,0,0,0.1093,0.09475,0.0825];
theta = [0,-90,0,90,0,0];
joint_value=[0,0,90,0,-90,-90];
delta = joint_value - theta;

% basic parameters:
g = 9.8065;
m1 = 4.43412756;  m2 = 16.84660904;  m3 = 4.60251258;  m4 = 0.47079045;m5 = 0.07740646;m6 = 0.00343612;
ic1xx = 27327.74254539/1e6;  ic1xy = 0.01004954/1e6;        ic1xz = -0.00779330/1e6;        ic1yy = 13316.18396352/1e6;      ic1yz = 278.53998863/1e6;       ic1zz = 27164.17826539/1e6;
ic2xx = 97229.72023998/1e6;  ic2xy = 7.88590602/1e6;        ic2xz = 4347.46076297/1e6;      ic2yy = 596573.36974102/1e6;     ic2yz = 48.38291302/1e6;        ic2zz = 659758.11150989/1e6;
ic3xx = 82615.26803540/1e6;  ic3xy = -0.48370451/1e6;       ic3xz = -0.36529045/1e6;        ic3yy = 9191.62918392/1e6;       ic3yz = -2.27394513/1e6;        ic3zz = 87354.59533550/1e6;
ic4xx = 772.88609433/1e6;    ic4xy = 0.0;                   ic4xz = 0.0;                    ic4yy = 737.71865597/1e6;        ic4yz = 0.0;                    ic4zz = 466.83449961/1e6;
ic5xx = 43.03191218/1e6;     ic5xy = 0.00000113/1e6;        ic5xz = -0.00001206/1e6;        ic5yy = 16.96626524/1e6;         ic5yz = 0.0;                    ic5zz = 45.41353352/1e6;
ic6xx = 0.16156936/1e6;      ic6xy = -0.00000078/1e6;       ic6xz = 0.00002638/1e6;         ic6yy = 0.16156919/1e6;          ic6yz = -0.00003322/1e6;        ic6zz = 0.13635579/1e6;

ic1 = [ 
        ic1xx -ic1xy -ic1xz;
        -ic1xy ic1yy -ic1yz;
        -ic1xz -ic1yz ic1zz;
    ];
ic2=[ic2xx -ic2xy -ic2xz;
 -ic2xy ic2yy -ic2yz;
 -ic2xz -ic2yz ic2zz];

ic3=[ic3xx -ic3xy -ic3xz;
 -ic3xy ic3yy -ic3yz;
 -ic3xz -ic3yz ic3zz];   

ic4=[ic4xx -ic4xy -ic4xz;
 -ic4xy ic4yy -ic4yz;
 -ic4xz -ic4yz ic4zz];


ic5=[ic5xx -ic5xy -ic5xz;
 -ic5xy ic5yy -ic5yz;
 -ic5xz -ic5yz ic5zz];

ic6=[ic6xx -ic6xy -ic6xz;
 -ic6xy ic6yy -ic6yz;
 -ic6xz -ic6yz ic6zz];

Pc1 = [0 0.0225 -0.0027914]';
Pc2 = [0.082736 -0.04677543/1e3 75.58039753/1e3]';
Pc3 = [-0.00117880/1e3 88.77417776/1e3 -10.15843771/1e3]';
Pc4 = [0 0 -32.40904555/1e3]';
Pc5 = [0 10.97413693/1e3 0.00]';
Pc6 = [-0.00143273/1e3 0.00162829/1e3 -1.68591556/1e3]';

I3 = eye(3);
i1 = ic1 + m1 * (Pc1'*Pc1*I3 - Pc1 * Pc1');
i2 = ic2 + m2 * (Pc2'*Pc2*I3 - Pc2 * Pc2');
i3 = ic3 + m3 * (Pc3'*Pc3*I3 - Pc3 * Pc3');
i4 = ic4 + m4 * (Pc4'*Pc4*I3 - Pc4 * Pc4');
i5 = ic5 + m5 * (Pc5'*Pc5*I3 - Pc5 * Pc5');
i6 = ic6 + m6 * (Pc6'*Pc6*I3 - Pc6 * Pc6');

% length diff for each link
P01 = [0;0;0.0892]; 
P12 = [0;0;0];
P23 = [0.425;0;0];
P34 = [0.392;0;0.1093];
P45 = [0;0.09475;0];
P56 = [0;-0.0825;0];
P67 = [0;0;0];


%trajectory generation
global Ts;
Ts = 0.01;
total_time = 10;
t = 0:Ts:total_time;
le = length(t);
zero = zeros(1,le);
format long g;
pos1 = 0.4*sin(t)*180.0/pi; vel1 = 0.4*sin(t+pi/2)*180.0/pi; acc1 = 0.4*sin(t+pi)*180.0/pi;
pos2 = 1.2*pos1; vel2 = 1.2*vel1; acc2 = 1.2*acc1;
pos3 = 1.5*pos1; vel3 = 1.5*vel1; acc3 = 1.5*acc1;
pos4 = 2.0*pos1; vel4 = 2.0*vel1; acc4 = 2.0*acc1;
pos5 = -2.0*pos1; vel5 = -2.0*vel1; acc5 = -2.0*acc1;
pos6 = 2.5*pos1; vel6 = 2.5*vel1; acc6 = 2.5*acc1;

q1 = [t',pos1']; dq1 = [t',vel1']; ddq1 = [t',acc1'];
q2 = [t',pos2']; dq2 = [t',vel2']; ddq2 = [t',acc2'];
q3 = [t',pos3']; dq3 = [t',vel3']; ddq3 = [t',acc3'];
q4 = [t',pos4']; dq4 = [t',vel4']; ddq4 = [t',acc4'];
q5 = [t',pos5']; dq5 = [t',vel5']; ddq5 = [t',acc5'];
q6 = [t',pos6']; dq6 = [t',vel6']; ddq6 = [t',acc6'];








