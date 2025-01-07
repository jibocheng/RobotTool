function [RX, RY, RZ] = rot2rpy(Rot)

if abs(Rot(3 ,1) - 1.0) < 1.0e-15  
    RX = 0.0;
    RY = -pi / 2.0;
    RZ = atan2(-Rot(1, 2), -Rot(1, 3));
elseif abs(Rot(3, 1) + 1.0) < 1.0e-15  
    RX = 0.0;
    RY = pi / 2.0;
    RZ = -atan2(Rot(1, 2), Rot(1, 3));
else
    RX = atan2(Rot(3, 2), Rot(3, 3));
    RZ = atan2(Rot(2, 1), Rot(1, 1));
    cosRZ = cos(RZ);
    sinRZ = sin(RZ);
    
    if abs(cosRZ) > abs(sinRZ)
        RY = atan2(-Rot(3, 1), Rot(1, 1) / cosRZ);
    else
        RY = atan2(-Rot(3, 1), Rot(2, 1) / sinRZ);
    end
end

end

