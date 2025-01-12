clc;clear;
alpha = [0, -90, 0, 0, 90, -90]; 
a = [0, 0, 425, 392, 0, 0];
d = [89.2, 0, 0, 109.3, 94.75, 82.5]; 
theta = [0, -90, 0, 90, 0, 0]; 

L1=Link('d',89.2,'a',0,'alpha',0,'modified');
L2=Link('d',0,'a',0,'alpha',-pi/2,'offset',-pi/2,'modified');
L3=Link('d',0,'a',425,'alpha',0,'modified');
L4=Link('d',109.3,'a',392,'alpha',0,'offset',pi/2,'modified');
L5=Link('d',94.75,'a',0,'alpha',pi/2,'modified');
L6=Link('d',82.5,'a',0,'alpha',-pi/2,'modified');
% ground truth 
robot=SerialLink([L1 L2 L3 L4 L5 L6],'name','UR5_simulation');
joint_value=[0,0,90,0,-90,-90];
delta = joint_value - theta;
delta = deg2rad(delta);
forward=robot.fkine(delta); 

W=[-1500,+1500,-1500,+1500,-1000,+1500];
robot.plot(joint_value,'tilesize',20,'workspace',W); 
robot.teach(forward,'rpy' )
disp('f_ground_truth')
%disp(forward);
J_v_gt = robot.jacob0(delta);
disp(J_v_gt);

%verify
vec_tool = [0;0;0];
%delta = joint_value - theta;
delta = [0;0;0;0;0;0];
[vec_base,fMatrix]=fk(6,alpha,a,d,joint_value,delta);
disp('predict:');
%disp(fMatrix);
joint_value = deg2rad(joint_value); alpha = deg2rad(alpha); 
Jv = get_Jv(alpha,a,d,joint_value);
disp(Jv);