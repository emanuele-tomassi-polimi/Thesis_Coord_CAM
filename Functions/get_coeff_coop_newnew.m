function [coeff_vect_l, coeff_vect_d, coeff_vect_dv1_num, coeff_vect_dv2_num] = get_coeff_coop_newnew(dr_0, A, con, phi_p, phi_s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROTOTYPE:
%   [coeff_vect_l, coeff_vect_d, coeff_vect_dv1_num, coeff_vect_dv2_num] = ...
%               get_coeff_coop_newnew(dr_0, A, con, phi_p, phi_s)
%--------------------------------------------------------------------------
% DESCRIPTION: 
%   Function used to obtain the coefficients of the lambda polynomial and
%   the DV1 and DV2 numerators and denominators
%--------------------------------------------------------------------------
% INPUT: 
%   dr_0        [3x1]       Relative position vector at conjunction before ...
%                           manoeuvre execution       
%   A           [3x3]       Matrix used for the TCA constraint implementation                 
%   con         [1x1]       Constraint      
%   phi_p       [3x3]       Primary STM rv submatrix
%   phi_s       [3x3]       Secondary STM rv submatrix
%--------------------------------------------------------------------------
% OUTPUT:
%   coeff_vect_l        [1x13]      lambda polynomial coefficients
%   coeff_vect_d        [1x7]       coefficients of DV1 and DV2 denominators
%   coeff_vect_dv1_num  [3x7]       coefficients of DV1 numerators
%   coeff_vect_dv2_num  [3x7]       coefficients of DV2 numerators
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

b0 = dr_0.' * A * dr_0 - con;

bp = (phi_p.' * A * dr_0);
bs = (phi_s.' * A * dr_0);

A_p = phi_p.' * A * phi_p;
A_s = phi_s.' * A * phi_s;
A_ps = phi_p.' * A * phi_s;
A_sp = phi_s.' * A * phi_p;

bp_T = bp';
bs_T = bs';

% n1_test = get_coeff_coop_n1_new(A_p, A_s, A_ps, A_sp, bp, bs);
% n2_test = get_coeff_coop_n2_new(A_p, A_s, A_ps, A_sp, bp, bs);
% n3_test = get_coeff_coop_n3_new(A_p, A_s, A_ps, A_sp, bp, bs);
% n4_test = get_coeff_coop_n4_new(A_p, A_s, A_ps, A_sp, bp, bs);
% n5_test = get_coeff_coop_n5_new(A_p, A_s, A_ps, A_sp, bp, bs);
% n6_test = get_coeff_coop_n6_new(A_p, A_s, A_ps, A_sp, bp, bs);
% 
% d_test = get_coeff_coop_d_new(A_p, A_s, A_ps, A_sp, bp, bs);

n1 = get_coeff_coop_n1_newnew(A_p, A_s, A_ps, A_sp, bp, bs);
n2 = get_coeff_coop_n2_newnew(A_p, A_s, A_ps, A_sp, bp, bs);
n3 = get_coeff_coop_n3_newnew(A_p, A_s, A_ps, A_sp, bp, bs);
n4 = get_coeff_coop_n4_newnew(A_p, A_s, A_ps, A_sp, bp, bs);
n5 = get_coeff_coop_n5_newnew(A_p, A_s, A_ps, A_sp, bp, bs);
n6 = get_coeff_coop_n6_newnew(A_p, A_s, A_ps, A_sp, bp, bs);

d = get_coeff_coop_d_newnew(A_p, A_s, A_ps, A_sp, bp, bs);

coeff_vect_d = d;
coeff_vect_dv1_num = [n1;n2;n3];
coeff_vect_dv2_num = [n4;n5;n6];

coeff_vect_l = get_coeff_coop_l(b0, bp_T, bs_T, A_p, A_s, A_ps, A_sp, n1, n2, n3, n4, n5, n6, d);

end