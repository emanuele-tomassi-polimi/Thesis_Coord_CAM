function t = theta2time(kep,th_1, mu)
a = kep(1);
e = kep(2);
theta_p = kep(6);
theta_delta = th_1;

if theta_delta<0
    nn=ceil(abs(theta_delta/(2*pi)));
    E_vec_m=wrapTo2Pi(2*atan(sqrt((1-e)/(1+e))*tan(theta_delta/2)))-2*pi*nn;
else
    E_vec_m=wrapTo2Pi(2*atan(sqrt((1-e)/(1+e))*tan(theta_delta/2)));
end

E=wrapTo2Pi(2*atan(sqrt((1-e)/(1+e))*tan(theta_p /2)));

% Conversion of Eccentric anomaly in time before TCA:
t_p=sqrt(a^3/mu)*(E-e*sin(E));
t=t_p-sqrt(a^3/mu)*(E_vec_m-e*sin(E_vec_m));
  