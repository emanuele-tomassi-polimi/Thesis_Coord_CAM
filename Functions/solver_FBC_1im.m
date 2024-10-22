function[Y,state_FMP]=solver_FBC_1im(DV,rm,vm,Delta_t0,mu,a_max,t_m,...
                                     PoC_struct,options_int,check_TCA_const)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROTOTYPE:
%   [Y,state_FMP]=solver_FBC_1im(DV,rm,vm,Delta_t0,mu,a_max,t_m,...
%                                PoC_struct,options_int,check_TCA_const)
%--------------------------------------------------------------------------
% DESCRIPTION: 
%   Function used to find the thrust arc length that allows to fit the
%   constraints at a final time instance. The thrust arc is obtained
%   through a finite burn conversion (FBC) used on an impulsive manoeuvre.
%   This function works for a 1-impulse CAM without return.
%--------------------------------------------------------------------------
% INPUT:
%   DV[3x1]             Impulsive manoeuvre vector       [km/s]
%   rm[3x1]             Position vector associated with the point where the
%                       impulsive manouevre is done      [km]
%   vm[3x1]             Velocity vector associated with the point where the
%                       impulsive manouevre is done      [km/s]
%   Delta_t0[1]         Initial guess for the arc length [s]
%   mu[1]               Earth mass parameter             [km^3/s^2]
%   a_max[1]            Maximum acceleration             [km/s^2]
%   tm[1]               Time when the impulsive manoeuvre is performed [s]
%   PoC_struct[1]       Structure containing 3 elements:
%                       _ SMD=SMD to be reached at TCA
%                       _ A=matrix used for the constraint computation A=R_B_2d'*(C\R_B_2d); 
%                       _ u=Ratio of the impact cross-sectional area to 
%                         the area of the 1σ covariance ellipse in the B-plane 
%                       _ rsc= secondary position vector at TCA [km]
%                       Put to 0 this value if check_TCA_const=0
%   options_int[1]      Integrator options 
%   check_TCA_const[1]  Value used to identify what constraint to use at
%                       TCA. In particular:
%                       _ check_TCA_const=0 means that the TCA constraint
%                       is a state error (position and velocity)
%                       _ check_TCA_const=1 means that the TCA constraint
%                       is a PoC error 
%--------------------------------------------------------------------------
% OUTPUT:
%   Y[1]                Solution of fsolve (it is the thrust arc duration) [s]
%   state_FMP[Nx12]     State vector associated with the thrust arc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialization of some variables (they are used to collect some terms at
% the end of the fsolve computation in order to return the desired output)
flag=1;
STATE=cell(1);
Delta_t_vector=zeros(1,1);

% These variables are here introduced and they will change their values
% every time a new iteration of fsolve is done (they are used to speed up
% the code avoiding to compute the same quantities more than one time)
lr00=[0;0;0]; % Initial position constate on the nominal orbit
lv00=[0;0;0]; % Initial velocity constate on the nominal orbit
check=0;      % Flag used to count the fsolve iterations
rm_b=rm;      % Initial position for the backward propagation
vm_b=vm;      % Initial velocity for the backward propagation
rm_f=rm;      % Initial position for the forward propagation
vm_f=vm+DV;   % Initial velocity for the forward propagation
t00=0;        % Initial time for the backward propagation
tf0=0;        % Initial time for the forward propagation
phi_corr=0;   % STM used for a correction

% These variables are used to store some quantities of the Energy Optimal
% Problem (EOP) associated with the first fsolve iteration (they are used
% to speed up the code avoiding to compute the same quantities more than one time)
PHI_EOP=0;       % Initialization EOP STM
state_EOP_old=0; % Initialization EOP state 
t0_old=0;        % Initialization EOP initial time 
tf_old=0;        % Initialization EOP final time

% Propagation until reaching the arrival state at TCA after performing the
% impulsive CAM
[~,state_TCA]=TBP_solver_with_STM_2_mex(mu,[0 t_m],[rm_f;vm_f;reshape(eye(6),[36,1])],options_int);

% STM from tm to tc (TCA)
PHI=reshape(state_TCA(end,7:end),[6,6]);

