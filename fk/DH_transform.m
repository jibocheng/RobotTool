function T = DH_transform(alpha, a, d, theta,delta)
    T = [cos(theta+delta), -sin(theta+delta)*cos(alpha), sin(theta+delta)*sin(alpha), a*cos(theta+delta);
         sin(theta+delta), cos(theta+delta)*cos(alpha), -cos(theta+delta)*sin(alpha), a*sin(theta+delta);
         0, sin(alpha), cos(alpha), d;
         0, 0, 0, 1];
end