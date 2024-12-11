clear,clc,close all;
%% 建立机器人DH参数，初始状态为竖直状态
L1=Link('d',144,'a',0,'alpha',0,'modified');
L2=Link('d',0,'a',0,'alpha',pi/2,'offset',pi/2,'modified');
L3=Link('d',0,'a',264,'alpha',0,'modified');
L4=Link('d',106,'a',236,'alpha',0,'offset',pi/2,'modified');
L5=Link('d',114,'a',0,'alpha',pi/2,'modified');
L6=Link('d',67,'a',0,'alpha',-pi/2,'modified');
 
robot=SerialLink([L1 L2 L3 L4 L5 L6],'name','UR5_simulation');
Theta=[0 0 0 0 0 0];
Theta=Theta/180*pi; 
forward=robot.fkine(Theta) 
W=[-1000,+1000,-1000,+1000,-1000,+1000];
robot.plot(Theta,'tilesize',150,'workspace',W); 
robot.teach(forward,'rpy' )