clc;
clear;
close all;
startup
alpha = [0, -90, 0, 0, 90, -90]; 
a = [0, 0, 425, 392, 0, 0];
d = [89.2, 0, 0, 109.3, 94.75, 82.5]; 
theta = [0, -90, 0, 90, 0, 0]; 
% modified forward kinematic
L1 = Link('d', d(1), 'a', a(1), 'alpha', deg2rad(alpha(1)), 'modified');
L2 = Link('d', d(2), 'a', a(2), 'alpha', deg2rad(alpha(2)), 'modified');
L3 = Link('d', d(3), 'a', a(3), 'alpha', deg2rad(alpha(3)), 'modified');
L4 = Link('d', d(4), 'a', a(4), 'alpha', deg2rad(alpha(4)), 'modified');
L5 = Link('d', d(5), 'a', a(5), 'alpha', deg2rad(alpha(5)), 'modified');
L6 = Link('d', d(6), 'a', a(6), 'alpha', deg2rad(alpha(6)), 'modified');

UR5 = SerialLink([L1, L2, L3, L4, L5, L6], 'name', 'UR5');
q = deg2rad([0, -90, 0, 90, 0, 0]); 
figure;
UR5.plot(q, 'workspace', [-1000, 1000, -1000, 1000, -1000, 1500]);
UR5.display();
UR5.teach();
hold on;
grid on;
T_fk = UR5.fkine(q);
disp('UR5末端变换矩阵:');
disp(T_fk);
% verify my forward kinematic
vec_tool = [0; 0; 0];
joint_value = [0,80,120,40,45,10];
delta = joint_value - theta;
[vec_base, matrix_fk] = fk(6, alpha, a, d, theta, delta, vec_tool); 
disp('验证正运动矩阵:');
disp(matrix_fk);
disp(vec_base); 
%verify my inverse kinematic
[q] = ur_ik(alpha, a, d, theta, joint_value,matrix_fk)
