function[lr0,lv0,time_EOP,state_EOP]=EOP_FBC_solver(t0,tf,r0,v0,rf,vf,mu,a_max,...
                                                    lr00,lv00,check,options_int,...
                                                    PHI_EOP,state_EOP_old,t0_old,tf_old)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROTOTYPE:
%   [lr0,lv0,time_EOP,state_EOP]=EOP_FBC_solver(t0,tf,r0,v0,rf,vf,mu,a_max,...
%                                               lr00,lv00,check,options_int,...
%                                               PHI_EOP,state_EOP_old,t0_old,tf_old
%--------------------------------------------------------------------------
% DESCRIPTION: 
%   Function used to solve the Energy Optimal Problem (EOP) associated with
%   a two-point boundary value problem (fixed initial state and fixed final 
%   state) in a semi-analytical way for the finite burn conversion analysis.
%   The TPBVP is transformed into an IVP using the STM mapping.
%--------------------------------------------------------------------------
% INPUT:
%   t0[1]                 Initial time                  [s]
%   tf[1]                 Final time                    [s]
%   r0[3x1]               Initial point position vector [km] 
%   v0[3x1]               Initial point velocity vector [km]
%   rf[3x1]               Final point position vector   [km/s]
%   vf[3x1]               Final point velocity vector   [km/s]
%   mu[1]                 Earth mass parameter          [km^3/s^2]
%   a_max[1]              Maximum acceleration          [km/s^2] 
%   lr00[3x1]             Initial position costate      [-]
%   lv00[3x1]             Initial velocity costate      [-]
%   check[1]              Value used to check at what iteration fsolve
%                         is. In particular if check=0 then fsolve is at
%                         its first iteration
%   options_int[1]        Integrator options 
%   PHI_EOP[12x12]        STM from t0 to tf associated with the first 
%                         fsolve iteration
%   state_EOP_old[Nx156]  EOP state associated with the first fsolve
%                         iteration
%   t0_old[1]             Initial time associated with the first fsolve
%                         iteration                     [s]
%   tf_old[1]             final time associated with the first fsolve
%                         iteration                     [s]
%--------------------------------------------------------------------------
% OUTPUT:
%   lro[3x1]            Initial position costate estimate [-]
%   lv0[3x1]            Initial velocity costate estimate [-]
%   time_EOP[Nx1]       Vector containing the last EOP integration time instances 
%   state_EOP[Nx156]    Vector containing the last EOP integration states  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initial value for the STM
phi_vec_0=reshape(eye(12),[144,1]);

if check==0 % For the first iteration of fsolve

    % Propagate the state and the STM on the nominal orbit for the EOP
    [~,state_n]=NEOP_solver_with_STM_mex(mu,linspace(t0,tf,3),[r0;v0;lr00;lv00;phi_vec_0],a_max,options_int);

    % Final state on the nominal orbit
    rfn=state_n(end,1:3)';
    vfn=state_n(end,4:6)';

    % STM associated with the nominal orbit
    phi=reshape(state_n(end,13:end),[12,12]);
    phi13=phi(1:3,7:9);
    phi14=phi(1:3,10:12);
    phi23=phi(4:6,7:9);
    phi24=phi(4:6,10:12);

    % Final state variation
    drf=rf-rfn;
    dvf=vf-vfn;
end

% Internal loop used to correct step by step the procedure for the
% solution of the EOP using the STM 
iter=0;         % Initial value for iter
err_r_max=1e-5; % Maximum error on the position for the while loop [m]
err_v_max=1e-7; % Maximum error on the velocity for the while loop [m/s]
err_r=1;        % Initial error on the position
err_v=1;        % Initial error on the velocity
max_iter=50;    % Maximum number of iterations for the while loop
flag=0;         % Internal flag for the while loop

while (err_r>err_r_max || err_v>err_v_max) && iter < max_iter
    
    if check==0 || flag~=0  % For the first iteration of fsolve or for the
        % iterations different from the first one of the while loop 
        
        % Initial costates estimation through STM 
        lv0=(phi24-phi23*(phi13\phi14))\(dvf-phi23*(phi13\drf))+lv00;
        lr0=(phi13)\(drf-phi14*(lv0-lv00))+lr00;
        
    else
        
        % Initial costates estimation
        lv0=lv00;
        lr0=lr00;
        
    end

    flag=flag+1;
    if check==0  % For the first iteration of fsolve
        
        % Solve the Energy Optimal Problem (EOP)
        [time_EOP,state_EOP]=EOP_solver_with_STM_mex(mu,linspace(t0,tf,1000),[r0;v0;lr0;lv0;phi_vec_0],a_max,options_int);
        
        % Update the final state variation
        drf=rf-state_EOP(end,1:3)';
        dvf=vf-state_EOP(end,4:6)';

        % STM computed on the new EOP orbit
        phi=reshape(state_EOP(end,13:end),[12,12]);
        phi13=phi(1:3,7:9);
        phi14=phi(1:3,10:12);
        phi23=phi(4:6,7:9);
        phi24=phi(4:6,10:12);

    else
        
        % Solve the Energy Optimal Problem (EOP) for the new segments 
        [~,state_EOP1]=EOP_solver_with_STM_mex(mu,linspace(t0,t0_old,3),[r0;v0;lr0;lv0;phi_vec_0],a_max,options_int);
        dstate0_1=state_EOP1(end,1:12)'-state_EOP_old(1,1:12)';
        state0_2=state_EOP_old(end,1:12)'+PHI_EOP*dstate0_1;
        [~,state_EOP2]=EOP_solver_with_STM_mex(mu,linspace(tf_old,tf,3),[state0_2;phi_vec_0],a_max,options_int);
        
        % Update the final state variation
        drf=rf-state_EOP2(end,1:3)';
        dvf=vf-state_EOP2(end,4:6)';
       
        % STM composition
        phi=reshape(state_EOP2(end,13:end),[12,12])*PHI_EOP*reshape(state_EOP1(end,13:end),[12,12]);
        phi13=phi(1:3,7:9);
        phi14=phi(1:3,10:12);
        phi23=phi(4:6,7:9);
        phi24=phi(4:6,10:12);
        
    end

    % Update the initial costate on the EOP orbit found
    lr00=lr0;
    lv00=lv0;
        
    % Update error value
    err_r=norm(drf)*1000;   % [m]
    err_v=norm(dvf)*1000;   % [m/s]

    % Update the number of iterations
    iter=iter+1;
    
    if check~=0 % No first iteration for fsolve
       time_EOP=0;
       state_EOP=0;
    end
    
end 


end