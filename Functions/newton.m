function [x_sol,iter]=newton(F,J,x0,tol,iter_max)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROTOTYPE:
%   [x_sol,iter]=newton(F,J,x0,tol,iter_max)
%--------------------------------------------------------------------------
% DESCRIPTION: 
%   Newton method used to solve the non-linear equation F(x)=0 where F is a
%   vectorial function of N elements and N variables.
%--------------------------------------------------------------------------
% INPUT:
%   F[M]            Function used for the problem F(x)=0
%   J[MxN]          Jacobian of F(x)
%   x0[N]           Initial guess used for the search
%   tol[1]          Tolerance on the error used to stop the search
%   iter_max[1]     Maximum number of iterations  
%--------------------------------------------------------------------------
% OUTPUT:
%   x_sol[N]        Solution of the problem      
%   iter[1]         Number of iterations performed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initial definition of the error
err=tol+1;

% The number of iterations is set to 0 at the beginning
iter=0;

% Set the initial value for the computation of the error
x_past=x0;

while (err > tol) && (iter <= iter_max)
    
    iter=iter+1;
    
    % Solution for this iteration
    x_sol=x_past-(J(x_past)\F(x_past));
    
    % Computation of the error
    err=max(abs(F(x_sol)));
    
    % Computation of x_past for the next iteration
    x_past=x_sol;
        
end

% Check on the number of iterations
if iter > iter_max
    error ('The number of iterations overcomes the maximum one')
    
end

end