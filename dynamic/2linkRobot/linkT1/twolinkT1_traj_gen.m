clear;
clc;

global Ts pi g m1 m2 Izz1 Izz2 L1 L2;
Ts = 0.01;
pi = 3.1415926;
g = 9.81;

Izz1 = 0.208;
Izz2 = 1.0;

m1 = 2.409;
m2 = 1.0;
L1 = 1.0;
L2 = 2.0;

total_time = 10.0;
i = 1;
t = 0:Ts:total_time;

pos1 = 0.4*sin(t)*180.0/pi; vel1 = 0.4*cos(t)*180/pi; acc1 = -0.4*sin(t)*180/pi;
pos2 = 1.2*pos1; vel2 = 1.2*vel1; acc2 = 1.2*acc1;

q1 =[t', pos1']; dq1 = [t', vel1']; ddq1 = [t', acc1'];
q2 = [t',pos2']; dq2 = [t', vel2']; dqq2 = [t', acc2'];

[tao1,tao2] = pend2_ts3_cal_tao_(pos1,vel1,acc1,pos2,vel2,acc2);

figure(1);
plot(tao1);
figure(2);
plot(tao2);







