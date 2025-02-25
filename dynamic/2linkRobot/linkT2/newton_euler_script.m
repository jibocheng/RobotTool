syms q11 dq11 ddq11;
syms q22 dq22 ddq22;

R01 = hrotZ3x3(q11); R10 = R01';
R02 = 
% inner to outer
w11 = R10 * w00 + dq11 * Zv;