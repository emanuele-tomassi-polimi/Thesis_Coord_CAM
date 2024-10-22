function kep = car2kep_state(x0,mu)

%   Returns Keplerian orbital elements given the s/c position and velocity
%   vectors in cartesian coordinates and the planetary constant mu
% -------------------------------------------------------------------------
% INPUTS:
% - x0       : [6x1]state vector in cartesian coordinates [km] and [km/s]
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

rr = x0(1:3);
vv = x0(4:6);

r = norm(rr);
v = norm(vv);
k = [0 0 1]';

a = -mu / (v^2 - 2*mu/r);

hh = cross(rr,vv);
h = norm(hh);

ee = cross(vv,hh)/mu - rr/r;
e = norm(ee);

i = acos(hh(3)/h);

N = cross(k,hh) / norm(cross(hh,k));

Om = acos(N(1));
if N(2) < 0
    Om = 2*pi - Om;
end

om = acos(dot(N,ee)/e);
if ee(3) < 0
    om = 2*pi - om;
end

theta = acos(dot(rr,ee)/(r*e));
if dot(rr,vv) < 0
    theta = 2*pi - theta;
end

kep = [a e rad2deg(i) rad2deg(Om) rad2deg(om) theta];



end

