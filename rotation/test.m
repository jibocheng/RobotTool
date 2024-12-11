clc;
clear;
% �����������
vec = [1, 0, 0]; % ��ʼ����
x = deg2rad(30); % ��X����ת30��
y = deg2rad(45); % ��Y����ת45��
z = deg2rad(-90); % ��Z����ת60��

% ʹ��ŷ������ת
[rotMatrix, vec_rot] = Euler('xyz', x, y, z, vec);

% ��ʾ���
disp('Rotation Matrix:');
disp(rotMatrix);

disp('Rotated Vector:');
disp(vec_rot');
