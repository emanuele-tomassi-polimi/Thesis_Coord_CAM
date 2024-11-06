%%%%%%%%%%%%%%%%%%%%%%%%%%%% CAM WITHOUT RETURN %%%%%%%%%%%%%%%%%%%%%%%%%%%

% SCRIPT CONTENT:
% CAM without return to the nominal orbit.
%--------------------------------------------------------------------------
% CHARACTERISTICS:
% _ Two-body dynamics around the Earth
% _ One impulsive manoeuvre
% _ The constraint function can be:
%                                    _ Miss distance computed in the 3D space
%                                    _ Miss distance computed on the B-plane
%                                    _ Probability of Collision (PoC)
% _ No return to the nominal orbit
% _ LEO, GEO cases
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Setting
clear
clearvars
clc;
close all;

OUTPUT = struct;
OUTPUT_realTCA = struct;
CAM_var = struct;

% Add the folder and its subfolders to the search path
addpath('Functions');
addpath('data');
addpath('data/Spice_data');
addpath('Functions/input_management');
addpath('Functions/get_n_coeffs');

% Loading Spice Kernels
start_spice();

% CDM folder
folder_CDM = 'CDM';
folder_OPM = 'OPM';

% ------------------------ FUNCTIONS OPTIONS ------------------------------

% fsolve options
fsolve_options = optimoptions('fsolve', 'Algorithm','Levenberg-Marquardt',...
    'StepTolerance',1e-20,  'FunctionTolerance' ,1e-24, 'MaxFunctionEvaluations', ...
    1e+5,  'MaxIterations', 1e+4, 'display','off');

% ode options
ode_options = odeset ('RelTol', 2.5e-14, 'AbsTol', 2.5e-14);                % set integrator accuracy
CAM_var.ode_options = ode_options;

% fmincon options
fmincon_options = optimoptions('fmincon', 'Display', 'off', 'Algorithm', ...
    'interior-point', 'EnableFeasibilityMode',true,...
    'SubproblemAlgorithm','cg', 'MaxFunctionEvaluations',1e6,'ConstraintTolerance',6.01e-4);

% fmincon_options = optimoptions('fmincon', 'Display', 'off', 'Algorithm', ...
%     'active-set', 'MaxFunctionEvaluations',1e4,'ConstraintTolerance',1e-4);

%% CAM settings
% CDMs
cases = {'LEOH2HMD', 'LEOH2HRD','LEOH2TRD','LEOTYPMD', 'MEOGTOMD', 'GEOGTOMD', 'GEOTYPMD'};
% cases = {'LEOH2HMD', 'LEOH2HRD','LEOTYPMD', 'MEOGTOMD', 'GEOGTOMD', 'GEOTYPMD'};
% cases = {'LEOH2HMD','GEOGTOMD'};
% cases = {'LEOH2HRD','LEOTYPMD', 'MEOGTOMD', 'GEOTYPMD'};
% cases = {'LEOH2HMD'};
% cases = {'LEOH2HMD','LEOH2HRD'};
% cases = {'GEOGTOMD', 'GEOTYPMD'};
% cases = {'LEOH2HMD', 'LEOH2HRD','GEOGTOMD'};
% cases = {'LEOH2HMD', 'GEOTYPMD'};


% flag_PoC: PoC computation method (SMD or BP)
%           0 -> Squared Mahalanobis Distance (SMD)
%           1 -> Bplane Miss Distance (MD)
%           2 -> 3D miss distance
flag_PoC = 0;

if flag_PoC == 0
    disp('Constraint selected: Probability of Collision (PoC)');
elseif flag_PoC == 1
    disp('Constraint selected: Bplane Miss Distance (MD)');
elseif flag_PoC == 2
    disp('Constraint selected: 3D miss distance');
end

% flag_opt: choose optimization constraint strategy to compute states after 
%           manoeuvre:
%           1 -> linearization with STM
%           2 -> propagation of modified states
%           3 -> both methods are used and then compared in terms of
%                absolute/relative error and computational time
flag_opt = 3;

if flag_opt == 1
    disp('Constraint calculation method selected: linearization with STM');
elseif flag_opt == 2
    disp('Constraint calculation method selected: propagation of modified states');
elseif flag_opt == 3
    disp('Constraint calculation method selected: both');
end

% flag_TCAupdate: find the new TCA time inside the optimization process:
%           0 -> no
%           1 -> yes
flag_TCAupdate = 1;

if flag_TCAupdate == 0
    disp('TCA update inside optimization: NO');
elseif flag_TCAupdate == 1
    disp('TCA update inside optimization: YES');
end


% % flag_print: print figures in designated folder
% %           0 -> no
% %           1 -> yes
% flag_print = 0;

%% 
% set collision probability parameters or miss distance constraint
Chan_order = 3;
CAM_var.Chan_order = Chan_order;
if flag_PoC == 0
    PoC_Chan = 1e-6;            CAM_var.PoC_Chan = PoC_Chan;
    PoC_accuracy = 1e-3;        CAM_var.PoC_accuracy = PoC_accuracy;
    n_PoC_iter = 200;           CAM_var.n_PoC_iter = n_PoC_iter;
    d = nan;
