function kep = car2kep(r,v,mu)

%   Returns Keplerian orbital elements given the s/c position and velocity
%   vectors in cartesian coordinates and the planetary constant mu
% -------------------------------------------------------------------------
% INPUTS:
% - rr       : [3x1]position vector in cartesian coordinates [km]
% - vv       : [3x1]velocity vector in cartesian coordinates [km/s]
% - mu       : Earth gravity constant [km^3/s^2]
% -------------------------------------------------------------------------
% OUTPUT:
% - kep:     : keplerian elements
% -- kep(1): a        : semi-major axis [km]
% -- kep(2): e        : eccentricity [-]
% -- kep(3): i        : inclination [rad]
% -- kep(4): Om       : RAAN (Right Ascension of the Ascending Node) [rad]
% -- kep(5): om       : periapsis true anomaly [rad]
% -- kep(6): theta    : true anomaly [rad]
% -------------------------------------------------------------------------
% Author:   Maria Francesca Palermo, Politecnico di Milano, 27 November 2020
%           e-mail: mariafrancesca.palermo@mail.polimi.it



r_norm=norm(r);
v_norm=norm(v);

% k-axis 
k=[0 0 1]';

% Inclination computation (ii)
h=cross(r,v);               % Angular momentum vector
ii=acos((h'*k)/(norm(h)));

% Eccentricity (e)
e=((cross(v,h)/mu)-(r/r_norm)); % Eccentricity vector
e_mod=norm(e);

% Semi-major axis computation (a)
E=(v_norm^2/2)-(mu/r_norm); % Specific energy
a=-mu/(2*E);

% Right ascension of the ascending node computation (OM)
N=cross(k,h);
N_norm=norm(N);
if N(2)>=0
    OM=acos(N(1)/N_norm);
else
    OM= 2*pi-acos(N(1)/N_norm);
end

% Argument of periapsis computation (om)
if e(3)>=0
    om=acos(N'/N_norm*e/e_mod);
else
    om=2*pi-acos(N'/N_norm*e/e_mod);
end

% True anomaly computation (theta)
vr=v'*(r/r_norm);
if vr>=0
    theta=acos((e'*r)/(e_mod*r_norm));
else
    theta=2*pi-acos((e'*r)/(e_mod*r_norm));
end
kep = [a e_mod ii OM om theta];
end


