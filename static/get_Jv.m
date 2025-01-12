function Jv = get_Jv(alpha, a, d, q)
    % Define DH parameters
    T01 = DH_transform(alpha(1), a(1), d(1), q(1), 0);
    T12 = DH_transform(alpha(2), a(2), d(2), q(2), 0);
    T23 = DH_transform(alpha(3), a(3), d(3), q(3), 0);
    T34 = DH_transform(alpha(4), a(4), d(4), q(4), 0);
    T45 = DH_transform(alpha(5), a(5), d(5), q(5), 0);
    T56 = DH_transform(alpha(6), a(6), d(6), q(6), 0);

    % Compute cumulative transforms
    T02 = T01 * T12;
    T03 = T02 * T23;
    T04 = T03 * T34;
    T05 = T04 * T45;
    T06 = T05 * T56;

    % Extract positions
    P0 = [0; 0; 0];
    P1 = T01(1:3, 4);
    P2 = T02(1:3, 4);
    P3 = T03(1:3, 4);
    P4 = T04(1:3, 4);
    P5 = T05(1:3, 4);
    P6 = T06(1:3, 4);

    % Extract rotation axes
    Z0 = [0; 0; 1];
    Z1 = T01(1:3, 1:3) * Z0;
    Z2 = T02(1:3, 1:3) * Z0;
    Z3 = T03(1:3, 1:3) * Z0;
    Z4 = T04(1:3, 1:3) * Z0;
    Z5 = T05(1:3, 1:3) * Z0;
    Z6 = T06(1:3, 1:3) * Z0;

    % Compute Jacobian
    Jv = zeros(6, 6);
    Jv(1:3, 1) = cross(Z1, P6 - P1);
    Jv(1:3, 2) = cross(Z2, P6 - P2);
    Jv(1:3, 3) = cross(Z3, P6 - P3);
    Jv(1:3, 4) = cross(Z4, P6 - P4);
    Jv(1:3, 5) = cross(Z5, P6 - P5);
    Jv(1:3, 6) = cross(Z6, P6 - P6);

    Jv(4:6, 1) = Z1;
    Jv(4:6, 2) = Z2;
    Jv(4:6, 3) = Z3;
    Jv(4:6, 4) = Z4;
    Jv(4:6, 5) = Z5;
    Jv(4:6, 6) = Z6;
end