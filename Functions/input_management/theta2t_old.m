function t = theta2t_old(a,e,mu,th_1,th_2)
    
% Initial eccentric anomaly
E1 = 2 * atan(tan(th_1/2) * sqrt((1 - e)/(1 + e)));

if E1 < 0
    E1 = E1 + 2 * pi;
end

% Final eccentric anomaly
E2 = 2 * atan(tan(th_2/2) * sqrt((1 - e)/(1 + e)));

if E2 < 0
    E2 = E2 + 2 * pi;
end

% Mean anomalies (initial and final)
M1 = E1 - e * sin(E1);

M2 = E2 - e * sin(E2);

% Mean angular rate
n = sqrt(mu/a^3);

% M = n*t
delta_t = (M2 - M1)/n;

T = 2 * pi * sqrt(a^3/mu);

if delta_t < 0
    delta_t = delta_t + T;
end

% Update time-vector
t = delta_t;


if (th_2 - th_1) < (2*pi) && (th_2-th_1)-2*pi==0 
    t = t;
elseif mod((th_2 - th_1),(2*pi)) == 0 
    t = floor(  (th_2 - th_1)/(2*pi)  )*T;
else
     t = t + floor(  (th_2 - th_1)/(2*pi)  )*T;
end
end
    
    

