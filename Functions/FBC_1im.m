function[Delta_t_real,Delta_t_ideal,...
         CPU_time,state_FMP]=FBC_1im(mu,initial_position,initial_velocity,...
                                     a_max,DV_norm,DV,tm,tc,options_int,...
                                     PoC_struct,check_TCA_const)
                              
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROTOTYPE:
%   [Delta_t_real,Delta_t_ideal,...
%    CPU_time,state_FMP]=FBC_1im(mu,initial_position,initial_velocity,...
%                                a_max,DV_norm,DV,tm,tc,options_int,...
%                                PoC_struct,check_TCA_const)
%--------------------------------------------------------------------------
% DESCRIPTION: 
%   Function used to solve the finite burn conversion problem.
%   Here the problem is solved using fsolve. the unknown variable is the
%   thrust arc duration.
%   The thrust arc is tuned with the aim of targetting a precise state or 
%   PoC at TCA.
%   This function works for 1-impulse CAM without return.
%--------------------------------------------------------------------------
% INPUT:
%   mu[1]                  Earth mass parameter            [km^3/s^2]
%   initial_position[3x1]  Position vector associated with the point where the
%                          impulsive manouevre is done     [km]
%   initial_velocity[3x1]  Velocity vector associated with the point where the
%                          impulsive manouevre is done     [km/s] 
%   a_max[1]               Maximum acceleration            [km/s^2]
%   DV_norm[1]             Norm of the impulsive manoeuvre [km/s]
%   DV[3x1]                Impulsive manoeuvre vector      [km/s]
%   tm[1]                  Time when the impulsive manoeuvre is performed [s]
%   tc[1]                  Time of collision               [s]
%   options_int[1]         Integrator options 
%   PoC_struct[1]          Structure containing 3 elements:
%                          _ SMD=SMD to be reached at TCA
%                          _ A=matrix used for the constraint computation A=R_B_2d'*(C\R_B_2d); 
%                          _ u=Ratio of the impact cross-sectional area to 
%                            the area of the 1σ covariance ellipse in the B-plane
%                          _ rsc= secondary position vector at TCA [km]
%                          Put to 0 this value if check_TCA_const=0
%   check_TCA_const[1]     Value used to identify what constraint to use at
%                          TCA. In particular:
%                          _ check_TCA_const=0 means that the TCA constraint
%                          is a state error (position and velocity)
%                          _ check_TCA_const=1 means that the TCA constraint
%                          is a PoC error 
% 
%--------------------------------------------------------------------------
% OUTPUT:
%   Delta_t_real[1]     Real thrust arc duration     [s]
%   Delta_t_ideal[1]    Ideal thrust arc duration    [s]
%   CPU_time[1]         Time for the computation     [s]
%   state_FMP[Nx12]     State vector associated with the thrust arc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tic

% Thrust arc length estimation
Delta_t=(DV_norm/a_max);
Delta_t_ideal=Delta_t;

% Final time (time 0 is the impulsive manoeuvre point)
tf=Delta_t/2;

% Check the feasibility of the manoeuvre
% (i.e. verify that the thrust arc time extension does not overcome the TCA)
if  (-tm+tf)>tc  

    % Update some data
    Delta_t_real=0;
    CPU_time=0; 
    state_FMP=0;
    return

end  

% Position and velocity of the impulsive manoeuvre 
rm=initial_position;
vm=initial_velocity;
   
% Solve the problem
[sol,state_FMP]=solver_FBC_1im(DV,rm,vm,Delta_t,mu,a_max,tm,PoC_struct,options_int,check_TCA_const);   

% New Delta_t
Delta_t_new=sol;

% Check the feasibility of the manoeuvre with the new Delta_t
if  (-tm+Delta_t_new/2)>tc  

    % Update some data
    Delta_t_real=0;
    CPU_time=0; 
    state_FMP=0;
    return

end  

% Update some data
Delta_t_real=Delta_t_new;
CPU_time=toc; 

end
