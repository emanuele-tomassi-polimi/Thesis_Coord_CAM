function[DV1,DV1_norm]=CAM_wo_solver_non_dual(gamma,M,beta,T)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROTOTYPE:
%   [DV1,DV1_norm]=AM_wo_solver_non_dual(gamma,M,beta,T)
%--------------------------------------------------------------------------
% DESCRIPTION: 
%   Function used to solve the optimal problem for a CAM without return.
%   TThe standsrd Polynomial form is solved.
%--------------------------------------------------------------------------
% INPUT: 
%   gamma[1]            Constant [km]       
%   M[3x3]              Matrix                 
%   beta[3x1]           Vector         
%   T[3x3]              Matrix
%--------------------------------------------------------------------------
% OUTPUT:
%   DV1[3x1]            First impulse vector  [km/s]
%   DV1_norm[1]         Magnitude of the first impulse vector [km/s]   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       % Compute the polynomial coefficients
       ll = roots(flip(get_coeff(T,beta,gamma)));

       % Do not consider imaginary solutions
       ll =real(ll(imag(ll) == 0));
       
        % Choose the minimum deltav that satisfies the boundary condition
        DV1_norm_comp = inf;
        for ii=1:length(ll)
        DV1_test=-ll(ii)*(pinv(M+ll(ii)*T)*beta);
        DV1_norm_test=norm(DV1_test);
        check_SMD = (gamma + 2*DV1_test'*beta+DV1_test'*T*DV1_test)/gamma;
        if DV1_norm_test<DV1_norm_comp && check_SMD<1e-3
             DV1 = DV1_test;
             DV1_norm = DV1_norm_test;
             DV1_norm_comp = DV1_norm_test;
        end
        end
end