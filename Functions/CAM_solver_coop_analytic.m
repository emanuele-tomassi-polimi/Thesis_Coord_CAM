function [DV1, DV2] = CAM_solver_coop_analytic(dr_0, A, con, phi_p, phi_s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROTOTYPE:
%   [DV1, DV2] = CAM_solver_coop_analytic(dr_0, A, con, phi_p, phi_s)
%--------------------------------------------------------------------------
% DESCRIPTION: 
%   Function used to solve the coordinated CAM problem analytically. 
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
%   DV1         [3x1]       Computed manoeuvre cost for the primary
%   DV2         [3x1]       Computed manoeuvre cost for the secondary
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extract coefficients of the lambda polynomial and the numerators and
% denominators of DV1 and DV2
[coeff_vect_l, coeff_vect_d, coeff_vect_dv1_num, coeff_vect_dv2_num] = get_coeff_coop_newnew(dr_0, A, con, phi_p, phi_s);

% extract roots of lambda polynomial
lambda_roots = roots(coeff_vect_l);

% Do not consider imaginary solutions
lambda_roots =real(lambda_roots(imag(lambda_roots) == 0));

% Choose the minimum deltav that satisfies the boundary condition
DVtot_norm_comp = inf;
check_con_comp = inf;

for var1 = 1:length(lambda_roots)
    lambda = lambda_roots(var1);
    
    if abs(polyval(coeff_vect_l, lambda)) < 1e-6
        dv_den = polyval(coeff_vect_d, lambda);
        
        if dv_den ~= 0
            DV1_test=[polyval(coeff_vect_dv1_num(1,:), lambda);
                      polyval(coeff_vect_dv1_num(2,:), lambda);
                      polyval(coeff_vect_dv1_num(3,:), lambda)] / dv_den;
            DV1_norm_test=norm(DV1_test);
    
            DV2_test=[polyval(coeff_vect_dv2_num(1,:), lambda);
                      polyval(coeff_vect_dv2_num(2,:), lambda);
                      polyval(coeff_vect_dv2_num(3,:), lambda)] / dv_den;
            DV2_norm_test=norm(DV2_test);
    
            DVtot_norm_test = DV1_norm_test + DV2_norm_test;
    
            dr_f = dr_0 + phi_p * DV1_test - phi_s * DV2_test;
            check_con_test = abs(dr_f' * A * dr_f - con);
            
            if DVtot_norm_test < DVtot_norm_comp && (check_con_test < 1e-3 || check_con_test < check_con_comp)
                 DV1 = DV1_test;
                 DV2 = DV2_test;
                 DVtot_norm_comp = DVtot_norm_test;
                 check_con_comp = check_con_test;
                 
            end
        end
    end
end


end