% Definition of the function for which to find the zeros
fun=@(unknown)ff1(unknown);

    % Nested function
    function[F]=ff1(unknown)   
        
        % Initial and final time for the thrust arc (time=0 is the impulsive manoeuvre point)
        t0=-unknown/2;
        tf=unknown/2;          

        % Backward propagation
        [time_b,state_b]=TBP_solver_2_mex(mu,[t00 t0],[rm_b;vm_b],options_int);
        rb=state_b(end,1:3)';
        vb=state_b(end,4:6)';

        % Update the quantities for the next fsolve iteration
        rm_b=state_b(end-1,1:3)';
        vm_b=state_b(end-1,4:6)';
        t00=time_b(end-1);
        
        % Forward propagation after the impulsive manoeuvre
        [time_fi,state_fi]=TBP_solver_with_STM_2_mex(mu,[tf0 tf],[rm_f;vm_f;reshape(eye(6),[36,1])],options_int);
        rfi=state_fi(end,1:3)';
        vfi=state_fi(end,4:6)';
        if check==0
            PHI=PHI/(reshape(state_fi(end,7:end),[6,6]));
        else
            PHI=PHI/(reshape(state_fi(end,7:end),[6,6])/phi_corr);
        end
         phi_corr=(reshape(state_fi(end,7:end),[6,6]))/(reshape(state_fi(end-1,7:end),[6,6]));
        
        % Update the quantities for the next fsolve iteration
        rm_f=state_fi(end-1,1:3)';
        vm_f=state_fi(end-1,4:6)';
        tf0=time_fi(end-1);
        
        % Solving the Energy optimal problem from t0 to tf
        [lr0,lv0,time_EOP,state_EOP]=EOP_FBC_solver(t0,tf,rb,vb,rfi,vfi,mu,a_max,lr00,lv00,...
                                                    check,options_int,PHI_EOP,state_EOP_old,t0_old,tf_old);
        if check==0 % First iteration of fsolve
           % Collecting the quantities for the next iterations
           PHI_EOP=reshape(state_EOP(end,13:end),[12,12]);
           state_EOP_old=state_EOP;
           t0_old=t0;
           tf_old=tf;

%            % Plot the command parameter           
%            [s1,~]=size(state_EOP);
%            lv_vec=zeros(3,s1);
%            u_vec=zeros(1,s1);
%            for k=1:s1
%                lv_vec(:,k)=state_EOP(k,10:12)';
%                u_vec(k)=a_max*norm(lv_vec(:,k))/2;
%            end
%            figure()
%            plot(time_EOP,u_vec,'color','#0072BD','linewidth',2)
%            xlabel('Time [s]')
%            ylabel('u [-]')
%            grid on

        end
        check=check+1;
        lr00=lr0;
        lv00=lv0;    
        
        % Set the command parameter to 1
        [~,state_FMP]=FMP_solver_mex(mu,linspace(t0,tf,100),[rb;vb;lr0;lv0],a_max,1,options_int);
        
        % State error computation at TCA and PoC computation at TCA:
        
        rf=state_FMP(end,1:3)'; % Position at the end of the thrust arc
        vf=state_FMP(end,4:6)'; % Velocity at the end of the thrust arc
     
        % Mapp the state variation from tf to tc (TCA)
        dr0=rf-state_fi(end,1:3)';
        dv0=vf-state_fi(end,4:6)';
        dXf=PHI*[dr0;dv0];
        
        % Errors
        error_pos=norm(dXf(1:3))*1000;    % [m]
        error_vel=norm(dXf(4:6))*1000;    % [m/s]
        
        if check_TCA_const==0                     
            % TCA constraint error based on the state
            constraint1=error_pos; %[m]
            constraint2=error_vel; %[m/s]
            
            % Implementation of the F function
            F=[constraint1;constraint2]; 
        else 
            % TCA constraint error based on the SMD 
            r_arr=dXf(1:3)+state_TCA(end,1:3)';
            constraint1=(r_arr-PoC_struct.rsc)'*PoC_struct.A*(r_arr-PoC_struct.rsc)-PoC_struct.SMD;
             
            % Implementation of the F function
            F=constraint1; 
        end
       
        % Collect arc state propagation
        STATE{flag}=state_FMP;
      
        % Collect the arc length
        Delta_t_vector(flag)=unknown;
        
        % Update the flag
        flag=flag+1;

    end

% Initial guess for "fsolve"
initial_guess=Delta_t0;

% Solve the problem with "fsolve"
options=optimoptions('fsolve','FunctionTolerance',1e-16,'MaxFunctionEvaluations',20000,...
                     'StepTolerance',1e-6,'Display','off','Algorithm','levenberg-marquardt');
[Y,~,~]=fsolve(fun,initial_guess,options);

indx=Delta_t_vector==Y;

% Obtaining the state associated with the thrust arc
state_FMP=STATE{indx};

end