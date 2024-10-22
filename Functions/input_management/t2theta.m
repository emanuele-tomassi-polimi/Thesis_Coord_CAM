function dth = t2theta(kep,t)

mu = 398600.4418;
a = kep(1);
e = kep(2);

n = sqrt(mu/a^3);
M = n*t;


% This function uses Newton’s method to solve Kepler’s equation E - e*sin(E)=
% M for the eccentric anomaly, given the eccentricity and the mean anomaly. 
% E- eccentric anomaly (radians) 
% e - eccentricity, passed from the calling program 
% M - mean anomaly (radians), passed from the calling program 

% Select a starting value for E:
%     E = M + e/2;

if M < pi
    E = M + e/2;
else
    E = M - e/2;
end

% Set an error tolerance:
error = 1.e-8;
% Iterate on Equation 3.17 until E is determined to within the error tolerance:
ratio = 1;
while abs(ratio) > error
    ratio = (E - e*sin(E) - M)/(1 - e*cos(E));
    E = E - ratio;
end

dth = 2*atan( sqrt((1+e)/(1-e))*tan(E/2));

if dth < 0
    dth = 2*pi + dth;
end
    
    
    
end








