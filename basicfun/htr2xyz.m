function vec= htr2xyz(T)
  x = T(1,4);
  y = T(2,4);
  z = T(3,4);
  
  if abs(m(3,3)) < eps && abs(m(2,3)) < eps
      Angle(1) = 0;
      Angle(2) = atan2(m(1,3), m(3,3));
      Angle(3) = atan2(m(2,1), m(2,2));
  else
      Angle(1) = atan2(-m(2,3), m(3,3));
      sr = sin(Angle(1));
      cr = cos(Angle(1));
      Angle(2) = atan2(m(1,3), cr * m(3,3) - sr * m(2,3));  % pitch
      Angle(3) = atan2(-m(1,2), m(1,1));
  end
  
  rx = Angle(1); ry =Angle(2); rz = Angle(3);
  vec = [x;y;z;rx;ry;rz];

end

