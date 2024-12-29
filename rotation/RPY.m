function [rotMatrix,vec_rot] = RPY(seq,x,y,z,vec)
    % Function to calculate rotation matrix and rotated vector using Euler angles
    vec = vec(:); % ȷ��������
    x = deg2rad(x);    y = deg2rad(y);    z = deg2rad(z);
    % Step 1: Compute individual rotation matrices
    [Rx, ~] = rot('X', x, vec);
    [Ry, ~] = rot('Y', y, vec);
    [Rz, ~] = rot('Z', z, vec);

    % Step 2: Determine rotation sequence
    switch seq
        case 'xyz'
            rotMatrix = Rz * Ry * Rx;
        case 'xzy'
            rotMatrix = Ry * Rz * Rx;
        case 'yzx'
            rotMatrix = Rx * Rz * Ry;
        case 'yxz'
            rotMatrix = Rz * Rx * Ry;
        case 'zyx'
            rotMatrix = Rx * Ry * Rz;
        case 'zxy'
            rotMatrix = Ry * Rx * Rz;
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

