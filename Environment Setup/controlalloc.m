% --- Parameters from Table 2 of the paper ---
KT = 2.92e-6;   % Thrust coefficient (your 'b' for thrust)
Kd = 1.12e-7;   % Drag coefficient (your 'd')
l = 0.2;        % Arm length in meters

% --- Correct Allocation Matrix from Equation (5) ---
% This is the matrix that you should be using for your 'A'.
% It maps squared motor speeds to the control inputs [U1; U2; U3; U4].
alloc_matrix = [  KT,      KT,      KT,     KT;
                  0,    -l*KT,       0,   l*KT;
               l*KT,       0,    -l*KT,      0;
                 Kd,     -Kd,      Kd,    -Kd ];

% To get the rotor speeds from the U inputs, you need the inverse of this matrix.
A_inverse = inv(alloc_matrix);

disp('Correct Allocation Matrix (A):');
disp(alloc_matrix);

disp('Correct Inverse Matrix (A_inv):');
disp(alloc_matrix_inv);