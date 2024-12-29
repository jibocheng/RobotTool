function T = DH_transform(alpha, a, d, theta,delta)
belta = theta + delta;    
T = [    cos(belta), -sin(belta), 0, a;
         sin(belta)*cos(alpha), cos(belta)*cos(alpha), -sin(alpha), -sin(alpha)*d;
         sin(belta)*sin(alpha), cos(belta)*sin(alpha), cos(alpha), cos(alpha)*d;
         0, 0, 0, 1];
end