elseif  flag_PoC == 1 || flag_PoC == 2
    d = 0.3;                                                                % miss distance (B-plane or 3D) [km]
    con = d^2;
end

CAM_var.d = d;

% Data
mu=398600.433;                                                              % Earth mass parameter [km^3/s^2]

% Bounds on the maneuvering time expressed as fractions of a period
revs_start = 0.1;                                                           % CAM 0.1 periods before TCA
revs_end = 8;                                                               % CAM 8 periods before TCA

% Delta true anomaly range for the manoeuvre
vec = [revs_start:0.1:0.5, 0.75:0.25:8];
n = length(vec);
delta_theta_first_manoeuvre = 2*pi*vec;                                     % Delta true anomaly before TCA

% Simulation settings
Kp = 1;                                                                     % Primary covariance scaling factor
Ks = 1;                                                                     % Secondary covariance scaling factor

for var = 1:length(cases)                                                   % Run CAM simulation for each CDM case
    case_to_run = char(cases(var));                                         % Select case to run

    txt = ['Solving case: ', case_to_run,'...'];
    disp(txt);

    CDM_name = strcat(case_to_run, '.xml');                                 % load CDM file

    %%% CAM planning
    % Extract CDM folder information
    CDM_path_in = fullfile(folder_CDM ,CDM_name);

    % Conjunction definition
    CDM_input_struct = adjust_CDM_XML(CDM_path_in);
    conjunction = objects_definition(CDM_input_struct);                    
    CAM_var.conjunction = conjunction;
    BP_struct = bPlane_quantities(conjunction,Kp,Ks);                       % Struct with Bplane quantities
    BP_struct.Chan_order = Chan_order;
    X0_p = conjunction.object1.mean_state;                                  % Primary position at TCA [km]
    X0_s = conjunction.object2.mean_state;                                  % Secondary position at TCA [km]
    OPM_name_conj = strcat(case_to_run, '_primary.opm');
    OPM_filename = fullfile('OPM', OPM_name_conj);
    OPM_struct = read_OPM(OPM_filename);
    m0  = OPM_struct.mass;
    conjunction.object1.m0 = OPM_struct.mass;                               % Initial primary mass [kg]
    mu = conjunction.mu;                                                    % Earth mass parameter [km^3/s^2]
    CAM_var.mu = mu;
    
    % set values to compute SMD
    if flag_PoC == 0
        BP_struct.Chan_order = Chan_order;
        CDM_input_struct.object1.data.radius = 10e-3;
        CDM_input_struct.object2.data.radius = 5e-3;
        BP_struct.sa = CDM_input_struct.object1.data.radius + CDM_input_struct.object2.data.radius;
        BP_struct.u = BP_struct.sa^2 / (BP_struct.sigma_ksi*BP_struct.sigma_zeta * sqrt(1-BP_struct.rho^2));
        R = CDM_input_struct.object1.data.radius + ...
            CDM_input_struct.object2.data.radius;                           % summed objects radii
        CAM_var.R = R;
        SMD = PoC2SMD(BP_struct.C, R, PoC_Chan, Chan_order, PoC_accuracy, n_PoC_iter);
        con = SMD;
    else
        SMD = nan;
    end

    OUTPUT.(cases{var}).SMD = SMD;
    OUTPUT.(cases{var}).BP_struct = BP_struct;
    OUTPUT_realTCA.(cases{var}).SMD = SMD;
    OUTPUT_realTCA.(cases{var}).BP_struct = BP_struct;
    CAM_var.SMD = SMD;
    
    
    % Objects keplerian elements
    % Primary
    kep_p = car2kep(X0_p(1:3),X0_p(4:6),mu);
    theta_p = kep_p(end);
    OUTPUT.(cases{var}).kep_p = kep_p;
    OUTPUT.(cases{var}).X0_p = X0_p;
    OUTPUT_realTCA.(cases{var}).kep_p = kep_p;
    OUTPUT_realTCA.(cases{var}).X0_p = X0_p;
    
    % Secondary
    kep_s = car2kep(X0_s(1:3),X0_s(4:6),mu);
    theta_s = kep_s(end);
    OUTPUT.(cases{var}).kep_s = kep_s;
    OUTPUT.(cases{var}).X0_s = X0_s;
    OUTPUT_realTCA.(cases{var}).kep_s = kep_s;
    OUTPUT_realTCA.(cases{var}).X0_s = X0_s;


    % Initial maneuvering time
    n_m = length(vec);
    dTime_range = zeros(n_m, 1);
    for k = 1:n
        dTime_range(k) = theta2time(kep_p, BP_struct.th_1-delta_theta_first_manoeuvre(k),mu);
    end

    CAM_var.dTime_range = dTime_range;

    %%% SETTING THE CONSTRAINT USED (MISS DISTANCE OR SMD)
    % Data at TCA for the Primary and the Secondary
    rsc = X0_s(1:3);                                                        % Position of the Secondary at TCA (tc)
    rpc = X0_p(1:3);                                                        % Position of the Primary at TCA (tc)
    vsc = X0_s(4:6);                                                        % Velocity of the Secondary at TCA (tc)
    vpc = X0_p(4:6);                                                        % Velocity of the Primary at TCA (tc)
    CAM_var.rsc = rsc;
    CAM_var.vsc = vsc;

    % B-plane reference frame rotation matrices
    R_B_2d=BP_struct.Rb_2D;                                                 % B-plane projection matrix
    R_B=BP_struct.Rb;                                                       % B-plane overall rotation matrix
    CAM_var.R_B_2d = R_B_2d;

    R_B_2d_2=BP_struct.Rb_2D_2;                                             % B-plane projection matrix
    R_B_2=BP_struct.Rb_2;                                                   % B-plane overall rotation matrix

    % Combined B-plane covariance matrix
    Cp = conjunction.object1.covariance_pos;
    Cs = conjunction.object2.covariance_pos;
    C = BP_struct.C;
    C_2 = BP_struct.C_2;

    % Computation of some quantities for the constraints (primary moves, secondary is fixed)
    M = eye(3);                                                             % Matrix for the CAM solver
    r_hat = rpc-rsc;                                                        % ECI distance between the Primary and the Secondary at TCA [km]

    if flag_PoC==0
        A=R_B_2d'*(C\R_B_2d);                                               % Matrix used for the TCA constraint implementation
        A2=A;                                                               % Matrix computed for the FBC case
        gamma=(r_hat'*A*r_hat)-SMD;                                         % Quantity for the CAM solver

    elseif flag_PoC==1
        A=R_B_2d'*R_B_2d;                                                   % Matrix used for the TCA constraint implementation
        A2=R_B_2d'*(C\R_B_2d);                                              % Matrix computed just to check the PoC reached at TCA with the 3D miss distance imposed
        gamma=(r_hat'*A*r_hat)-d^2;                                         % Quantity for the CAM solver

    elseif flag_PoC==2
        A=eye(3);                                                           % Matrix used for the TCA constraint implementation
        A2=R_B_2d'*(C\R_B_2d);                                              % Matrix computed just to check the PoC reached at TCA with the 3D miss distance imposed
        gamma=(r_hat'*r_hat)-d^2;                                           % Quantity for the CAM solver
    end

    CAM_var.A = A;
    CAM_var.A2 = A2;

    % Computation of some quantities for the constraints (secondary moves, primary is fixed)
    M_2 = eye(3);                                                           % Matrix for the CAM solver
    r_hat_2 = -rpc+rsc;                                                    % ECI distance between the Secondary and the Primary at TCA [km]

    if flag_PoC==0
        A_2=R_B_2d_2'*(C_2\R_B_2d_2);                                               % Matrix used for the TCA constraint implementation
        gamma_2=(r_hat_2'*A_2*r_hat_2)-SMD;                                         % Quantity for the CAM solver

    elseif flag_PoC==1
        A_2=R_B_2d_2'*R_B_2d_2;                                                   % Matrix used for the TCA constraint implementation
        gamma_2=(r_hat_2'*A_2*r_hat_2)-d^2;                                         % Quantity for the CAM solver
    
    elseif flag_PoC==2
        A_2=eye(3);                                                           % Matrix used for the TCA constraint implementation
        gamma_2=(r_hat_2'*r_hat_2)-d^2;                                           % Quantity for the CAM solver
    end

    %%% IMPULSIVE CAM IMPLEMENTATION

    % Time of collision
    tc = 0;
    CAM_var.tc = tc;

    % Vector containing the true anomaly where the manoeuvre is performed
    theta_vec = theta_p - delta_theta_first_manoeuvre;

    % STM initial value and generation of its vectorial form
    phi0 = eye(6);
    phi0_vector = reshape(phi0,[36 1]);

    % time interval
    t_span_b = [tc; -dTime_range]';                                         % For the backward propagation on the nominal orbit

    % Backward integration
    tic
    [~,state_b_p] = STM_prop_mex(mu,t_span_b,[X0_p;phi0_vector],ode_options); % primary state at each of the manoeuvring point 
    [~,state_b_s] = STM_prop_mex(mu,t_span_b,[X0_s;phi0_vector],ode_options); % secondary state at each of the manoeuvering point
    t1 = toc;

    OUTPUT.(cases{var}).init_state_p = state_b_p;                            
    OUTPUT.(cases{var}).init_state_s = state_b_s;
    OUTPUT_realTCA.(cases{var}).init_state_p = state_b_p;                            
    OUTPUT_realTCA.(cases{var}).init_state_s = state_b_s;

    CAM_var.state_b_p = state_b_p;
    CAM_var.state_b_s = state_b_s;

    for k1 = 1:n_m                                                          % Loop for the initial manoeuvre point
        
        tic
        % STM value from tc to tm (t_closest approach to t_manoeuvre)
        Phi_p = reshape(state_b_p(k1+1,7:end),[6 6]);
        Phi_s = reshape(state_b_s(k1+1,7:end),[6 6]);

        % STM rv component from tm to tc
        
        Phi_p_inv = inv(Phi_p);
        Phi_s_inv = inv(Phi_s);

        phi_c_rv_p = Phi_p_inv(1:3,4:6);      CAM_var.phi_c_rv_p = phi_c_rv_p;
        phi_c_rv_s = Phi_s_inv(1:3,4:6);      CAM_var.phi_c_rv_s = phi_c_rv_s;

        phi_c_vv_p = Phi_p_inv(4:6,4:6);      CAM_var.phi_c_vv_p = phi_c_vv_p;
        phi_c_vv_s = Phi_s_inv(4:6,4:6);      CAM_var.phi_c_vv_s = phi_c_vv_s;

        % Computing some quantities for the CAM solver
        beta=phi_c_rv_p'*A*r_hat;
        T=phi_c_rv_p'*A*phi_c_rv_p;
        t2 = toc;

        %%% Solving the non-cooperative CAM where only the primary executes
        %%% the manoeuvre
        tic
        try
            [DV_non_coop, DV_n_non_coop] = CAM_wo_solver_non_dual(gamma,M,beta,T);
        catch
            DV_non_coop=[nan;nan;nan];
            DV_n_non_coop = nan;
        end
        t_non_coop = toc;

        % Save values
        OUTPUT.(cases{var}).('non_coop').t_CPU(k1) = t1/n_m + t2 + t_non_coop;
        OUTPUT_realTCA.(cases{var}).('non_coop').t_CPU(k1) = t1/n_m + t2 + t_non_coop;
        
        OUTPUT = check_and_save(OUTPUT, cases{var}, 'non_coop', k1, ode_options, flag_PoC, BP_struct, CAM_var, DV_non_coop);
        OUTPUT_realTCA = check_and_save_newTCA(OUTPUT_realTCA, cases{var}, 'non_coop', k1, ode_options, flag_PoC, BP_struct, CAM_var, DV_non_coop);


        %%% Solve the non-cooperative CAM where only the secondary executes
        %%% the manoeuvre (to create the initial condition for the
        %%% numerical optimization)
        tic
        beta_2=phi_c_rv_s'*A_2*(r_hat_2);
        T_2=phi_c_rv_s'*A_2*phi_c_rv_s;

        try
            [DV_non_coop_2, DV_n_non_coop_2] = CAM_wo_solver_non_dual(gamma_2,M_2,beta_2,T_2);
        catch
            DV_non_coop_2=[nan;nan;nan];
            DV_n_non_coop_2 = nan;
        end
        t3 = toc;
        
        
        
        %%% Cooperative problem analytically
        if flag_TCAupdate == 0
            tic
            dr_0 = rpc - rsc;
            try
                [DV1_coop_a, DV2_coop_a] = CAM_solver_coop_analytic(dr_0, A, con, phi_c_rv_p, phi_c_rv_s);
            catch
                DV1_coop_a=[nan;nan;nan];
                DV2_coop_a=[nan;nan;nan];
            end
            t_coop_a = toc;

            OUTPUT.(cases{var}).('COOP_ANALYTICAL').t_CPU(k1) = t1/n_m + t2 + t_coop_a;
            OUTPUT_realTCA.(cases{var}).('COOP_ANALYTICAL').t_CPU(k1) = t1/n_m + t2 + t_non_coop;

            OUTPUT = check_and_save(OUTPUT, cases{var}, 'COOP_ANALYTICAL', k1, ode_options, flag_PoC, BP_struct, CAM_var, [DV1_coop_a;DV2_coop_a]);
            OUTPUT_realTCA = check_and_save_newTCA(OUTPUT_realTCA, cases{var}, 'COOP_ANALYTICAL', k1, ode_options, flag_PoC, BP_struct, CAM_var, [DV1_coop_a;DV2_coop_a]);
        
        elseif flag_TCAupdate == 1

            tic
            
            % initialize quantities for the loop
            c_check = inf;
            it = 0;
            dr_0_temp = rpc - rsc;
            A_temp = A;
            con_temp = con;
            tc_temp = tc;

            state_c_f_p_temp = X0_p;
            state_c_f_s_temp = X0_s;

            % Phi_p_temp = inv(Phi_p);
            % Phi_s_temp = inv(Phi_s);
            Phi_p_temp = Phi_p_inv;
            Phi_s_temp = Phi_s_inv;

            Cov1_eci_temp = CAM_var.conjunction.object1.covariance; %Primary [km2]
            Cov2_eci_temp = CAM_var.conjunction.object2.covariance; %Secondary [km2]

            DV1_coop_a = 0;
            DV2_coop_a = 0;

            while c_check > 6.01e-4 %1e-6

                it = it + 1;

                % extract phi 3x3 submatrices
                phi_c_rv_p_temp = Phi_p_temp(1:3,4:6);
                phi_c_rv_s_temp = Phi_s_temp(1:3,4:6);
                
                % solve the it-th coordinated problem 
                try
                    [DV1_coop_a_temp, DV2_coop_a_temp] = CAM_solver_coop_analytic(dr_0_temp, A_temp, con_temp, phi_c_rv_p_temp, phi_c_rv_s_temp);
                catch
                    DV1_coop_a_temp=[nan;nan;nan];
                    DV2_coop_a_temp=[nan;nan;nan];
                end
                
                % if dv1 and dv2 are real, 
                if isnan(norm(DV1_coop_a_temp) + norm(DV2_coop_a_temp))
                    break
                else
                    [c_check, tc_temp, state_c_f_p_temp, state_c_f_s_temp, dr_0_temp, A_temp, ...
                        con_temp, Phi_p_temp, Phi_s_temp, Cov1_eci_temp, Cov2_eci_temp] = ...
                        constraint_check ([DV1_coop_a_temp; DV2_coop_a_temp], CAM_var, state_c_f_p_temp, state_c_f_s_temp, ...
                        Phi_p_temp, Phi_s_temp, Cov1_eci_temp, Cov2_eci_temp, tc_temp, con_temp,flag_PoC);

                    DV1_coop_a = DV1_coop_a + DV1_coop_a_temp;
                    DV2_coop_a = DV2_coop_a + DV2_coop_a_temp;
                end
                
                % %% save values to plot the dv trend
                % temp1_1(it) = norm(DV1_coop_a_temp);
                % temp1_2(it) = norm(DV2_coop_a_temp);
                % temp2_1(it) = norm(DV1_coop_a);
                % temp2_2(it) = norm(DV2_coop_a);
                
            end

            t_coop_a = toc;

% %% plot the dv over the iterations
%             fig_dv_trend = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.3]);
%             set(0,'DefaultTextFontSize',24);
%             set(0,'DefaultAxesFontSize',24);
%             set(0,'DefaultLegendFontSize',24);
%             colors_temp = ["#46a21f", "#7b1fa2", "#3bda07","#EDB120"];
% 
%             subplot(1,2,1)
%             plot(1:1:it, temp1_1*1000, '.--', 'MarkerSize',65, 'LineWidth',1,'Color', colors_temp(2))
%             hold on
%             plot(1:1:it, temp1_2*1000, '.--', 'MarkerSize',45, 'LineWidth',1,'Color', colors_temp(1))
%             set(gca,'yscale','log')
%             grid minor
%             box on
%             xlabel('Iteration')
%             ylabel('$[m/s]$')
%             legend('$\Delta v_1^*$', '$\Delta v_2^*$', 'Location','best')
% 
%             subplot(1,2,2)
%             plot(1:1:it, temp2_1*1000, '.--', 'MarkerSize',65, 'LineWidth',1,'Color', colors_temp(2))
%             hold on
%             plot(1:1:it, temp2_2*1000, '.--', 'MarkerSize',45, 'LineWidth',1,'Color', colors_temp(1))
%             set(gca,'yscale','log')
%             grid minor
%             box on
%             xlabel('Iteration')
%             ylabel('$[m/s]$')
%             legend('$\Delta v_{1,tot}$', '$\Delta v_{2,tot}$', 'Location','best')
% %%


            OUTPUT.(cases{var}).('COOP_ANALYTICAL').t_CPU(k1) = t1/n_m + t2 + t_coop_a;
            OUTPUT_realTCA.(cases{var}).('COOP_ANALYTICAL').t_CPU(k1) = t1/n_m + t2 + t_coop_a;
            OUTPUT_realTCA.(cases{var}).('COOP_ANALYTICAL').iterations(k1) = it;

            OUTPUT = check_and_save(OUTPUT, cases{var}, 'COOP_ANALYTICAL', k1, ode_options, flag_PoC, BP_struct, CAM_var, [DV1_coop_a;DV2_coop_a]);
            OUTPUT_realTCA = check_and_save_newTCA(OUTPUT_realTCA, cases{var}, 'COOP_ANALYTICAL', k1, ode_options, flag_PoC, BP_struct, CAM_var, [DV1_coop_a;DV2_coop_a]);
        

        end


        %%% Solve the cooperative problem numerically
        
        % Set parameters for fmincon optimization
        A_fmincon = [];
        b_fmincon = [];
        Aeq_fmincon = [];
        beq_fmincon = [];
        DV_vect_0 = [0;0;0; 0;0;0];                                         % initial guess for DV1 and DV2
        lb = [-1;-1;-1;-1;-1;-1] * 1e-3;
        ub = [1;1;1;1;1;1] * 1e-3;

        if ~isnan(DV_n_non_coop) && ~isnan(DV_n_non_coop_2)
            DV_vect_0 = [DV_non_coop; DV_non_coop_2]/2;
            lb = [[-1;-1;-1] * DV_n_non_coop; [-1;-1;-1] * DV_n_non_coop_2]/2;                           % lower boundary for DV1 and DV2 components
            ub = [[1;1;1] * DV_n_non_coop; [1;1;1] * DV_n_non_coop_2]/2; 
        end        

        % run optimization
        if flag_opt == 1 || flag_opt == 3                                   % linearization to compute constraint
            tic
            % run optimization
            [DV_vect_opt_coop, DV_tot_opt_coop] = fmincon(@(DV_vect) dv_tot(DV_vect), ...
                DV_vect_0, A_fmincon, b_fmincon, Aeq_fmincon, beq_fmincon, lb, ub, ...
                @(DV_vect) opt_constraints(DV_vect, X0_p, X0_s,...
                CAM_var, flag_PoC, flag_TCAupdate), fmincon_options);
            t_opt_STM = toc;

            OUTPUT.(cases{var}).('STM').t_CPU(k1) = t1/n_m + t2 + t3 + t_non_coop + t_opt_STM;                 % [s]
            OUTPUT_realTCA.(cases{var}).('STM').t_CPU(k1) = t1/n_m + t2 + t3 + t_non_coop + t_opt_STM;                 % [s]

            % save values
            OUTPUT = check_and_save(OUTPUT, cases{var}, 'STM', k1, ode_options, flag_PoC, BP_struct, CAM_var, DV_vect_opt_coop);
            OUTPUT_realTCA = check_and_save_newTCA(OUTPUT_realTCA, cases{var}, 'STM', k1, ode_options, flag_PoC, BP_struct, CAM_var, DV_vect_opt_coop);
            
        end

        if flag_opt == 2 || flag_opt == 3                                   % state propagation to compute constraint
            tic
            % run optimization
            [DV_vect_opt_coop, DV_tot_opt_coop] = fmincon(@(DV_vect) dv_tot(DV_vect), ...
                DV_vect_0, A_fmincon, b_fmincon, Aeq_fmincon, beq_fmincon, lb, ub, ...
                @(DV_vect) opt_constraints2(DV_vect, state_b_p(k1+1,1:6)', state_b_s(k1+1,1:6)', ...
                mu, -dTime_range(k1), tc, A, d, SMD, ode_options, flag_PoC, flag_TCAupdate, CAM_var), fmincon_options);
            t_opt_prop = toc;

            OUTPUT.(cases{var}).('PROP').t_CPU(k1) = t1/n_m + t2 + t3 + t_non_coop + t_opt_prop;                 % [s]
            OUTPUT_realTCA.(cases{var}).('PROP').t_CPU(k1) = t1/n_m + t2 + t3 + t_non_coop + t_opt_prop;                 % [s]

            % save values
            OUTPUT = check_and_save(OUTPUT, cases{var}, 'PROP', k1, ode_options, flag_PoC, BP_struct, CAM_var, DV_vect_opt_coop);
            OUTPUT_realTCA = check_and_save_newTCA(OUTPUT_realTCA, cases{var}, 'PROP', k1, ode_options, flag_PoC, BP_struct, CAM_var, DV_vect_opt_coop);

        end
    end
    disp('CAM solved');
end


%% plot settings
% set(0,'DefaultTextFontSize',20);
% set(0,'DefaultAxesFontSize',20);
% set(0,'DefaultLegendFontSize',20);
set(0,'DefaultLegendInterpreter','Latex');
set(0,'DefaultAxesTickLabelInterpreter','Latex');
set(0,'DefaultTextInterpreter','Latex');
colors = ["#DB073D", "#FF6600", "#FFD10F", "#168039", "#002253", "#00ABD8", "#9575CD"]; % https://colordesigner.io/color-scheme-builder?mode=lch#DB073D-FF6600-FFD10F-168039-002253-00ABD8-9575CD
%colors_comp = ["#0072BD", "#D95319", "#EDB120"]; % blue, red, yellow
colors_comp = ["#da073b", "#073bda", "#3bda07","#EDB120"]; % red, blue, green, yellow


% close all
case_index = 2;


if flag_TCAupdate == 0
    [fig_dv_opt, fig_dv_analytic, fig_dv_comp,fig_dv_comp_all, fig_relerr_opt, fig_relerr_analytic, ...
        fig_3D2D_opt, fig_3D2D_opt_all, fig_3D2D_analytic, fig_3D2D_analytic_all, fig_CPUtime_opt, fig_CPUtime_analytic, fig_avgcputime, fig_merit_index] = ...
        PLOT_DV_ERR_TIME(OUTPUT, cases, case_index, vec, colors, colors_comp, flag_PoC, flag_opt, CAM_var, flag_TCAupdate);
    [fig_TCAtime_comp, fig_TCAtime_comp_all, fig_dis_tcnom_tcreal_opt, fig_dis_tcnom_tcreal_analytical, ~, ...
        fig_relerr_opt_realT, fig_relerr_analytic_realT] = PLOT_REALT(OUTPUT_realTCA, cases,case_index, vec, colors,colors_comp, flag_TCAupdate, flag_PoC);
   
elseif flag_TCAupdate == 1
    [fig_dv_opt, fig_dv_analytic, fig_dv_comp, fig_dv_comp_all, fig_relerr_opt, fig_relerr_analytic, ...
        fig_3D2D_opt, fig_3D2D_opt_all, fig_3D2D_analytic, fig_3D2D_analytic_all, fig_CPUtime_opt, fig_CPUtime_analytic, fig_avgcputime, fig_merit_index] = ...
        PLOT_DV_ERR_TIME(OUTPUT_realTCA, cases, case_index, vec, colors, colors_comp, flag_PoC, flag_opt, CAM_var, flag_TCAupdate);
    [fig_TCAtime_comp, fig_TCAtime_comp_all, fig_dis_tcnom_tcreal_opt, fig_dis_tcnom_tcreal_analytical, fig_it_NLP_TCAupd, ...
        ~, ~] = PLOT_REALT(OUTPUT_realTCA, cases,case_index, vec, colors,colors_comp, flag_TCAupdate, flag_PoC);
end



%%
flag_print = 0;

if flag_print == 1

    if flag_TCAupdate == 0
        if flag_PoC == 2
            folder_figures = fullfile(pwd, "Figures/3D-noTCAupd");
        elseif flag_PoC == 1
            folder_figures = fullfile(pwd, "Figures/BP-noTCAupd");
        elseif flag_PoC == 0
            folder_figures = fullfile(pwd, "Figures/PoC-noTCAupd");
        end
    elseif flag_TCAupdate == 1
        if flag_PoC == 2
            folder_figures = fullfile(pwd, "Figures/3D-TCAupd");
        elseif flag_PoC == 1
            folder_figures = fullfile(pwd, "Figures/BP-TCAupd");
        elseif flag_PoC == 0
            folder_figures = fullfile(pwd, "Figures/PoC-TCAupd");
        end
    end
    
    
    exportgraphics(fig_dv_opt, fullfile(folder_figures, 'dv_STMopt.pdf'), 'ContentType', 'vector');
    exportgraphics(fig_dv_analytic, fullfile(folder_figures, 'dv_analytic.pdf'), 'ContentType', 'vector');
    exportgraphics(fig_dv_comp, fullfile(folder_figures, 'dv_comp_LEOH2HRD.pdf'), 'ContentType', 'vector');
    exportgraphics(fig_dv_comp_all, fullfile(folder_figures, 'dv_comp_all.pdf'), 'ContentType', 'vector');
    exportgraphics(fig_relerr_opt, fullfile(folder_figures, 'relerr_STMopt.pdf'), 'ContentType', 'vector');
    exportgraphics(fig_relerr_analytic, fullfile(folder_figures, 'relerr_analytic.pdf'), 'ContentType', 'vector');
    % exportgraphics(fig_3D2D_opt, fullfile(folder_figures, '3D2D_STMopt_LEOH2HRD.pdf'), 'ContentType', 'vector');
    % exportgraphics(fig_3D2D_opt_all, fullfile(folder_figures, '3D2D_STMopt_all.pdf'), 'ContentType', 'vector');
    % exportgraphics(fig_3D2D_analytic, fullfile(folder_figures, '3D2D_analytic_LEOH2HRD.pdf'), 'ContentType', 'vector');
    % exportgraphics(fig_3D2D_analytic_all, fullfile(folder_figures, '3D2D_analytic_all.pdf'), 'ContentType', 'vector');
    exportgraphics(fig_CPUtime_opt, fullfile(folder_figures, 'CPUtime_STMopt.pdf'), 'ContentType', 'vector');
    exportgraphics(fig_CPUtime_analytic, fullfile(folder_figures, 'CPUtime_analytic.pdf'), 'ContentType', 'vector');
    exportgraphics(fig_avgcputime, fullfile(folder_figures, 'avgcputime.pdf'), 'ContentType', 'vector');
    exportgraphics(fig_merit_index, fullfile(folder_figures, 'merit_index.pdf'), 'ContentType', 'vector');

    exportgraphics(fig_TCAtime_comp, fullfile(folder_figures, 'TCAtime_LEOH2HRD.pdf'), 'ContentType', 'vector');
    exportgraphics(fig_TCAtime_comp_all, fullfile(folder_figures, 'TCAtime_all.pdf'), 'ContentType', 'vector');
    exportgraphics(fig_dis_tcnom_tcreal_opt, fullfile(folder_figures, 'dis_tcnom_tcreal_STMopt.pdf'), 'ContentType', 'vector');
    exportgraphics(fig_dis_tcnom_tcreal_analytical, fullfile(folder_figures, 'dis_tcnom_tcreal_analytical.pdf'), 'ContentType', 'vector');

    if flag_TCAupdate == 0
        exportgraphics(fig_relerr_opt_realT, fullfile(folder_figures, 'relerr_STMopt_realT.pdf'), 'ContentType', 'vector');
        exportgraphics(fig_relerr_analytic_realT, fullfile(folder_figures, 'relerr_analytic_realT.pdf'), 'ContentType', 'vector');
    elseif flag_TCAupdate == 1
        exportgraphics(fig_it_NLP_TCAupd, fullfile(folder_figures, 'it_NLP_TCAupd.pdf'), 'ContentType', 'vector');
    end

    disp('Figures printed: YES')
else
    disp('Figures printed: NO')
end 


% %% Plot orbits
% % Orbit Representation
% set(0,'DefaultTextFontSize',28);
% set(0,'DefaultAxesFontSize',28);
% set(0,'DefaultLegendFontSize',28);
% set(0,'DefaultLegendInterpreter','Latex');
% set(0,'DefaultAxesTickLabelInterpreter','Latex');
% set(0,'DefaultTextInterpreter','Latex');
% 
% object = ["primary.png", "secondary.png"];
% colors = ["#DB073D", "#FF6600", "#FFD10F", "#168039", "#002253", "#00ABD8", "#9575CD"]; % https://colordesigner.io/color-scheme-builder?mode=lch#DB073D-FF6600-FFD10F-168039-002253-00ABD8-9575CD
% for kk = 1:2
%     fig = figure('Units', 'normalized', 'Position', [0, 0, 0.8, 0.6]);
%     r = 6378;
%     [X,Y,Z]=sphere(100);
%     X2 = X.*r;
%     Y2 = Y.*r;
%     Z2 = -Z.*r;
%     s =surf(X2,Y2,Z2,'FaceColor','None');
%     az = 134;
%     el = 20;
%     view(az,el);
%     image=imread('data/EarthTexture','jpeg');
%     set(s,'FaceColor','texturemap','CData',image);
%     set(s,'linestyle','none','CData',image);
%     axis equal
%     hold on
%     for ii = 1: length(cases)
%         if kk ==1
%             t_p = 2*pi*sqrt(OUTPUT.(cases{ii}).kep_p(1)^3/mu);
%             [time_prop, x_prop] = dynamics_propagation_kep(mu, [0 t_p],  OUTPUT.(cases{ii}).init_state_p(1,1:6)', ode_options);
%         else
% 
%             t_s = 2*pi*sqrt(OUTPUT.(cases{ii}).kep_s(1)^3/mu);
%             [time_prop, x_prop] = dynamics_propagation_kep(mu, [0 t_s], OUTPUT.(cases{ii}).init_state_s(1,1:6)', ode_options);
%         end
% 
%         if ii == 6
%             if kk == 1
%                 plot3(x_prop(:,2), -x_prop(:,1), x_prop(:,3),'Color',colors(ii),'LineWidth',10);
%             else
%                 plot3(x_prop(:,2), -x_prop(:,1), x_prop(:,3),'Color',colors(ii), 'LineStyle', '-','LineWidth',10);
%             end
% 
%         elseif ii == 7
%             if kk == 1
%                 plot3(x_prop(:,2), -x_prop(:,1), x_prop(:,3),'Color',colors(ii),'LineWidth',6);
%             else
%                 plot3(x_prop(:,2), -x_prop(:,1), x_prop(:,3),'Color',colors(ii), 'LineStyle', '-','LineWidth',6);
%             end
%         elseif ii ==1
%             plot3(x_prop(:,2), -x_prop(:,1), x_prop(:,3),'Color',colors(ii),'LineWidth',9);
%         elseif ii ==2
%             plot3(x_prop(:,2), -x_prop(:,1), x_prop(:,3),'Color',colors(ii),'LineWidth',9);
% 
%         elseif ii ==3
%             plot3(x_prop(:,2), -x_prop(:,1), x_prop(:,3),'Color',colors(ii),'LineWidth',5);
% 
%         elseif ii == 5
%             if kk == 1
%                 plot3(x_prop(:,2), -x_prop(:,1), x_prop(:,3),'Color',colors(ii),'LineWidth',11-ii);
%             else
%                 plot3(x_prop(:,2), -x_prop(:,1), x_prop(:,3),'Color',colors(ii), 'LineStyle', '-','LineWidth',11-ii);
%             end
%         else
%             if kk == 1
%                 plot3(x_prop(:,2), -x_prop(:,1), x_prop(:,3),'Color',colors(ii),'LineWidth',9-ii);
%             else
%                 plot3(x_prop(:,2), -x_prop(:,1), x_prop(:,3),'Color',colors(ii), 'LineStyle', '-','LineWidth',9-ii);
%             end
%         end
%     end
%     xlabel('x [km]','Interpreter', 'latex');
%     ylabel('y [km]','Interpreter', 'latex');
%     zlabel('z [km]','Interpreter', 'latex');
%     xlabel('x [km]','Interpreter', 'latex');
%     ylabel('y [km]','Interpreter', 'latex');
%     zlabel('z [km]','Interpreter', 'latex');
%     view(az, el)
%     box on
%     grid minor
%     legend('', cases{1},cases{2},cases{3},cases{4},cases{5},cases{6},cases{7}, 'Location','eastoutside');
%     exportgraphics(fig, fullfile(folder_figures, object(kk)), 'ContentType', 'vector','Resolution', 250);
% end

% %% print orbit parameters
% clc
% format longG
% 
% for ii = 1: length(cases)
%     ii
%     car2kep_state(OUTPUT.(cases{ii}).init_state_s(1,1:6)', mu)
% end