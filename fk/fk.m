function [vec_base, matrix_fk] = fk(nLinks, alpha, a, d, theta,delta,vec_tool)
    if nLinks ~= length(alpha)
        error('robot model not match');
    end
    if nLinks ~= length(a)
        error('robot model not match');
    end
    if nLinks ~= length(d)
        error('robot model not match');
    end
    if nLinks ~= length(theta)
        error('robot model not match');
    end
    if nLinks ~= length(delta)
        error('robot model not match');
    end
    
    alpha = deg2rad(alpha);
    theta = deg2rad(theta);
    delta = deg2rad(delta);
    
    matrix_fk = eye(4);
  
    for i = 1:nLinks
        T = DH_transform(alpha(i), a(i), d(i), theta(i),delta(i));
        matrix_fk = matrix_fk * T;
    end

    vec_base = htr2xyz(matrix_fk);
end

