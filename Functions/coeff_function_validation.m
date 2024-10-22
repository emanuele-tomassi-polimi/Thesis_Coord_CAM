%% check if the functions to get coefficients are correct
clear
clc
close all

syms lambda

A_p = rand(3,3);
A_s = rand(3,3);
A_ps = rand(3,3);
A_sp = rand(3,3);
bp = rand(3,1);
bs = rand(3,1);
b0 = rand(1,1);

A = [eye(3)+lambda*A_p, -lambda*A_ps;
                    -lambda*A_sp, eye(3)+lambda*A_s];

b = [-lambda*bp;lambda*bs];

deltav_1_2 = A\b;

deltav_1 = deltav_1_2(1:3);
deltav_2 = deltav_1_2(4:6);

[num_v1, den_v1] = numden(deltav_1);
[num_v2, den_v2] = numden(deltav_2);

[coeff_v1_n_1,terms1] = coeffs(num_v1(1), lambda, 'All');
coeff_v1_n_2 = coeffs(num_v1(2), lambda, 'All');
coeff_v1_n_3 = coeffs(num_v1(3), lambda, 'All');

[coeff_v1_d_1,terms2] = coeffs(den_v1(1), lambda, 'All');
coeff_v1_d_2 = coeffs(den_v1(2), lambda, 'All');
coeff_v1_d_3 = coeffs(den_v1(3), lambda, 'All');

coeff_v2_n_1 = coeffs(num_v2(1), lambda, 'All');
coeff_v2_n_2 = coeffs(num_v2(2), lambda, 'All');
coeff_v2_n_3 = coeffs(num_v2(3), lambda, 'All');

coeff_v2_d_1 = coeffs(den_v2(1), lambda, 'All');
coeff_v2_d_2 = coeffs(den_v2(2), lambda, 'All');
coeff_v2_d_3 = coeffs(den_v2(3), lambda, 'All');


bp_T = bp';
bs_T = bs';

M0 = inv(A_ps);
m3 = - A_ps \ bp;
M5 = A_ps \ A_p;

M1 = M5 + A_s / A_ps;
M2 = A_s * M5 - A_sp;
m4 = A_s * m3 + bs;

% n1 = get_coeff_coop_n1(M0, M1, M2, M5, m3, m4);
% n2 = get_coeff_coop_n2(M0, M1, M2, M5, m3, m4);
% n3 = get_coeff_coop_n3(M0, M1, M2, M5, m3, m4);
% n4 = get_coeff_coop_n4(M0, M1, M2, M5, m3, m4);
% n5 = get_coeff_coop_n5(M0, M1, M2, M5, m3, m4);
% n6 = get_coeff_coop_n6(M0, M1, M2, M5, m3, m4);
% 
% d = get_coeff_coop_d(M0, M1, M2, M5, m3, m4);

n1 = get_coeff_coop_n1_newnew(A_p, A_s, A_ps, A_sp, bp, bs);
n2 = get_coeff_coop_n2_newnew(A_p, A_s, A_ps, A_sp, bp, bs);
n3 = get_coeff_coop_n3_newnew(A_p, A_s, A_ps, A_sp, bp, bs);
n4 = get_coeff_coop_n4_newnew(A_p, A_s, A_ps, A_sp, bp, bs);
n5 = get_coeff_coop_n5_newnew(A_p, A_s, A_ps, A_sp, bp, bs);
n6 = get_coeff_coop_n6_newnew(A_p, A_s, A_ps, A_sp, bp, bs);

d = get_coeff_coop_d_newnew(A_p, A_s, A_ps, A_sp, bp, bs);

deltav_1 = matlabFunction(deltav_1);
deltav_2 = matlabFunction(deltav_2);

l = 100;

dv1 = deltav_1(l);
dv2 = deltav_2(l);

dv1(1) - polyval(n1, l)/polyval(d, l)
dv1(2) - polyval(n2, l)/polyval(d, l)
dv1(3) - polyval(n3, l)/polyval(d, l)
dv2(1) - polyval(n4, l)/polyval(d, l)
dv2(2) - polyval(n5, l)/polyval(d, l)
dv2(3) - polyval(n6, l)/polyval(d, l)


fun = @(l) b0 + 2*bp'*deltav_1(l) - 2*bs'*deltav_2(l) + deltav_1(l)'*A_p*deltav_1(l)...
    + deltav_2(l)'*A_s*deltav_2(l) - deltav_1(l)'*A_ps*deltav_2(l) - deltav_2(l)'*A_sp*deltav_1(l);

coeff_l = get_coeff_coop_l(b0, bp_T, bs_T, A_p, A_s, A_ps, A_sp, n1, n2, n3, n4, n5, n6, d);

fun(l) - polyval(coeff_l,l)/(polyval(d, l))^2

