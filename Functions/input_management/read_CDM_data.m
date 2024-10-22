function conjunction = read_CDM_data(CDM_filename, CDM_id)

DATA = readmatrix(CDM_filename);

% This data is derived from ESA Collision Avoidance Competition data
% (https://kelvins.esa.int/collision-avoidance-challenge/data/) with the
% help of Sebastien Henry 

%ID: event ID, it coincides with the line number
DATA_id = DATA(CDM_id,:)';


conjunction.mu = 398600.4415; % Earth gravity constant [km^3/s^2]

% TCA in ephemeral time
% conjunction.TCA_et = NaN; 


% R [km]: radius of the collision disk (sum of objects radii)
conjunction.sa = DATA_id(2); 

% primary (p) state vector at closest approach, cartesian ECIJ200
conjunction.object1.mean_state = DATA_id(3:8);

% primary (p) positional covariance (c) elements, radial (r), transverse
% (t) and normal (n) at closest aproach, primary RTN reference frame
object1_covariance_vect_RTN = DATA_id(9:14);
object1_covariance_RTN = diag(object1_covariance_vect_RTN(1:3)) + ...
    squareform(object1_covariance_vect_RTN(4:end));

% Covariance rotation
R_eci2rtn = build_R_eci2rtn(conjunction.object1.mean_state);
R_rtn2eci = R_eci2rtn';
conjunction.object1.covariance_pos = R_rtn2eci*object1_covariance_RTN*R_rtn2eci';


% secondary (s) state vector at closest approach, cartesian ECIJ200
conjunction.object2.mean_state = DATA_id(15:20);

% secondary (s) positional covariance (c) elements, radial (r), transverse
% (t) and normal (n) at closest aproach, secondary RTN reference frame
object2_covariance_vect_RTN = DATA_id(21:26);
object2_covariance_RTN = diag(object2_covariance_vect_RTN(1:3)) + ...
    squareform(object2_covariance_vect_RTN(4:end));
% Covariance rotation
R_eci2rtn = build_R_eci2rtn(conjunction.object2.mean_state);
R_rtn2eci = R_eci2rtn';
conjunction.object2.covariance_pos = R_rtn2eci*object2_covariance_RTN*R_rtn2eci';

% Pc: collision probability using Alfano's method Eq 5a (S. Alfano, Review
% of Conjunction Probability Methods for Short-term Encounters, AAS Paper
% 07-148, 2007)
conjunction.Pc = DATA_id(27);

% Pc_approx: collision probability approximation using Alfriend's method
% Eq. 18 (K. Alfriend, M. Akella, J. Frisbee, J. Foster, D.-J. Lee, and M.
% Wilkins, “Probability of Collision Error Analysis,”Space Debris, vol.
% 1,no. 1, pp. 21–35, 1999)
conjunction.Pc_approx = DATA_id(28);

% Pc_max; maximum collision probability using Alfriend's method Eq. 21 (K.
% Alfriend, M. Akella, J. Frisbee, J. Foster, D.-J. Lee, and M. Wilkins,
% “Probability of Collision Error Analysis,”Space Debris, vol. 1,no. 1, pp.
% 21–35, 1999)
conjunction.Pc_max = DATA_id(29);

% d^* [km]: relative distance at closest approach
conjunction.d = DATA_id(30);

% v^* [km/s]: relative speed at closest approach
conjunction.v = DATA_id(31);

% d_m^2 [km^2]: squared Mahalanobis distance at closest approach (b-plane)
conjunction.smd = DATA_id(32);



R_earth = 6371.01; % Earth radius [km]
g0 =conjunction.mu/R_earth^2; % Earth gravity acceleration [km/s^2]

% Primary propulsion parameters (IRIDIUM)
% conjunction.object1.Tmax = 0.1; % [N] thrust
conjunction.object1.Isp = 220; % [s]
conjunction.object1.m0 = 500; % [kg] mass
conjunction.object1.ce = conjunction.object1.Isp*g0;% effective velocity [km/s]









