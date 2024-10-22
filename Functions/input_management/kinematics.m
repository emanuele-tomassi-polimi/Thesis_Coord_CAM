function [R, K] = kinematics(INPUT)
% Compute the rotation matrix and the kinematics matrix
% -------------------------------------------------------------------------
% INPUTS:
% - INPUT    : struct with the following fields: [km, rad]
%             (a_1,e_1,th_1,Rc,T,sa,re,sigma_ksi,sigma_zeta,rho,chi,phi,psi,u)
% -------------------------------------------------------------------------
% OUTPUT:
% - R        : [3x3]rotation matrix
% - K        : [3x3]kinematics matrix
% -------------------------------------------------------------------------
% Author:   Maria Francesca Palermo, Politecnico di Milano, 27 November 2020
%           e-mail: mariafrancesca.palermo@mail.polimi.it




% -------------------------------------------------------------------------
% CONSTANTS

mu = 398600.4415; % Earth gravity constant [km^3/s^2]


% -------------------------------------------------------------------------
% ANALYTIC FORMULATION, ROTATION AND KINEMATICS MATRIX

% beta represents the angle between v_1 and (v_1 − v_2)
cosbeta = (1 - INPUT.chi*cos(INPUT.psi)*cos(INPUT.phi))/sqrt(1 - 2*INPUT.chi*cos(INPUT.psi)*cos(INPUT.phi) + INPUT.chi^2);
sinbeta = sqrt(1-cosbeta^2);

% alphac is the flight-path angle of S1 at collision
sinalphac = (INPUT.e_1*sin(INPUT.th_1))/sqrt(INPUT.e_1^2+2*INPUT.e_1*cos(INPUT.th_1)+1);
cosalphac = (1 + INPUT.e_1*cos(INPUT.th_1))/sqrt(INPUT.e_1^2+2*INPUT.e_1*cos(INPUT.th_1)+1);

% magnitude of S1 velocity
v = sqrt( (mu*(2*INPUT.a_1 - INPUT.Rc))/ (INPUT.Rc*INPUT.a_1));%[km/s] 

% Kinematics matrix
K = [-v*sqrt(INPUT.Rc/(mu)) sinalphac 0 ;
    0 -cosalphac*sin(INPUT.phi)*cos(INPUT.psi)/sqrt(1-cos(INPUT.psi)^2*cos(INPUT.phi)^2)  sin(INPUT.psi)/sqrt(1-cos(INPUT.psi)^2*cos(INPUT.phi)^2);
    0  cosalphac*sin(INPUT.psi)/sqrt(1-cos(INPUT.psi)^2*cos(INPUT.phi)^2)    sin(INPUT.phi)*cos(INPUT.psi)/sqrt(1-cos(INPUT.psi)^2*cos(INPUT.phi)^2)];

% Rotation matrix
R = [0 0 -1;
    cosbeta -sinbeta 0 ;
    -sinbeta -cosbeta 0 ];
end

