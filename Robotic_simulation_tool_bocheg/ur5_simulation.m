clc;clear all; close all;
startup
%UR5 simulation:
alpha = [0,-90,0,0,90,-90];
a = [0,0,425,392,0,0];
d = [89.2,0,0,109.3,94.75,82.5];
theta = [0,-90,0,90,0,0];
joint_value = [0,80,120,40,45,10];
delta = joint_value - theta;
nLinks = 6;
vec_tool = [0;0;0];
robot = Robot('ur5',6,alpha, a, d, theta,delta,vec_tool);
robot.forwardkinematics(delta);
robot.build();
robot.inversekinematics();
