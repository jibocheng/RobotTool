clc;
clear;
% 输入测试向量
vec = [1, 0, 0]; % 初始向量
x = deg2rad(30); % 绕X轴旋转30度
y = deg2rad(45); % 绕Y轴旋转45度
z = deg2rad(-90); % 绕Z轴旋转60度

% 使用欧拉角旋转
[rotMatrix, vec_rot] = Euler('xyz', x, y, z, vec);

% 显示结果
disp('Rotation Matrix:');
disp(rotMatrix);

disp('Rotated Vector:');
disp(vec_rot');
