function [rotMatrix,vec_rot] = axisAngleRot( rotAxis,theta,vec)
%AXISANGLEROT rotate around axis about angle
    kx = rotAxis(1) / norm(rotAxis);
    ky = rotAxis(2) / norm(rotAxis);
    kz = rotAxis(3) / norm(rotAxis);
    c = cos(theta);
    s = sin(theta);
    v = 1 - c;
    rotMatrix = [kx*kx*v + c, kx*ky*v-kz*s, kx*kz*v+ky*s;
                 kx*ky*v+kz*s,ky*ky*v+c,    ky*kz*v - kx*s;
                 kx*kz*v - ky*s, ky*kz*v+kx*s, kz*kz*v+c];

    vec = [vec(1);vec(2);vec(3)];
    vec_rot = rotMatrix * vec;
    
end

