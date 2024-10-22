function[R]=rotation(om,theta,ii,OM)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROTOTYPE:
%   [R]=rotation(om,theta,ii,OM)
%--------------------------------------------------------------------------
% DESCRIPTION: 
%   Function used to create the rotation matrix from the Inertial reference
%   frame to the Orbital reference frame
%--------------------------------------------------------------------------
% INPUT:
%   ii[1]      Inclination                           [rad]
%   OM[1]      Right ascension of the ascending node [rad]
%   om[1]      Pericentre anomaly                    [rad]
%   theta[1]   True anomaly                          [rad]
%--------------------------------------------------------------------------
% OUTPUT:
%   R[3x3]      Rotation matrix  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Rotation matrix 1
R1=[ cos(OM),   sin(OM),  0;
    -sin(OM),   cos(OM),  0;
     0,         0,        1];

% Rotation matrix 2
R2=[1,  0,      0;
    0,  cos(ii), sin(ii);
    0, -sin(ii), cos(ii)];
 
% Rotation matrix 3
R3=[ cos(om+theta),   sin(om+theta),  0;
    -sin(om+theta),   cos(om+theta),  0;
     0,               0,              1];

% Overall rotation matrix 
R=R3*R2*R1;

end