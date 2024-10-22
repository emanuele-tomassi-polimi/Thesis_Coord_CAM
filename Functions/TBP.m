function[dxdt]=TBP(~,x,mu,check)

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

if check==1 % Propagation of state+STM

    % Initial STM 
    phi_vector=x(7:end);
    phi=reshape(phi_vector,[6 6]);

    % Definition of the A matrix
    % Observation: A = df/dx(x*) where f is the dynamics function
    a41=3*mu/(r_norm^5)*(r(1)^2)-mu/(r_norm^3);
    a42=3*mu/(r_norm^5)*r(1)*r(2);
    a43=3*mu/(r_norm^5)*r(1)*r(3);
    a51=3*mu/(r_norm^5)*r(1)*r(2);
    a52=3*mu/(r_norm^5)*(r(2)^2)-mu/(r_norm^3);
    a53=3*mu/(r_norm^5)*r(2)*r(3);
    a61=3*mu/(r_norm^5)*r(1)*r(3);
    a62=3*mu/(r_norm^5)*r(2)*r(3);
    a63=3*mu/(r_norm^5)*(r(3)^2)-mu/(r_norm^3);

    A=[0,  0,  0,  1,0,0;
       0,  0,  0,  0,1,0;
       0,  0,  0,  0,0,1;
       a41,a42,a43,0,0,0;
       a51,a52,a53,0,0,0;
       a61,a62,a63,0,0,0];

    % Computing the equation dphidt=A*phi
    phi_dot=A*phi;

    % Trasform the matrix into a vector
    phi_dot=reshape(phi_dot,[36 1]);

    % Dynamics implementation
    dxdt = [   v(1); 
               v(2); 
               v(3);
               -mu/(r_norm^3)*r(1);
               -mu/(r_norm^3)*r(2);
               -mu/(r_norm^3)*r(3);
               phi_dot];
       
else  % Propagation of the state
    
    % Dynamics implementation
    dxdt = [   v(1); 
               v(2); 
               v(3);
               -mu/(r_norm^3)*r(1);
               -mu/(r_norm^3)*r(2);
               -mu/(r_norm^3)*r(3)];   
       
end
       
end