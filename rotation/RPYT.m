function [rotMatrix,vec_rot] = RPYT(seq,x,y,z,rx,ry,rz,vec)
    % Function to calculate rotation matrix and rotated vector using Euler angles
    vec = vec(:); % 确保列向量
    rx = deg2rad(rx);    ry = deg2rad(ry);    rz = deg2rad(rz);
    % Step 1: Compute individual rotation matrices
    [Rx, ~] = rot('X', rx, vec);
    [Ry, ~] = rot('Y', ry, vec);
    [Rz, ~] = rot('Z', rz, vec);

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

    % Step 3: R -> T
    rotMatrix = [
        rotMatrix(1,:),x;
        rotMatrix(2,:),y;
        rotMatrix(3,:),z;
        0,0,0,1
        ]
    % Step 3: Rotate the input vector
    vec = [vec(1);vec(2);vec(3);1];
    vec_rot = rotMatrix * vec;

    % Debugging: Display intermediate results
    fprintf('Rotation matrix:\n');
    disp(rotMatrix);

    fprintf('Rotated vector:\n');
    disp(vec_rot');
end

