function [rotMatrix,vecRot] = axisAngleRotT(axis,angle,vec)
vec = [vec(1);vec(2);vec(3);0];
px = axis(1);
py = axis(2);
pz = axis(3);
angle = deg2rad(angle);
l = sqrt(px^2 + py ^2 + pz^2);
kx = px / l;
ky = py / l;
kz = pz / l;
s = sin(angle);
c = cos(angle);
v = 1 - c;
r = [kx^2*v,kx*ky*v-kz*s,kx*kz*v+ky*s,0;
     kx*ky*v+kz*s,ky*ky*v+c,ky*kz*v-kx*s,0;
     kx*kz*v-ky*s,ky*kz*v+kx*s,kz^2*v+c,0;
             0,0,0,1];
rotMatrix = [kx^2*v,kx*ky*v-kz*s,kx*kz*v+ky*s,px - px*r(1,1)-py*r(1,2)-pz*r(1,3);
             kx*ky*v+kz*s,ky*ky*v+c,ky*kz*v-kx*s,py - px*r(2,1)-py*r(2,2)-pz*r(2,3);
             kx*kz*v-ky*s,ky*kz*v+kx*s,kz^2*v+c,pz - px*r(3,1)-py*r(3,2)-pz*r(3,3);
             0,0,0,1];
vecRot = rotMatrix*vec;

end

