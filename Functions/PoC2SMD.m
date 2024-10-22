function [SMD, err, iter] = PoC2SMD(P, R, PoC_enforced, m,  varargin)
% Analytic SMD computation given an enforced PoC with M =1
% -------------------------------------------------------------------------
% INPUTS:
% - P = summed Covariance matrix of the primary and the secondary 
% - R = summed primary and secondary object radii
% - PoC_enforced : the desired collision probability
% - m : order accuracy
% - varargin{1}  : pecerntual error wrt the previous SMD estimation. This
%                  variable enables an iterative process until the required 
%                  error on the SMD is met.
% - varargin{2}  : maximum number of desired iterations. if varargin{2} is 
%                  not set, then this variable is 20. if 
%                  varargin{1} is empty as well, then the number of
%                  iteration is 1.
% -------------------------------------------------------------------------
% OUTPUT:
% - SMD = Output Square Mahalanobis Distance 
%
% -------------------------------------------------------------------------
% Author: Andrea De Vittori, Politecnico di Milano, 04 March 2022

% optional variables management
len_varargin = length(varargin);
if len_varargin >= 1
    err_threshold = varargin{1};
else
    err_threshold = inf;
end

if len_varargin == 2
    max_iter = varargin{2};
else
    max_iter = 20;
end
u = R^2/(sqrt(P(1, 1)*P(2, 2))*sqrt(1-P(1, 2)^2/(P(1, 1)*P(2, 2))));
% SMD at order 0
v0 = -2*log(PoC_enforced/(1-exp(-u/2)));
v1 = v0;

% variables initialization
iter = 0;
err = inf;


if  m == 0
    % Chan's PoC at order 0 for SMD estimation
    SMD = v0;
    err = 0;
elseif  m == 1
    % Chan's PoC at order 1
    while err >= err_threshold && iter < max_iter
        % Build a 2^nd order polynomial equation for SMD estimation
        a = 1 - exp(-u/2);
        b = a - exp(-u/2)*u/2;
        c = a*exp(-v0/2)*(1+1/2*v0) - PoC_enforced;
        d = exp(-v0/2)*(1/2*b - 1/2*a + 1/4*v0*b);
        e =  - 1/4*b*exp(-v0/2);
        delta = d^2 - 4*c*e;
        SMD = [(-d - sqrt(delta))/(2*e), (-d + sqrt(delta))/(2*e)];
        SMD = SMD(SMD == real(SMD)& SMD >0 & abs(v0-SMD)== min(abs(v0-SMD)));
        err =  abs((SMD-v0)/v0)*100;
        if isempty(SMD)
            SMD = v0;
            err = abs((v1-v0)/v1)*100;
            break
        else
            v1 = v0;
            v0 = SMD;
        end
        iter = iter + 1;
    end
elseif  m == 2
    SMD_sol = zeros(1, m+1);
    % Chan's PoC at order 2
    while err >= err_threshold && iter < max_iter
        % Build a 3^rd order polynomial equation for SMD estimation
        a = exp(-u/2);
        b = 1 - a;
        c = b - a*u/2;
        d = c - a*u^2/8;
        e = exp(-v0/2);
        f = e*(1+ 1/2*v0);
        g = -1/2*e;
        aa = g*d/8;
        bb = f*d/8 + g*c/2;
        cc = f*c/2 + g*b;
        dd = f*b - PoC_enforced;
        p = 9*aa*cc - 3*bb^2;
        q = 27*aa^2*dd - 9*aa*bb*cc + 2*bb^3;
        t = nthroot(-q/2 - sqrt(q^2/4 + p^3/27), 3) + ...
            nthroot( -q/2 + sqrt(q^2/4 + p^3/27), 3);
        SMD_sol(1) = (t - bb)/(3*aa);
        bb_t = bb + aa*SMD_sol(1);
        cc_t = cc + bb_t;
        delta = bb_t^2 - 4*aa*cc_t;
        SMD_sol(2:end) = [(-bb_t - sqrt(delta))/(2*aa), (-bb_t + sqrt(delta))/(2*aa)];
        SMD = SMD_sol(SMD_sol == real(SMD_sol)& SMD_sol >0 & ...
            abs(v0-SMD_sol)== min(abs(v0-SMD_sol)));
        err =  abs((SMD-v0)/v0)*100;
        
        if isempty(SMD)
            SMD = v0;
            err = abs((v1-v0)/v1)*100;
            break
        end
        v1 = v0;
        v0 = SMD;
        iter = iter + 1;
    end
