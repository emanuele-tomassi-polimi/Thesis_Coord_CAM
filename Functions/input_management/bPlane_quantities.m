function [OUTPUT] = bPlane_quantities(conjunction, Kp, Ks)
%
% B-Plane Quantities
%
%DESCRIPTION:
%This code computes the B-plane quantities and the kinematics matrix. 
%
%PROTOTYPE
%   [OUTPUT] = bPlane_quantities(conjunction, Kp, Ks)
%
%--------------------------------------------------------------------------
% INPUTS:
%   conunction [1x1]       Conjunction Data                 [-] (structure)
%   Kp         [6x1]       Covar. Scale Factor for Object 1 [-]
%   Ks         [1x1]       Covar. Scale Factor for Object 2 [-]
%--------------------------------------------------------------------------
% OUTPUTS:
%   OUTPUT     [---]       Results Structure                [-] (structure)
%--------------------------------------------------------------------------
%
%NOTES:
% - The input "conjunction" shall be furnished with the following data:
%      * object1.mean_state      [6x1]   Mean State @TCA          [km],[km][s-1]
%               .covariance_pos  [3x3]   Position Covariance @TCA [km2],[km2][s-1],[km2][s-2]
%               .radius          [1x1]   Object Radius            [km]
%      * object2.mean_state      [6x1]   Mean State @TCA          [km],[km][s-1]
%               .covariance_pos  [3x3]   Position Covariance @TCA [km2],[km2][s-1],[km2][s-2]
%               .radius          [1x1]   Object Radius            [km]
% - The output "OUTPUT" is a structure containing the following data:
%      * a_1        = Semi-Major Axis of object 1                 [km]
%      * e_1        = Eccentricity of object 1                    [-]
%      * th_1       = True Anomaly of object 1                    [rad]
%      * a_2        = Semi-Major Axis of object 2                 [km]
%      * e_2        = Eccentricity of object 2                    [-]
%      * th_2       = True Anomaly of object 2                    [rad]
%      * Rc         = Position Norm of the Primary @ TCA          [km]
%      * T          = Primary Object Orbital Period               [s]
%      * sa         = Sum of the Two Objcets' Radii               [km]
%      * re         = Rel. Dist. in B-Plane r.f. @TCA             [km]
%      * C          = Csi-Zeta Submatrix                          [km2]
%      * sigma_ksi  = Std Deviation Along Csi                     [km]
%      * sigma_zeta = Std Deviation Along Zeta                    [km]
%      * rho        = Correlation Factor                          [-]
%      * chi        = Magnitude Ration                            [rad]
%      * phi        = In-Plane Rotation Angle                     [rad]
%      * psi        = Out-of-Plane Rotation Angle                 [rad]
%      * u          = Ratio of the Impact Cross-Sectional Area to the Area
%                     of the 1σ Covariance Ellipse in the B-Plane [-]
%      * be         = Nominal Relative Distance in BP r.f. @TCA   [km]
%
%CALLED FUNCTIONS:
% car2elements, R_eci2bplane, kinematics
%
%UPDATES:
% 2024/03/31, Emanuele Tomassi: added secondary object orbital elements to
%                               the output. added projection matrix and
%                               covariance matrix computed w.r.t. object 1
% 2022/04/27, Luigi De Maria: updated the header and the function comments
%                             and organization
%
%REFERENCES:
% (none)
%
%AUTHOR(s):
%Maria Francesca Palermo, 27 November 2020
%(email: mariafrancesca.palermo@mail.polimi.it)
%

%% Main Code

%----------------------------- PRE-SETTINGS -------------------------------
%Constants
mu = 398600.4415;       %Earth Planetary Parameter [km3][s-2]

%------------------------- INPUT MANAGEMENT -------------------------------
%Converting CDM data into Input

%Objects' Covariances in ECI r.f. @TCA
Cov1_eci = conjunction.object1.covariance_pos; %Primary [km2]
Cov2_eci = conjunction.object2.covariance_pos; %Secondary [km2]

%Objects' Position and Celocity in ECI r.f. @TCA
%Primary
r_1_eci  = conjunction.object1.mean_state(1:3);  %Position [km]
v_1_eci  = conjunction.object1.mean_state(4:6);  %Velocity [km][s-1]
%Secondary
r_2_eci  = conjunction.object2.mean_state(1:3);  %Position [km]
v_2_eci  = conjunction.object2.mean_state(4:6);  %Velocity [km][s-1]


%Primary Object's Orbital Elements [km], [rad]
% elems_1 = double(py.spiceypy.oscltx(object1.mean_state, TCA_et, mu));
elems_1 = car2elements(conjunction.object1.mean_state, mu);
OUTPUT.a_1  = elems_1(1);                       %Semi-Major Axis [km]
OUTPUT.e_1  = elems_1(2);                       %Eccentricity [-]
OUTPUT.th_1 = elems_1(6);                       %True anomaly at TCA [rad]
OUTPUT.T    = elems_1(7);                       %Orbital Period [s]
%Primary Object's Position Norm @TCA [km]
OUTPUT.Rc   = norm(r_1_eci);

%Secondary Object's Orbital Elements [km], [rad]
elems_2     = car2elements(conjunction.object2.mean_state, mu);
OUTPUT.a_2  = elems_2(1);                       %Semi-Major Axis [km]
OUTPUT.e_2  = elems_2(2);                       %Eccentricity [-]
OUTPUT.th_2 = elems_2(6);                       %True anomaly at TCA [rad]
OUTPUT.T_2  = elems_2(7);                       %Orbital Period [s]

%Orbital Angular Momentum [km2][s-1]
h_1  = cross(r_1_eci, v_1_eci);

