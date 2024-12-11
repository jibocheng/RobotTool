%preparation
clc;
clear;
%variable definition
theta = pi / 6;
c = cos(theta);
s = sin(theta);
v = 1 - c;
kx = 0.707;
ky = 0.707;
kz = 0;
%matrix definition
T1_1n = [1,0,0,1;
         0,1,0,2;
         0,0,1,3;
         0,0,0,1];
     
T2n_2 = [1,0,0,-1;
         0,1,0,-2;
         0,0,1,-3;
         0,0,0,1];
     
T1n_2n = [kx*kx*v+c,kx*ky*v-kz*s,kx*kz*v+ky*s,0;
          kx*ky*v+kz*s,ky*ky*v+c,ky*kz*v-kx*s,0;
          kx*kz*v-ky*s,ky*kz*v+kx*s,kz*kz*v+c,0;
          0,           0,           0,        1];
      
T1_2 = T1_1n * T1n_2n * T2n_2;