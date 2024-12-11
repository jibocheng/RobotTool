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

    matrix_fk = eye(4);
  
    for i = 1:nLinks
        T = DH_transform(alpha(i), a(i), d(i), theta(i),delta(i));
        matrix_fk = matrix_fk * T;
    end

    vec_tool = [vec_tool; 1]; 
    vec_base = matrix_fk * vec_tool; 
end

