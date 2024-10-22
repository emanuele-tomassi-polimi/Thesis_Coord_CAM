function[r,v]=kep2car(a,e,ii,OM,om,theta,mu)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROTOTYPE:
%   [r,v]=kep2car(a,e,ii,OM,om,theta,mu)
%--------------------------------------------------------------------------
% DESCRIPTION: 
%   Function used to convert a keplerian elements representation into a
%   cartesian one.
%--------------------------------------------------------------------------
% INPUT: 
%   a[1]          Semi-major axis                       [km]   
%   e_mod[1]      Eccentricity                          [-]  
%   ii[1]         Inclination                           [rad] 
%   OM[1]         Right ascension of the ascending node [rad]
%   om[1]         Argument of periapsis                 [rad] 
%   theta[1]      True anomaly                          [rad]
%   mu[1]         Earth mass parameter                  [km^3/s^2]
%--------------------------------------------------------------------------
% OUTPUT:
%   r[3x1]        Position vector [km]
%   v[3x1]        Velocity vector [km] 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remark: if the orbit is parabolic, set the value of the semi-latus
% rectum (p) instead of the value of a.

% Semi-latus rectum
if e==1
    p=a;
else
    p=a*(1-(e^2));
end

% Position vector in perifocal coordinates
re=(p*cos(theta))/(1+e*cos(theta));
rp=(p*sin(theta))/(1+e*cos(theta));
rh=0;

% Velocity vector in perifocal coordinates
ve=-sqrt(mu/p)*sin(theta);
vp=sqrt(mu/p)*(e+cos(theta));
vh=0;

% First rotation matrix
R_OM=[ cos(OM) sin(OM) 0
      -sin(OM) cos(OM) 0
       0       0       1];

% Second rotation matrix 
R_ii=[1  0       0
     0  cos(ii) sin(ii) 
     0 -sin(ii) cos(ii)];

% Third rotation matrix 
R_om=[ cos(om) sin(om) 0
      -sin(om) cos(om) 0
       0       0       1];

% Overall rotation matrix
R_tot=(R_om*R_ii*R_OM)';
r=R_tot*[re; rp; rh];
v=R_tot*[ve; vp; vh];

end