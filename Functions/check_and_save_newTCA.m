function OUTPUT = check_and_save_newTCA(INPUT, instance, method, idx_m, ode_options, flag_PoC, BP_struct, CAM_var, DV)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROTOTYPE:
%   OUTPUT = check_and_save_newTCA(INPUT, instance, method, idx_m, ode_options, ...
%                           flag_PoC, BP_struct, CAM_var, DV)
%--------------------------------------------------------------------------
% DESCRIPTION: 
%   Function used to compute the error with respect to the constraint and
%   the real probability of collision at the updated Time of Closest Approach. 
%   It saves all values in a struct
%--------------------------------------------------------------------------
% INPUT: 
%   INPUT       [struct]            [-]       
%   instance    [1x1 array]         Orbit case                 
%   method      [1x1 array]         Method used to solve the CAM: non_coop, ...
%                                   COOP_ANALYTICAL, STM, PROP         
%   idx_m       [1x1]               Manoeuver point
%   ode_options [struct]            option of ode solver
%   flag_PoC    [1x1]               constraint selected
%   BP_struct   [struct]            Bplane quantities
%   CAM_var     [struct]            useful parameters
%   DV          [3x1]               computed manoeuver cost
%--------------------------------------------------------------------------
% OUTPUT:
%   OUTPUT      [struct]            updated INPUT struct
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if isequal(method ,'non_coop')

    SMD = CAM_var.SMD;
    d = CAM_var.d;
    A = CAM_var.A;
    A2 = CAM_var.A2;
    mu = CAM_var.mu;
    R_B_2d = BP_struct.Rb_2D;
    rsc = CAM_var.rsc;
    vsc = CAM_var.vsc;
    state_b_p = CAM_var.state_b_p(idx_m+1,1:6)';
    tm_p = -CAM_var.dTime_range(idx_m);
    tc = CAM_var.tc;

    DV_n = norm(DV);
    INPUT.(instance).(method).DV_norm(idx_m) = DV_n*1000;       % [m]
    INPUT.(instance).(method).DV_vect(:,idx_m) = DV*1000;       % [m]

    
    % Check the distances at TCA and the error
    if ~isnan(DV_n)

        X_new_p = state_b_p+[0;0;0;DV];      % New state at the departure time (the initial state of the transfer orbit)


        [~,state1] = kep_prop_mex(mu,[tm_p tc], X_new_p, ode_options);            % Propagation up to TCA on the tranfer orbit
        % state1 = analytic_kep_prop(X_new_p, [tm_p tc], mu);

        % compute the new TCA
        fun  = @(t) DrDv(tc, t, state1(end,1:6)', [rsc; vsc]);
        fsolveopt = optimoptions('fsolve','FunctionTolerance',1e-30,'Algorithm',...
                                 'levenberg-marquardt','Display','off');    %fsolve Options
        tc_new = fsolve(fun, tc, fsolveopt);                            %Real TCA

        % tc_new_bisec = bisectionMethod_n(fun, -100, 100, 1e-4, 1000);

        INPUT.(instance).(method).tc_new(idx_m)=tc_new;

        if tc_new == tc
            tc_new = 1e-8;
        end

        % propagate to new TCA
        % state2 = analytic_kep_prop(state1, [tc tc_new], mu);
        % state2_s = analytic_kep_prop([rsc; vsc], [tc tc_new], mu);
        [~,state2] = kep_prop_mex(mu,[tc tc_new], state1(end,1:6)', ode_options);
        [~,state2_s] = kep_prop_mex(mu,[tc tc_new], [rsc; vsc], ode_options);
        
        rsc_new = state2_s(end,1:3)';
        
        rpc_new = state2(end,1:3)';
        INPUT.(instance).(method).positions{idx_m}(:,2) = rpc_new;    % Collecting the new TCA position
    
        % Check the error wrt the TCA constraint
        if flag_PoC==0 % PoC or SMD
            check_real_SMD=(rpc_new-rsc_new)'*A*(rpc_new-rsc_new)-SMD;
            INPUT.(instance).(method).error_TCA(idx_m) = abs(check_real_SMD);
            INPUT.(instance).(method).Pc_real(idx_m) = smd2poc(BP_struct, (rpc_new-rsc_new)'*A*(rpc_new-rsc_new), BP_struct.Chan_order);
            INPUT.(instance).(method).TCA_positions_proj(:,idx_m)=R_B_2d*(rpc_new-rsc_new)*1000;
    
        elseif flag_PoC==1 % B-plane miss distance
            Rb = R_eci2bplane(state2(end,4:6)',state2_s(end,4:6)');
            R_B_2d = [Rb(1,1) Rb(1,2)  Rb(1,3);
                     Rb(3,1) Rb(3,2)  Rb(3,3)];
            check_real_distance=norm(R_B_2d*(rpc_new-rsc_new))-d;
            INPUT.(instance).(method).error_TCA(idx_m) = abs(check_real_distance)*1000; % [m]
            INPUT.(instance).(method).Pc_real(idx_m) = smd2poc(BP_struct,(rpc_new-rsc_new)'*A2*(rpc_new-rsc_new), BP_struct.Chan_order);
            INPUT.(instance).(method).TCA_positions_proj(:,idx_m)=R_B_2d*(rpc_new-rsc_new)*1000;
    
        elseif flag_PoC==2 % 3D Miss distance
            check_real_distance=norm((rpc_new-rsc_new))-d;
            INPUT.(instance).(method).error_TCA(idx_m)=abs(check_real_distance)*1000;  % [m]
            INPUT.(instance).(method).Pc_real(idx_m)=smd2poc(BP_struct,(rpc_new-rsc_new)'*A2*(rpc_new-rsc_new), BP_struct.Chan_order);
            INPUT.(instance).(method).TCA_positions_proj(:,idx_m)=(rpc_new-rsc_new)*1000;
    
        end
    else

        INPUT.(instance).(method).Pc_real(idx_m) = nan;
        INPUT.(instance).(method).error_TCA(idx_m) = nan;
        INPUT.(instance).(method).TCA_positions_proj(:,idx_m)=nan;
    end

else
    
    % SMD = CAM_var.SMD;
    d = CAM_var.d;
    % A = CAM_var.A;
    % A2 = CAM_var.A2;
    mu = CAM_var.mu;
    rsc = CAM_var.rsc;
    state_b_p = CAM_var.state_b_p(idx_m+1,1:6)';
    state_b_s = CAM_var.state_b_s(idx_m+1,1:6)';
    tm_p = -CAM_var.dTime_range(idx_m);
    tm_s = tm_p;
    tc = CAM_var.tc;

    DV1 = DV(1:3);
    DV2 = DV(4:6);

    INPUT.(instance).(method).DV1_vect(:,idx_m) = DV1*1000;      % [m/s]
    INPUT.(instance).(method).DV2_vect(:,idx_m) = DV2*1000;      % [m/s]
    INPUT.(instance).(method).DV1_norm(idx_m) = norm(DV1)*1000; % [m/s]
    INPUT.(instance).(method).DV2_norm(idx_m) = norm(DV2)*1000; % [m/s]
    INPUT.(instance).(method).DV_tot_opt(idx_m) = (norm(DV1)+norm(DV2))*1000;           % [m/s]

    % Check and save distances and error
    X_new_coop_p=state_b_p+[0;0;0;DV1];             % New state at the departure time (the initial state of the transfer orbit)
    X_new_coop_s=state_b_s+[0;0;0;DV2];             % New state at the departure time (the initial state of the transfer orbit)
    % state1_coop_p = analytic_kep_prop(X_new_coop_p, [tm_p tc], mu);
    % state1_coop_s = analytic_kep_prop(X_new_coop_s, [tm_s tc], mu);
    [~,state1_coop_p]=kep_prop_mex(mu,[tm_p tc],X_new_coop_p,ode_options); % Propagation up to TCA on the tranfer orbit
    [~,state1_coop_s]=kep_prop_mex(mu,[tm_s tc],X_new_coop_s,ode_options); % Propagation up to TCA on the tranfer orbit
    INPUT.(instance).(method).distance_TCAnom(idx_m) = norm(state1_coop_p(end,1:3)' - state1_coop_s(end,1:3)')*1000; %[m]

    % compute the new TCA
    fun  = @(t) DrDv(tc, t, state1_coop_p(end,1:6)', state1_coop_s(end,1:6)');
    
    fsolveopt = optimoptions('fsolve','FunctionTolerance',1e-30,'Algorithm',...
                             'levenberg-marquardt','Display','off');    %fsolve Options
    tc_new = fsolve(fun, tc, fsolveopt);                            %Real TCA

    % tc_new_bisec = bisectionMethod_n(fun, -100, 100, 1e-30, inf);
    % 
    % INPUT.(instance).(method).tc_new_bisec(idx_m)=tc_new_bisec;

%     %%
%     time_vect = linspace(-0.05, 0.05, 1000);
%     DrDv_vect = [];
%     for var1 = 1:length(time_vect)
%         DrDv_vect(var1) = DrDv(tc,time_vect(var1), state1_coop_p(end,1:6)', state1_coop_s(end,1:6)');
%     end
%     set(0,'DefaultTextFontSize',28);
% set(0,'DefaultAxesFontSize',28);
% set(0,'DefaultLegendFontSize',28);
%     aaa = figure('Units', 'normalized', 'Position', [0, 0, 1.2, 0.3]);
%     subplot(1,4,4)
%     semilogy(time_vect,abs(DrDv_vect), 'LineWidth',2)
%     xlabel('t-TCA [s]')
%     title('$|$DrDv$|$')
%     box on
%     grid minor
% 
%     subplot(1,4,3)
%     plot(time_vect,DrDv_vect, 'LineWidth',2)
%     xlabel('t-TCA [s]')
%     title('DrDv') % $(\mathbf{r}_{rel}/r_{rel}) \cdot (\mathbf{v}_{rel}/v_{rel})$ 
%     box on
%     grid minor
%     %
%     time_vect = linspace(-0.05, 0.05, 1000);
%     Dr_vect = [];
%     Dv_vect = [];
% 
%     for var1 = 1:length(time_vect)
%         mu   = 398600.4415; %Earth Planetary Parameter [km3][s-2]
%         [x1] = analytic_kep_prop(state1_coop_p(end,1:6)', [tc time_vect(var1)], mu);
%         [x2] = analytic_kep_prop(state1_coop_s(end,1:6)', [tc time_vect(var1)], mu);
% 
%         Dr_vect(var1) = norm(x1(1:3)-x2(1:3));
%         Dv_vect(var1) = norm(x1(4:6)-x2(4:6));
%     end
% 
%     subplot(1,4,1)
%     semilogy(time_vect, Dr_vect, 'LineWidth',2)
%     xlabel('t-TCA [s]')
%     title('$\Vert \mathbf{r}_{rel} \Vert$')
%     box on
%     grid minor
% 
%     subplot(1,4,2)
%     semilogy(time_vect, Dv_vect, 'LineWidth',2)
%     xlabel('t-TCA [s]')
%     title('$\Vert \mathbf{v}_{rel} \Vert$')
%     box on
%     grid minor
% 
%     %
% %%
    
    INPUT.(instance).(method).tc_new(idx_m)=tc_new;

    if tc_new == tc
        tc_new = 1e-8;
    end

    % propagate to new TCA
    [~,state2_coop_p]=kep_prop_mex(mu,[tc tc_new],state1_coop_p(end,1:6)',ode_options); % Propagation up to TCA on the tranfer orbit
    [~,state2_coop_s]=kep_prop_mex(mu,[tc tc_new],state1_coop_s(end,1:6)',ode_options); % Propagation up to TCA on the tranfer orbit
    INPUT.(instance).(method).distance_TCAreal(idx_m) = norm(state2_coop_p(end,1:3)' - state2_coop_s(end,1:3)')*1000; %[m]
    % state2_coop_p = analytic_kep_prop(state1_coop_p(end,1:6)', [tc tc_new], mu);
    % state2_coop_s = analytic_kep_prop(state1_coop_s(end,1:6)', [tc tc_new], mu);

    r2_coop_p = state2_coop_p(end,1:3)';                            % [km]
    r2_coop_s = state2_coop_s(end,1:3)';                            % [km]
    r_rel_coop = r2_coop_p-r2_coop_s;                               % [km]
    INPUT.(instance).(method).positions_ECI_p(:,idx_m)=r2_coop_p*1000;     % Collecting the new TCA position [m]
    INPUT.(instance).(method).positions_ECI_s(:,idx_m)=r2_coop_s*1000;     % Collecting the new TCA position [m]

    % Check the error wrt the TCA constraint
    if flag_PoC==0 % PoC or SMD
        Rb = R_eci2bplane(state2_coop_p(end,4:6)',state2_coop_s(end,4:6)');
        R_B_2d = [Rb(1,1) Rb(1,2)  Rb(1,3);
                 Rb(3,1) Rb(3,2)  Rb(3,3)];
        Cov1_eci_nomT = CAM_var.conjunction.object1.covariance; %Primary [km2]
        Cov2_eci_nomT = CAM_var.conjunction.object2.covariance; %Secondary [km2]

        phi0 = eye(6);
        phi0_vector = reshape(phi0,[36 1]);
        [~,state2_coop_p_STM] = STM_prop_mex(mu,linspace(tc,tc_new,100),[state1_coop_p(end,1:6)';phi0_vector],CAM_var.ode_options); % primary state at each of the manoeuvring point 
        [~,state2_coop_s_STM] = STM_prop_mex(mu,linspace(tc,tc_new,100),[state1_coop_s(end,1:6)';phi0_vector],CAM_var.ode_options); % secondary state at each of the manoeuvering point
        STM_p = reshape(state2_coop_p_STM(end,7:end),[6 6]);
        STM_s = reshape(state2_coop_s_STM(end,7:end),[6 6]);

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

        sigma_ksi  = sqrt(C(1,1)); 
        sigma_zeta = sqrt(C(2,2));
        rho        = C(1,2)/(sigma_ksi*sigma_zeta); 
        BP_struct.u = BP_struct.sa^2 / (sigma_ksi*sigma_zeta * sqrt(1-rho^2));

        check_real_SMD=(r_rel_coop)'*A*(r_rel_coop)-SMD;
        INPUT.(instance).(method).error_TCA(idx_m)=abs(check_real_SMD);
        INPUT.(instance).(method).Pc_real(idx_m)=smd2poc(BP_struct, (r_rel_coop)'*A*(r_rel_coop), BP_struct.Chan_order);
        INPUT.(instance).(method).TCA_positions_proj(:,idx_m)=R_B_2d*(r_rel_coop) * 1000; % [m]
        INPUT.(instance).(method).object1_pos_bplane(:,idx_m)=R_B_2d*(r2_coop_p-rsc)*1000;
        INPUT.(instance).(method).object2_pos_bplane(:,idx_m)=R_B_2d*(r2_coop_s-rsc)*1000;

    elseif flag_PoC==1 % B-plane miss distance
        Rb = R_eci2bplane(state2_coop_p(end,4:6)',state2_coop_s(end,4:6)');
        R_B_2d = [Rb(1,1) Rb(1,2)  Rb(1,3);
                 Rb(3,1) Rb(3,2)  Rb(3,3)];
        check_real_distance=norm(R_B_2d*(r_rel_coop))-d;
        INPUT.(instance).(method).error_TCA(idx_m)=abs(check_real_distance)*1000; % [m]
        % INPUT.(instance).(method).Pc_real(idx_m)=smd2poc(BP_struct,(r_rel_coop)'*A2*(r_rel_coop), BP_struct.Chan_order);
        INPUT.(instance).(method).TCA_positions_proj(:,idx_m)=R_B_2d*(r_rel_coop)*1000; % [m]
        INPUT.(instance).(method).object1_pos_bplane(:,idx_m)=R_B_2d*(r2_coop_p-rsc)*1000;
        INPUT.(instance).(method).object2_pos_bplane(:,idx_m)=R_B_2d*(r2_coop_s-rsc)*1000;

    elseif flag_PoC==2 % 3D Miss distance
        check_real_distance=norm((r_rel_coop))-d;
        INPUT.(instance).(method).error_TCA(idx_m)=abs(check_real_distance)*1000;  % [m]
        % INPUT.(instance).(method).Pc_real(idx_m)=smd2poc(BP_struct,(r_rel_coop)'*A2*(r_rel_coop), BP_struct.Chan_order);
        INPUT.(instance).(method).rel_pos(:,idx_m) = r_rel_coop * 1000;      % Collecting the new TCA relative position [m]
        INPUT.(instance).(method).object1_pos_3D(:,idx_m)=(r2_coop_p-rsc)*1000;
        INPUT.(instance).(method).object2_pos_3D(:,idx_m)=(r2_coop_s-rsc)*1000;
    end

end

OUTPUT = INPUT;

end