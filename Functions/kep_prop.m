function [t, x] = kep_prop(mu, t_span_b, x_0, ode_options)
    % Define the ODE function
    ode_func = @(t, x) kep(t, x, mu);

    % Solve the ODE using ode45
    [t, x] = ode78(ode_func, t_span_b, x_0, ode_options);
end


function[dxdt]=kep(~,x,mu)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROTOTYPE:
%   [dxdt]=TBP(t,x,mu,check)
%--------------------------------------------------------------------------
% DESCRIPTION: 
%   Function used to build the dynamics of the restricted two-body problem. 
%   Also the STM could be propagated.
%--------------------------------------------------------------------------
% INPUT:
%   t[1]            Time
%   x[42x1]         State vector: It could contain also the state
%                   transition matrix (STM) terms
%   mu[1]           Earth mass parameter [km^3/s^2]
%   check[1]        Value used to select if also the STM needs to be
%                   included in the dynamics. In particular:
%                   check==1 the dynamics contains also the STM terms  
%--------------------------------------------------------------------------
% OUTPUT:
%   dxdt[42x1]      System dynamics   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% State 
r = x(1:3);
v = x(4:6);

% Norm of the position
r_norm = norm(r);

% Dynamics implementation
dxdt = [   v(1);
    v(2);
    v(3);
    -mu/(r_norm^3)*r(1);
    -mu/(r_norm^3)*r(2);
    -mu/(r_norm^3)*r(3)];
  
end