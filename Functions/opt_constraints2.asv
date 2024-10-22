function [c, c_eq] = opt_constraints2 (DV_vect, state_b_p, state_b_s, mu, tm, tc, A, d, SMD, ode_options, flag_PoC, flag_TCAupdate, CAM_var)

c = [];

DV1 = DV_vect(1:3);
DV2 = DV_vect(4:6);

X_new_non_dual_bm=state_b_p+[0;0;0;DV1];   % New state at the departure time (the initial state of the transfer orbit)
X_new_non_dual_s_bm=state_b_s+[0;0;0;DV2];   % New state at the departure time (the initial state of the transfer orbit)
[~,state_c_p]=kep_prop_mex(mu,[tm tc],X_new_non_dual_bm,ode_options); % Propagation up to TCA on the tranfer orbit
[~,state_c_s]=kep_prop_mex(mu,[tm tc],X_new_non_dual_s_bm,ode_options); % Propagation up to TCA on the tranfer orbit

if flag_TCAupdate == 0
    
    dr_f = state_c_p(end,1:3)' - state_c_s(end,1:3)';

elseif flag_TCAupdate == 1
    fun  = @(t) DrDv(tc, t, state_c_p(end,1:6)', state_c_s(end,1:6)');

    fsolveopt = optimoptions('fsolve','FunctionTolerance',1e-12,'Algorithm',...
                             'levenberg-marquardt','Display','off');    %fsolve Options
    tc_new = fsolve(fun, tc, fsolveopt);

    if flag_PoC == 2
        
        if tc_new == tc
            tc_new = 1e-8;
        end
        [~,state_c_p_new]=kep_prop_mex(mu,[tc tc_new],state_c_p(end,1:6)',ode_options);
        [~,state_c_s_new]=kep_prop_mex(mu,[tc tc_new],state_c_s(end,1:6)',ode_options);
    
        dr_f = state_c_p_new(end,1:3)' - state_c_s_new(end,1:3)';

        A = eye(3);

    elseif flag_PoC == 1

        if tc_new == tc
            tc_new = 1e-8;
        end
        [~,state_c_p_new]=kep_prop_mex(mu,[tc tc_new],state_c_p(end,1:6)',ode_options);
        [~,state_c_s_new]=kep_prop_mex(mu,[tc tc_new],state_c_s(end,1:6)',ode_options);
        dr_f = state_c_p_new(end,1:3)' - state_c_s_new(end,1:3)';

        Rb = R_eci2bplane(state_c_p_new(end,4:6)',state_c_s_new(end,4:6)');
        Rb_2D = [Rb(1,1) Rb(1,2)  Rb(1,3);
                 Rb(3,1) Rb(3,2)  Rb(3,3)];
        A = Rb_2D' * Rb_2D;

    elseif flag_PoC == 0
        
        phi0 = eye(6);
        phi0_vector = reshape(phi0,[36 1]);
        if tc_new == tc
            tc_new = 1e-8;
        end
        [~,state2_coop_p_STM] = STM_prop_mex(mu,linspace(tc,tc_new,50),[state_c_p(end,1:6)';phi0_vector],ode_options); % primary state at each of the manoeuvring point 
        [~,state2_coop_s_STM] = STM_prop_mex(mu,linspace(tc,tc_new,50),[state_c_s(end,1:6)';phi0_vector],ode_options); % secondary state at each of the manoeuvering point
        STM_p = reshape(state2_coop_p_STM(end,7:end),[6 6]);
        STM_s = reshape(state2_coop_s_STM(end,7:end),[6 6]);
        r2_coop_p = state2_coop_p_STM(end,1:3)';
        r2_coop_s = state2_coop_s_STM(end,1:3)';
        v2_coop_p = state2_coop_p_STM(end,4:6)';
        v2_coop_s = state2_coop_s_STM(end,4:6)';

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