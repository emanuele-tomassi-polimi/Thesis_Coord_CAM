function [c, c_eq] = opt_constraints (DV_vect, state_c_i_p, state_c_i_s, CAM_var, flag_PoC, flag_TCAupdate)

c = [];

DV1 = DV_vect(1:3);
DV2 = DV_vect(4:6);

phi_c_rv_p = CAM_var.phi_c_rv_p;
phi_c_rv_s = CAM_var.phi_c_rv_s;

rc_f_p = state_c_i_p(1:3) + phi_c_rv_p * DV1;
rc_f_s = state_c_i_s(1:3) + phi_c_rv_s * DV2;

d = CAM_var.d;


if flag_TCAupdate == 0

    dr_f = rc_f_p - rc_f_s;

    A = CAM_var.A;
    SMD = CAM_var.SMD;

elseif flag_TCAupdate == 1

    phi_c_vv_p = CAM_var.phi_c_vv_p;
    phi_c_vv_s = CAM_var.phi_c_vv_s;

    vc_f_p = state_c_i_p(4:6) + phi_c_vv_p * DV1;
    vc_f_s = state_c_i_s(4:6) + phi_c_vv_s * DV2;

    state_c_f_p = [rc_f_p; vc_f_p];
    state_c_f_s = [rc_f_s; vc_f_s];

    tc = 0;
    mu   = 398600.4415;

    fun  = @(t) DrDv(tc, t, state_c_f_p, state_c_f_s);

    fsolveopt = optimoptions('fsolve','FunctionTolerance',1e-12,'Algorithm',...
                             'levenberg-marquardt','Display','off');    %fsolve Options
    tc_new = fsolve(fun, tc, fsolveopt); 

    if flag_PoC == 2
        state_c_p_new = analytic_kep_prop(state_c_f_p, [tc tc_new], mu);
        state_c_s_new = analytic_kep_prop(state_c_f_s, [tc tc_new], mu);
    
        dr_f = state_c_p_new(1:3) - state_c_s_new(1:3);

        A = eye(3);

    elseif flag_PoC == 1
        state_c_p_new = analytic_kep_prop(state_c_f_p, [tc tc_new], mu);
        state_c_s_new = analytic_kep_prop(state_c_f_s, [tc tc_new], mu);
        dr_f = state_c_p_new(1:3) - state_c_s_new(1:3);

        Rb = R_eci2bplane(state_c_p_new(4:6),state_c_s_new(4:6));
        Rb_2D = [Rb(1,1) Rb(1,2)  Rb(1,3);
                 Rb(3,1) Rb(3,2)  Rb(3,3)];
        A = Rb_2D' * Rb_2D;

    elseif flag_PoC == 0

        [r2_coop_p, v2_coop_p, STM_p] = analytical_stm(rc_f_p,vc_f_p,tc_new - tc,mu); 
        [r2_coop_s, v2_coop_s, STM_s] = analytical_stm(rc_f_s,vc_f_s,tc_new - tc,mu);

        dr_f = r2_coop_p - r2_coop_s;

        Rb = R_eci2bplane(v2_coop_p,v2_coop_s);
        R_B_2d = [Rb(1,1) Rb(1,2)  Rb(1,3);
                 Rb(3,1) Rb(3,2)  Rb(3,3)];
        Cov1_eci_nomT = CAM_var.conjunction.object1.covariance; %Primary [km2]
        Cov2_eci_nomT = CAM_var.conjunction.object2.covariance; %Secondary [km2]

        Cov1_eci = STM_p * Cov1_eci_nomT * STM_p';
        Cov2_eci = STM_s * Cov2_eci_nomT * STM_s';
        Cov1_eci_pos = Cov1_eci(1:3,1:3);
        Cov2_eci_pos = Cov2_eci(1:3,1:3);

        Cov1_bp = Rb * Cov1_eci_pos * Rb';
        Cov2_bp = Rb * Cov2_eci_pos * Rb';
        Cov_bp = Cov1_bp + Cov2_bp;
        C = [Cov_bp(1,1) Cov_bp(1,3);
             Cov_bp(3,1) Cov_bp(3,3)];

        A=R_B_2d'*(C\R_B_2d);

        SMD = PoC2SMD(C, CAM_var.R, CAM_var.PoC_Chan, CAM_var.Chan_order, CAM_var.PoC_accuracy, CAM_var.n_PoC_iter);
    end

end



if flag_PoC == 2
    c_eq = - ( (dr_f)' * A * (dr_f) ) + d^2;
elseif flag_PoC == 1
    c_eq = - ( (dr_f)' * A * (dr_f) ) + d^2;
elseif flag_PoC == 0
    c_eq = - ( (dr_f)' * A * (dr_f) ) + SMD;
end



end