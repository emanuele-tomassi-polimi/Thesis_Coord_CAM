function [kep] = new_car2kep(x0,refdate)

mu = 398600.4418;


% Conversion to ephemeris time (if needed)
if isa(refdate,'datetime')
    refdate.Format='MM dd yyyy HH:mm:ss.SSSSSSSSSSSSSS';
    et=cspice_str2et(char(refdate));
elseif isa(refdate,'string') || isa(refdate,'char')
    et=cspice_str2et(refdate);
elseif isa(refdate,'double')
    et=refdate;
else
    ME = MException('PoliMiSST:KeplerianPropagatorError:IncorrectInputType', ...
        'incorrect input type, expected UTC string, matlab UTC datetime object or TDB seconds');
    throw(ME)
end


elems = cspice_oscelt(x0, et, mu);
%  elems(1)  contains rp, perifocal distance.
%  elems(2)  contains ecc, eccentricity.
%  elems(3)  contains inc, inclination.
%  elems(4)  contains lnode, longitude of the ascending node.
%  elems(5)  contains argp, argument of periapsis.
%  elems(6)  contains m0, mean anomaly at epoch.
%  elems(7)  contains t0, epoch.
%  elems(8)  contains mu, gravitational parameter.

e = elems(2);

kep(1) = elems(1)/(1-e);
kep(2) = e;
kep(3) = elems(3);
kep(4) = elems(4);
kep(5) = elems(5);

E = kepler_E(e, elems(6)); % eccentric anomaly
kep(6) = 2*atan( sqrt((1+e)/(1-e))*tan(E/2) );

end




function E = kepler_E(e, M)

% This function uses Newton’s method to solve Kepler’s equation E - e*sin(E)=
% M for the eccentric anomaly, given the eccentricity and the mean anomaly. 
% E- eccentric anomaly (radians) 
% e - eccentricity, passed from the calling program 
% M - mean anomaly (radians), passed from the calling program 

% Set an error tolerance:
error = 1.e-8;
% Select a starting value for E:
if M < pi
    E = M + e/2;
else
    E = M - e/2;
end

% Iterate on Equation 3.17 until E is determined to within the error tolerance:
ratio = 1;
while abs(ratio) > error
    ratio = (E - e*sin(E) - M)/(1 - e*cos(E));
    E = E - ratio;
end
end