elseif  m >= 3
    n = 1;
    % Chan's PoC at any order
    while err >= err_threshold && iter < max_iter
        % Build a (m+1)^th order polynomial equation for SMD estimation
        dim_taylor = n + 1;
        dim_chan = m + 1;
        dim_tot = m + n +1;
        t_exp_matr = zeros(dim_taylor,dim_taylor);
        a = exp(-v0/2);
        for i = 0:n
            coeff_t_exp = (-1)^i/(2^i*factorial(i))*a;
            for j=1:(i+1)
                t_exp_matr(i+1, j) = factorial(i) / (factorial(i-j+1)*factorial(j-1));
            end
            if i>0
                t_exp_matr(i+1, 1:i) = ((-v0).^linspace(i, 1, i)).*t_exp_matr(i+1, 1:i);
            end
            t_exp_matr(i+1, :) =  t_exp_matr(i+1, :)*coeff_t_exp;
        end
        t_exp_vect = sum(t_exp_matr, 1);
        s_k = zeros(2,1);
        S_k = zeros(2,1);
        chan_vect = zeros(1, dim_chan);
        s_k(1) = exp(-u/2);
        S_k(1) = s_k(1);
        chan_vect(1) = 1 - S_k(1);
        for k = 1:m
            s_k(2) = u/(2*k)*s_k(1);
            S_k(2) = S_k(1) + s_k(2);
            q_m = 1 - S_k(2);
            chan_vect(k+1) = 1/(2^k*factorial(k))*q_m;
            s_k(1) = s_k(2);
            S_k(1) = S_k(2);
        end
        total_matr = zeros(dim_taylor, dim_tot);
        
        for i = 0:n
            total_matr(i+1, i+1:i+m+1) =  t_exp_vect(i+1)*chan_vect;
        end
        total_vect = sum(total_matr, 1);
        total_vect(1) = total_vect(1) - PoC_enforced;
        SMD = roots(flip(total_vect));
        SMD = SMD(SMD == real(SMD)& SMD >0 & abs(v0-SMD)== min(abs(v0-SMD)));
        err = abs((SMD-v0)/v0)*100;
        if isempty(SMD)
            SMD = v0;
            err = abs((v1-v0)/v1)*100;
            break
        end
        v1 = v0;
        v0 = SMD;
        iter = iter + 1;
    end
end
end






% function[SMD]=PoC2SMD(u,Pc)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % PROTOTYPE:
% %   [SMD]=PoC2SMD(u,Pc)
% %--------------------------------------------------------------------------
% % DESCRIPTION: 
% %   Function used to compute the Squared Mahalanobis Distance (SMD) from
% %   the probability of collision (Pc)
% %--------------------------------------------------------------------------
% % INPUT:
% %   u[1]            Ratio of the impact cross-sectional area to the area of
% %                   the 1σ B-plane covariance ellipse
% %   Pc[1]           Probability of collision
% %--------------------------------------------------------------------------
% % OUTPUT:
% %   SMD[1]          Squared Mahalanobis Distance (SMD)   
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% N=3;
% SUM=0;
% syms nu
% 
% for m=0:N
%     term1=0;
%     for k=0:m
%         term1=term1+u^k/((2^k)*factorial(k));
%     end
%     term2=nu^m/((2^m)*factorial(m))*(1-exp(-u/2)*term1);
%     SUM=SUM+term2;
% end
% 
% fun=exp(-nu/2)*SUM-Pc;
% fun=matlabFunction(fun);
% SMD=fzero(fun,5);
% 
% end