function PoC = smd2poc(BP_struct,SMD, order)

% Compute the collision probability between two objects using
% Chan's Method (REF. "Spacecraft Collision Probability", F. Kenneth Chan)
% -------------------------------------------------------------------------
% INPUTS: 
% - SMD : % Squared Mahalanobis Distance [km]
% -------------------------------------------------------------------------
% OUTPUT: 
% - PoC : Collision Probability (Chan formula)
% -------------------------------------------------------------------------
% Author:   Maria Francesca Palermo, Politecnico di Milano, 27 November 2020
%           e-mail: mariafrancesca.palermo@mail.polimi.it



% -------------------------------------------------------------------------

u = BP_struct.u;

v = SMD;

% -------------------------------------------------------------------------
% The series can be truncated for m = 3 for small values of u.

m_vect = 0:order; % hp) small values of u
P_mpart = 0;

for j = 1:length(m_vect)
    m = m_vect(j);
    k_vect = 0 : 1 : m_vect(j);
    P_kpart = 0;
    for w = 1:length(k_vect)
        k = k_vect(w);
        P_kpart = P_kpart + u^k/(2^k*factorial(k));
    end
    P_mpart =  P_mpart + (  v^m/(2^m* factorial(m))* (1- exp(-u/2)*P_kpart ));
end

% Probability of collision
PoC = exp(-v/2) * P_mpart;


end

