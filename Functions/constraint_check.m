function [c_check, tc_new, state_c_f_p_new, state_c_f_s_new, dr_f, A_new, con_new, phi_p_new, phi_s_new, Cov1_eci_new, Cov2_eci_new] = constraint_check (DV_vect, CAM_var, state_c_i_p, state_c_i_s, phi_p_old, phi_s_old, Cov1_eci_oldT, Cov2_eci_oldT, tc_old, con_old,flag_PoC)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROTOTYPE:
%   [c_check, tc_new, state_c_f_p_new, state_c_f_s_new, dr_f, A_new, con_new, ...
%       phi_p_new, phi_s_new, Cov1_eci_new, Cov2_eci_new] = constraint_check ...
%               (DV_vect, CAM_var, state_c_i_p, state_c_i_s, phi_p_old, phi_s_old, ...
%                Cov1_eci_oldT, Cov2_eci_oldT, tc_old, con_old,flag_PoC)
%--------------------------------------------------------------------------
% DESCRIPTION: 
%   Function used to check the constraint at the real TCA and update relevant
%   quantities for the while cycle. 
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

DV1 = DV_vect(1:3);
DV2 = DV_vect(4:6);

phi_c_rv_p = phi_p_old(1:3,4:6);
phi_c_rv_s = phi_s_old(1:3,4:6);

rc_f_p = state_c_i_p(1:3) + phi_c_rv_p * DV1;
rc_f_s = state_c_i_s(1:3) + phi_c_rv_s * DV2;

phi_c_vv_p = phi_p_old(4:6,4:6);
phi_c_vv_s = phi_s_old(4:6,4:6);

vc_f_p = state_c_i_p(4:6) + phi_c_vv_p * DV1;
vc_f_s = state_c_i_s(4:6) + phi_c_vv_s * DV2;

state_c_f_p = [rc_f_p; vc_f_p];
state_c_f_s = [rc_f_s; vc_f_s];

mu   = 398600.4415;

fun  = @(t) DrDv(tc_old, t, state_c_f_p, state_c_f_s);

fsolveopt = optimoptions('fsolve','FunctionTolerance',1e-12,'Algorithm',...
                         'levenberg-marquardt','Display','off');    %fsolve Options

tc_new = fsolve(fun, tc_old, fsolveopt); 

[r2_coop_p, v2_coop_p, STM_p] = analytical_stm(rc_f_p,vc_f_p,tc_new - tc_old,mu); 
[r2_coop_s, v2_coop_s, STM_s] = analytical_stm(rc_f_s,vc_f_s,tc_new - tc_old,mu);

state_c_f_p_new = [r2_coop_p; v2_coop_p];
state_c_f_s_new = [r2_coop_s; v2_coop_s];

dr_f = r2_coop_p - r2_coop_s;

phi_p_new = STM_p * phi_p_old;
phi_s_new = STM_s * phi_s_old;

if flag_PoC == 2
    A_new = eye(3);
    con_new = con_old;
    Cov1_eci_new = NaN;
    Cov2_eci_new = NaN;

elseif flag_PoC == 1

    Rb = R_eci2bplane(v2_coop_p,v2_coop_s);
    Rb_2D = [Rb(1,1) Rb(1,2)  Rb(1,3);
             Rb(3,1) Rb(3,2)  Rb(3,3)];
    A_new = Rb_2D' * Rb_2D;

    con_new = con_old;
    Cov1_eci_new = NaN;
    Cov2_eci_new = NaN;

elseif flag_PoC == 0

    Rb = R_eci2bplane(v2_coop_p,v2_coop_s);
    R_B_2d = [Rb(1,1) Rb(1,2)  Rb(1,3);
             Rb(3,1) Rb(3,2)  Rb(3,3)];

    % Cov1_eci_oldT = CAM_var.conjunction.object1.covariance; %Primary [km2]
    % Cov2_eci_oldT = CAM_var.conjunction.object2.covariance; %Secondary [km2]

    Cov1_eci_new = STM_p * Cov1_eci_oldT * STM_p';
    Cov2_eci_new = STM_s * Cov2_eci_oldT * STM_s';
    Cov1_eci_pos = Cov1_eci_new(1:3,1:3);
    Cov2_eci_pos = Cov2_eci_new(1:3,1:3);

    Cov1_bp = Rb * Cov1_eci_pos * Rb';
    Cov2_bp = Rb * Cov2_eci_pos * Rb';
    Cov_bp = Cov1_bp + Cov2_bp;
    C = [Cov_bp(1,1) Cov_bp(1,3);
         Cov_bp(3,1) Cov_bp(3,3)];

    A_new=R_B_2d'*(C\R_B_2d);

    con_new = PoC2SMD(C, CAM_var.R, CAM_var.PoC_Chan, CAM_var.Chan_order, CAM_var.PoC_accuracy, CAM_var.n_PoC_iter);
end



c_check = abs((dr_f)' * A_new * (dr_f) - con_new);


end