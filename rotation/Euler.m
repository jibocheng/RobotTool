function [rotMatrix, vec_rot] = Euler(seq, x, y, z, vec)
    % Function to calculate rotation matrix and rotated vector using Euler angles
    vec = vec(:); % 确保列向量
    
    % Step 1: Compute individual rotation matrices
    [Rx, ~] = rot('X', x, vec);
    [Ry, ~] = rot('Y', y, vec);
    [Rz, ~] = rot('Z', z, vec);
    
    % Step 2: Determine rotation sequence
    switch seq
        case 'xyz'
            rotMatrix = Rx * Ry * Rz;
        case 'xzy'
            rotMatrix = Rx * Rz * Ry;
        case 'yzx'
            rotMatrix = Ry * Rz * Rx;
        case 'yxz'
            rotMatrix = Ry * Rx * Rz;
        case 'zyx'
            rotMatrix = Rz * Ry * Rx;
        case 'zxy'
            rotMatrix = Rz * Rx * Ry;
        otherwise
            error('Invalid rotation sequence. Use a valid combination like ''xyz''.');
    end

    % Step 3: Rotate the input vector
    vec_rot = rotMatrix * vec;

    % Debugging: Display intermediate results
    fprintf('Rotation matrix:\n');
    disp(rotMatrix);

    fprintf('Rotated vector:\n');
    disp(vec_rot');
end
