classdef DH
    % DH parameters
    % alpha
    % a
    % d
    % theta
    % offset
    properties
    alpha0;alpha1;alpha2;alpha3;alpha4;alpha5;
    a0;a1;a2;a3;a4;a5;
    d1;d2;d3;d4;d5;d6;
    theta1;theta2;theta3;theta4;theta5;theta6;
    end
    
    methods
        function obj = DH(alpha,a,d,theta)
            alpha0 = alpha(1);alpha1 = alpha(2);alpha2=alpha(3);alpha3=alpha(4);alpha4=alpha(5);alpha5=alpha(6);
            a0 = a(1);a1=a(2);a2=a(3);a3=a(4);a4=a(5);a5=a(6);
            d1=d(1);d2=d(2);d3=d(3);d4=d(4);d5=d(5);d6=d(6);
            theta1=theta(1);theta2=theta(2);theta3=theta(3);theta4=theta(4);theta5=theta(5);theta6=theta(6);
            
        end
    end
    
end

