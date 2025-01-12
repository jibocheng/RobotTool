function vec= htr2xyz(T)
  x = T(1,4);
  y = T(2,4);
  z = T(3,4);
  
  if abs(T(3,3)) < eps && abs(T(2,3)) < eps
      Angle(1) = 0;
      Angle(2) = atan2(T(1,3), T(3,3));
      Angle(3) = atan2(T(2,1), T(2,2));
  else
      Angle(1) = atan2(-T(2,3), T(3,3));
      sr = sin(Angle(1));
      cr = cos(Angle(1));
      Angle(2) = atan2(T(1,3), cr * T(3,3) - sr * T(2,3));  % pitch
      Angle(3) = atan2(-T(1,2), T(1,1));
  end
  
  rx = Angle(1); ry =Angle(2); rz = Angle(3);
  vec = [x;y;z;rx;ry;rz];

end