%Out-of-Plane Vector of B-Plane r.f. [-]
uh_1 = h_1/norm(h_1);

%Sum of the Two Objcets' Radii [km]
if isfield(conjunction.object1,'radius') && isfield(conjunction.object2,'radius')
    OUTPUT.sa = conjunction.object1.radius+conjunction.object2.radius;
elseif isfield(conjunction,'sa')
    OUTPUT.sa = conjunction.sa;
end

%Nominal Relative Distance Between the Two Objects in ECI @TCS [km]
re_eci = r_1_eci - r_2_eci;

%Rotation Matrix from ECI to B-Plane
Rb = R_eci2bplane(conjunction.object1.mean_state(4:6),conjunction.object2.mean_state(4:6));
OUTPUT.Rb = Rb;

Rb_2 = R_eci2bplane(conjunction.object2.mean_state(4:6),conjunction.object1.mean_state(4:6));
OUTPUT.Rb_2 = Rb_2;

%Projection Matrix on the Eta-axis
OUTPUT.Rb_2D = [Rb(1,1) Rb(1,2)  Rb(1,3);
                Rb(3,1) Rb(3,2)  Rb(3,3)];

OUTPUT.Rb_2D_2 = [Rb_2(1,1) Rb_2(1,2)  Rb_2(1,3);
                  Rb_2(3,1) Rb_2(3,2)  Rb_2(3,3)];

%Nominal Relative Distance Between the Two Objects in B-Plane r.f. @TCA
OUTPUT.re = Rb           * re_eci;    %From ECI to B-Plane [km]
OUTPUT.be = OUTPUT.Rb_2D * re_eci;    %Projection on the Eta-axis [km]

%-------------------- B-PLANE COVARIANCE PROJECTION -----------------------

% Overall Covariance Projected on B-Plane [km2]
Cov1_bp = Rb * Cov1_eci * Rb';
Cov2_bp = Rb * Cov2_eci * Rb';
Cov_bp = (Cov1_bp .* Kp) + (Cov2_bp .* Ks);

Cov1_bp_2 = Rb_2 * Cov1_eci * Rb_2';
Cov2_bp_2 = Rb_2 * Cov2_eci * Rb_2';
Cov_bp_2 = (Cov1_bp_2 .* Kp) + (Cov2_bp_2 .* Ks);

%Csi-Zeta Submatrix [km2]
C = [Cov_bp(1,1) Cov_bp(1,3);
     Cov_bp(3,1) Cov_bp(3,3)];

C_2 = [Cov_bp_2(1,1) Cov_bp_2(1,3);
       Cov_bp_2(3,1) Cov_bp_2(3,3)];

%Output Management
OUTPUT.C          = C;
OUTPUT.sigma_ksi  = sqrt(C(1,1));               %Std Deviation Along Csi [km]
OUTPUT.sigma_zeta = sqrt(C(2,2));               %Std Deviation Along Zeta [km]
OUTPUT.sigmaa     = sqrt(OUTPUT.sigma_ksi*OUTPUT.sigma_zeta); %Std Deviation [km]
OUTPUT.rho        = C(1,2)/(OUTPUT.sigma_ksi*OUTPUT.sigma_zeta); %Correlation Factor [-]

OUTPUT.C_2          = C_2;
OUTPUT.sigma_ksi_2  = sqrt(C_2(1,1));               %Std Deviation Along Csi [km]
OUTPUT.sigma_zeta_2 = sqrt(C_2(2,2));               %Std Deviation Along Zeta [km]
OUTPUT.sigmaa_2     = sqrt(OUTPUT.sigma_ksi_2*OUTPUT.sigma_zeta_2); %Std Deviation [km]
OUTPUT.rho_2        = C_2(1,2)/(OUTPUT.sigma_ksi_2*OUTPUT.sigma_zeta_2); %Correlation Factor [-]

%--------------------------- B-Plane Angles -------------------------------

%Magnitude Ration, chi [rad]
OUTPUT.chi = norm(v_2_eci)/norm(v_1_eci);

%In-Plane Rotation Angle, phi [rad]
%Let the velocity of S2 at collision be related to the velocity of S1 by a (positive) rotation of angle
OUTPUT.phi =  atan2(dot(cross(v_1_eci,v_2_eci),uh_1), dot(v_1_eci,v_2_eci));

%Out-of-Plane Rotation Angle, psi [rad]
%−π∕2 < ψ < π∕2 in the direction approaching uh1
OUTPUT.psi = atan( ((dot(v_2_eci,uh_1))*norm(cross(v_2_eci,uh_1))) / (dot(v_2_eci,v_2_eci) - dot(v_2_eci,uh_1)^2) ); 

%------------------------ B-Plane Final Quantities  -----------------------

%Ratio of the Impact Cross-Sectional Area to the Area of the 1σ Covariance Ellipse in the B-Plane [-]
OUTPUT.u = OUTPUT.sa^2 / (OUTPUT.sigma_ksi*OUTPUT.sigma_zeta * sqrt(1-OUTPUT.rho^2)); 

%Useful Matrix
OUTPUT.Lx = [1 0 0; 0 0 0; 0 0 0];
OUTPUT.Lz = [0 0 0; 0 0 0; 0 0 1];
OUTPUT.S  = [1 0 0 ; 0 0 0; 0 0 1];

%Compute Rotation and Kinematics Matrices
[OUTPUT.R, OUTPUT.K] = kinematics(OUTPUT);

%Rotation Matrix on Eta-Axis
OUTPUT.R_2D = [OUTPUT.R(1,1:3); OUTPUT.R(3,1:3)];

end