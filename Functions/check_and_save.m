function OUTPUT = check_and_save(INPUT, instance, method, idx_m, ode_options, flag_PoC, BP_struct, CAM_var, DV)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROTOTYPE:
%   OUTPUT = check_and_save(INPUT, instance, method, idx_m, ode_options, ...
%                           flag_PoC, BP_struct, CAM_var, DV)
%--------------------------------------------------------------------------
% DESCRIPTION: 
%   Function used to compute the error with respect to the constraint and
%   the real probability of collision at the nominal conjunction time. 
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
    state_b_p = CAM_var.state_b_p(idx_m+1,1:6)';
    tm_p = -CAM_var.dTime_range(idx_m);
    tc = CAM_var.tc;

    DV_n = norm(DV);
    INPUT.(instance).(method).DV_norm(idx_m) = DV_n*1000;       % [m]
    INPUT.(instance).(method).DV_vect(:,idx_m) = DV*1000;       % [m]

    
    % Check the distances at TCA and the error
    if ~isnan(DV_n)

        X_new_p = state_b_p+[0;0;0;DV];      % New state at the departure time (the initial state of the transfer orbit)

        [~,state2] = kep_prop_mex(mu,[tm_p tc], X_new_p, ode_options);            % Propagation up to TCA on the tranfer orbit
        INPUT.(instance).(method).positions{idx_m}(:,2) = state2(end,1:3)';    % Collecting the new TCA position
    
        % Check the error wrt the TCA constraint
        if flag_PoC==0 % PoC or SMD
            check_real_SMD=(state2(end,1:3)'-rsc)'*A*(state2(end,1:3)'-rsc)-SMD;
            INPUT.(instance).(method).error_TCA(idx_m) = abs(check_real_SMD);
            INPUT.(instance).(method).Pc_real(idx_m) = smd2poc(BP_struct, (state2(end,1:3)'-rsc)'*A*(state2(end,1:3)'-rsc), BP_struct.Chan_order);
            INPUT.(instance).(method).TCA_positions_proj(:,idx_m)=R_B_2d*(state2(end,1:3)'-rsc)*1000;
    
        elseif flag_PoC==1 % B-plane miss distance
            check_real_distance=norm(R_B_2d*(state2(end,1:3)'-rsc))-d;
            INPUT.(instance).(method).error_TCA(idx_m) = abs(check_real_distance)*1000; % [m]
            INPUT.(instance).(method).Pc_real(idx_m) = smd2poc(BP_struct,(state2(end,1:3)'-rsc)'*A2*(state2(end,1:3)'-rsc), BP_struct.Chan_order);
            INPUT.(instance).(method).TCA_positions_proj(:,idx_m)=R_B_2d*(state2(end,1:3)'-rsc)*1000;
    
        elseif flag_PoC==2 % 3D Miss distance
            check_real_distance=norm((state2(end,1:3)'-rsc))-d;
            INPUT.(instance).(method).error_TCA(idx_m)=abs(check_real_distance)*1000;  % [m]
            INPUT.(instance).(method).Pc_real(idx_m)=smd2poc(BP_struct,(state2(end,1:3)'-rsc)'*A2*(state2(end,1:3)'-rsc), BP_struct.Chan_order);
            INPUT.(instance).(method).TCA_positions_proj(:,idx_m)=(state2(end,1:3)'-rsc)*1000;
    
        end
    else

        INPUT.(instance).(method).Pc_real(idx_m) = nan;
        INPUT.(instance).(method).error_TCA(idx_m) = nan;
        INPUT.(instance).(method).TCA_positions_proj(:,idx_m)=nan;
    end

else
    
    SMD = CAM_var.SMD;
    d = CAM_var.d;
    A = CAM_var.A;
    A2 = CAM_var.A2;
    mu = CAM_var.mu;
    R_B_2d = BP_struct.Rb_2D;
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
    [~,state2_coop_p]=kep_prop_mex(mu,[tm_p tc],X_new_coop_p,ode_options); % Propagation up to TCA on the tranfer orbit
    [~,state2_coop_s]=kep_prop_mex(mu,[tm_s tc],X_new_coop_s,ode_options); % Propagation up to TCA on the tranfer orbit
    r2_coop_p = state2_coop_p(end,1:3)';                            % [km]
    r2_coop_s = state2_coop_s(end,1:3)';                            % [km]
    r_rel_coop = r2_coop_p-r2_coop_s;                               % [km]
    INPUT.(instance).(method).positions_ECI_p(:,idx_m)=r2_coop_p*1000;     % Collecting the new TCA position [m]
    INPUT.(instance).(method).positions_ECI_s(:,idx_m)=r2_coop_s*1000;     % Collecting the new TCA position [m]

    % Check the error wrt the TCA constraint
    if flag_PoC==0 % PoC or SMD
        check_real_SMD=(r_rel_coop)'*A*(r_rel_coop)-SMD;
        INPUT.(instance).(method).error_TCA(idx_m)=abs(check_real_SMD);
        INPUT.(instance).(method).Pc_real(idx_m)=smd2poc(BP_struct, (r_rel_coop)'*A*(r_rel_coop), BP_struct.Chan_order);
        INPUT.(instance).(method).TCA_positions_proj(:,idx_m)=R_B_2d*(r_rel_coop) * 1000; % [m]
        INPUT.(instance).(method).object1_pos_bplane(:,idx_m)=R_B_2d*(r2_coop_p-rsc)*1000;
        INPUT.(instance).(method).object2_pos_bplane(:,idx_m)=R_B_2d*(r2_coop_s-rsc)*1000;

    elseif flag_PoC==1 % B-plane miss distance
        check_real_distance=norm(R_B_2d*(r_rel_coop))-d;
        INPUT.(instance).(method).error_TCA(idx_m)=abs(check_real_distance)*1000; % [m]
        INPUT.(instance).(method).Pc_real(idx_m)=smd2poc(BP_struct,(r_rel_coop)'*A2*(r_rel_coop), BP_struct.Chan_order);
        INPUT.(instance).(method).TCA_positions_proj(:,idx_m)=R_B_2d*(r_rel_coop)*1000; % [m]
        INPUT.(instance).(method).object1_pos_bplane(:,idx_m)=R_B_2d*(r2_coop_p-rsc)*1000;
        INPUT.(instance).(method).object2_pos_bplane(:,idx_m)=R_B_2d*(r2_coop_s-rsc)*1000;

    elseif flag_PoC==2 % 3D Miss distance
        check_real_distance=norm((r_rel_coop))-d;
        INPUT.(instance).(method).error_TCA(idx_m)=abs(check_real_distance)*1000;  % [m]
        INPUT.(instance).(method).Pc_real(idx_m)=smd2poc(BP_struct,(r_rel_coop)'*A2*(r_rel_coop), BP_struct.Chan_order);
        INPUT.(instance).(method).rel_pos(:,idx_m) = r_rel_coop * 1000;      % Collecting the new TCA relative position [m]
        INPUT.(instance).(method).object1_pos_3D(:,idx_m)=(r2_coop_p-rsc)*1000;
        INPUT.(instance).(method).object2_pos_3D(:,idx_m)=(r2_coop_s-rsc)*1000;
    end

end

OUTPUT = INPUT;

end