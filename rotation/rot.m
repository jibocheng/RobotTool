function [Rotation_Matrix, vec_rot] = rot(axis, theta, vec)
    % Function to calculate rotation matrix and rotated vector
    % Inputs:
    %   axis: 'X', 'Y', or 'Z' (string) for rotation axis
    %   theta: rotation angle in radians
    %   vec: 1x3 or 3x1 vector to rotate
    % Outputs:
    %   Rotation_Matrix: 3x3 rotation matrix
    %   vec_rot: rotated vector
    
    theta = deg2rad(theta);
    % Normalize vector input (ensure column vector)
    if size(vec, 1) == 1
        vec = vec'; % Convert row vector to column vector
    end

    % Define rotation matrices for each axis
    switch axis
        case 'X'
            Rotation_Matrix = [1, 0, 0; 0, cos(theta), -sin(theta); 0, sin(theta), cos(theta)];
        case 'Y'
            Rotation_Matrix = [cos(theta), 0, sin(theta); 0, 1, 0; -sin(theta), 0, cos(theta)];
        case 'Z'
            Rotation_Matrix = [cos(theta), -sin(theta), 0; sin(theta), cos(theta), 0; 0, 0, 1];
        otherwise
            error('Invalid axis input. Use ''X'', ''Y'', or ''Z''.');
    end
    
    % Rotate the vector
    vec_rot = Rotation_Matrix * vec;
end
