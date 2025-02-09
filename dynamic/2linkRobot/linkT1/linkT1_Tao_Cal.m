function [tao1,tao2] = linkT1_Tao_Cal(q11,dq11,ddq11,q22,dq22,ddq22)
    global g m1 m2 Izz1 Izz2 L1 L2;
    for i = 1:1:1000
        s1 = sin(q11(i)*pi/180);
        s2 = sin(q22(i)*pi/180);
        c1 = cos(q11(i)*pi/180);
        c2 = cos(q22(i)*pi/180);
        dq1 = dq11(i)*pi/180;
        dq2 = dq22(i)*pi/180;
        ddq1 = ddq11(i)*pi/180;
        ddq2 = ddq22(i)*pi/180;
        
        tao2(i) = Izz2*(ddq1 + ddq2) + (L2*m2*(c2*(L1*ddq1 + c1*g) + (L2*(ddq1 + ddq2))/2 - s2*(- L1*dq1^2 + g*s1)))/2;
        tao1(i) = Izz1*ddq1 + L1*(m2*s2*(s2*(L1*ddq1 + c1*g) - (L2*(dq1 + dq2)^2)/2 + c2*(- L1*dq1^2 + g*s1)) + c2*m2*(c2*(L1*ddq1 + c1*g) + (L2*(ddq1 + ddq2))/2 - s2*(- L1*dq1^2 + g*s1))) + Izz2*(ddq1 + ddq2) + (L2*m2*(c2*(L1*ddq1 + c1*g) + (L2*(ddq1 + ddq2))/2 - s2*(- L1*dq1^2 + g*s1)))/2 + (L1*m1*((L1*ddq1)/2 + c1*g))/2;
    end
end

