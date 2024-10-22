function M = dynamics_matrix(dTheta, INPUT)
% Compute b-plane dynamics matrix
% -------------------------------------------------------------------------
% INPUTS:
% - dTheta   : true anomaly difference wrt CA true anomaly [rad] [km]
% - INPUT    : struct with the following fields:
%             (a_1,e_1,th_1,Rc,T,sa,re,sigma_ksi,sigma_zeta,rho,chi,phi,psi,u,R,K)
% -------------------------------------------------------------------------
% OUTPUT:
% - M          : [3x3]dynamics matrix
% -------------------------------------------------------------------------
% Author:   Maria Francesca Palermo, Politecnico di Milano, 27 November 2020
%           e-mail: mariafrancesca.palermo@mail.polimi.it


% -------------------------------------------------------------------------
% CONSTANTS

mu = 398600.4415; % Earth gravity constant [km^3/s^2]

% True anomaly of the first object @ maneuver point

theta_m = (INPUT.th_1 - dTheta);


% -------------------------------------------------------------------------
% D matrix construction:

% generalized Pelaez’ orbital elements
q10 = INPUT.e_1/sqrt(1 + INPUT.e_1*cos(INPUT.th_1));
q30 = 1/sqrt(1 + INPUT.e_1*cos(INPUT.th_1));

% eccentric anomalies accounting for multiple revolutions
Ec = eccentricAnomaly(INPUT.e_1,INPUT.th_1);
Em = eccentricAnomaly(INPUT.e_1,theta_m);

et1 = 3*q30*(q30^2-q10^2);
et2 = 1/2*(3*q10^3-(2*q30^2-q10^2)*(4*q30*cos(Em)-q10*cos(2*Em)));
et3 = q10*q30/4*(4*q30*cos(Em)-q10*(3+cos(2*Em)));
et4 = q30   *((4*q30^2-2*q10^2)*sin(Em) - q10*q30*sin(2*Em));
et5 = -q10/4*((4*q30^2-2*q10^2)*sin(Em) - q10*q30*sin(2*Em));

er1 = 3*q10*q30*sin(Em);
er2 = -2*(q30^2+q10^2)*sin(Em);
er3 = q10*q30/2*sin(Em);
er4 = -2*q30*(q30*cos(Em)-q10);
er5 = q10/2* (q30*cos(Em)-q10);

d_rth = (2*q30*(1-cos(dTheta))-q10*sin(theta_m)*sin(dTheta))/ ...
    (q30*(q30+q10*cos(theta_m))*(q30+q10*cos(INPUT.th_1))^2);

d_rr = sin(dTheta)/( q30*(q30+q10*cos(INPUT.th_1))^2 );

d_tth = 1/( q30*(q30^2-q10^2)^(5/2)*(q30-q10*cos(Em)) )*...
    (et1*(Ec-Em)+et2*(sin(Ec)-sin(Em))+ et3*(sin(2*Ec)-sin(2*Em)) + ...
    et4*(cos(Ec)-cos(Em)) + et5*(cos(2*Ec)-cos(2*Em))  ) ;

d_tr = 1/( q30*(q30^2-q10^2)^2     *(q30-q10*cos(Em)))*...
    (er1*(Ec-Em)+er2*(sin(Ec)-sin(Em))+ er3*(sin(2*Ec)-sin(2*Em)) + ...
    er4*(cos(Ec)-cos(Em)) + er5*(cos(2*Ec)-cos(2*Em))  ) ;

d_wh = sqrt(q30^2+q10*q30*cos(INPUT.th_1))/(q30+q10*cos(theta_m))*sin(dTheta);

D = sqrt((INPUT.Rc)^3/mu).*[d_tr d_tth 0; d_rr d_rth 0; 0 0 d_wh];


M = INPUT.R*INPUT.K*D;

%--------------------------------------------------------------------------
% Compute eccentric anomaly accounting for multiple revolutions

    function Ec = eccentricAnomaly(e,th)
        tol = 1e-07;
        Ec = 2*atan(sqrt((1-e)/(1+e))*tan(th/2));
        if Ec<0
            Ec = Ec + 2*pi;
        end
        if  th>0
            Ec = Ec + floor( abs(th)/(2*pi + tol) )*2*pi;
        else
            Ec = Ec - ceil( abs(th)/(2*pi + tol) )*2*pi;
        end
        
    end


end

