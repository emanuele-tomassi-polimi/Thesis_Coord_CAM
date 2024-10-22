function conjunction_struct=adjust_CDM(CDM_filename)
% Read the whole CDM content and adjust conjunction most remarkable
% parameters
% -------------------------------------------------------------------------
% INPUTS:
% - filename: CDM filename
% -------------------------------------------------------------------------
% OUTPUT:
% - conjunction_struct: strucuture containing conjunction most remarkable
%                       parameters. Structure fields are:
%                   - message_ID
%                   - TCA
%                   - miss_distance
%                   - object1_struct
%                       - reference frame
%                       - maneuverable (optional - if present)
%                       - metadata (optional - if present)
%                       - data.radius
%                       - data.mean_state
%                       - data.covariance
%                   - object2_struct
%                       - reference frame
%                       - maneuverable (optional - if present)
%                       - metadata (optional - if present)
%                       - data.radius
%                       - data.mean_state
%                       - data.covariance
% -------------------------------------------------------------------------
% Author:        Marco Felice Montaruli, Politecnico di Milano, 27 November 2020
%                e-mail: marcofelice.montaruli@polimi.it


% Read CDM file
CDM_struct=read_CDM(CDM_filename);

% ----------------------- CDM general information -------------------------

% Message ID
conjunction_struct.message_ID = CDM_struct.header('MESSAGE_ID');

% TCA
conjunction_struct.TCA = CDM_struct.relative_metadata('TCA');

% Miss distance
conjunction_struct.miss_distance = str2double(CDM_struct.relative_metadata('MISS_DISTANCE'))*1e-3; % [km]


% -------------------------------- Object 1 -------------------------------

% Reference frame
object1_struct.reference_frame = CDM_struct.object1_metadata_and_data('REF_FRAME');


% Quantities which are not essential in the analysis
try
    
    % Maneuverability
    object1_struct.maneuverable = CDM_struct.object1_metadata_and_data('MANEUVERABLE');
    
    % Generic metadata
    object1_struct.metadata.object_designator = CDM_struct.object1_metadata_and_data('OBJECT_DESIGNATOR_1');
    object1_struct.metadata.catalog_name = CDM_struct.object1_metadata_and_data('CATALOG_NAME');
    object1_struct.metadata.object_name = CDM_struct.object1_metadata_and_data('OBJECT_NAME');
    object1_struct.metadata.international_designator = CDM_struct.object1_metadata_and_data('INTERNATIONAL_DESIGNATOR');
    object1_struct.metadata.ephemeris_name = CDM_struct.object1_metadata_and_data('EPHEMERIS_NAME');
    object1_struct.metadata.covariance_method = CDM_struct.object1_metadata_and_data('COVARIANCE_METHOD');
catch
end

% Data - radius
object1_struct.data.radius = str2double(CDM_struct.object1_metadata_and_data('RADIUS'))*1e-3; % [km]

% The actual area of the object
if isKey(CDM_struct.object1_metadata_and_data,'AREA_PC')
    object1_struct.data.area=str2double(CDM_struct.object1_metadata_and_data('AREA_PC'));
end

% Area-over-mass ratio * Cd
if isKey(CDM_struct.object1_metadata_and_data,'CD_AREA_OVER_MASS')
    object1_struct.data.Bstar=str2double(CDM_struct.object1_metadata_and_data('CD_AREA_OVER_MASS'));
end

% Mass
if isKey(CDM_struct.object1_metadata_and_data,'MASS')
    object1_struct.data.mass=str2double(CDM_struct.object1_metadata_and_data('MASS'));
end

% Cd
if isKey(CDM_struct.object1_metadata_and_data,'CD_AREA_OVER_MASS') && ...
        isKey(CDM_struct.object1_metadata_and_data,'MASS') && ...
        isKey(CDM_struct.object1_metadata_and_data,'AREA_PC')
object1_struct.data.Cd = object1_struct.data.Bstar/object1_struct.data.area*object1_struct.data.mass;
end

% Area-over-mass ratio * Cr
if isKey(CDM_struct.object1_metadata_and_data,'CR_AREA_OVER_MASS')
    object1_struct.data.Brstar=str2double(CDM_struct.object1_metadata_and_data('CR_AREA_OVER_MASS'));
end

% Data - mean state (km and km/s)
mean_state_object1(1) = str2double(CDM_struct.object1_metadata_and_data('X'));
mean_state_object1(2) = str2double(CDM_struct.object1_metadata_and_data('Y'));
mean_state_object1(3) = str2double(CDM_struct.object1_metadata_and_data('Z'));
mean_state_object1(4) = str2double(CDM_struct.object1_metadata_and_data('X_DOT'));
mean_state_object1(5) = str2double(CDM_struct.object1_metadata_and_data('Y_DOT'));
mean_state_object1(6) = str2double(CDM_struct.object1_metadata_and_data('Z_DOT'));

object1_struct.data.mean_state = mean_state_object1';


% Data - covariance
covariance_object1(1,1) = str2double(CDM_struct.object1_metadata_and_data('CR_R'));

covariance_object1(2,1) = str2double(CDM_struct.object1_metadata_and_data('CT_R'));
covariance_object1(2,2) = str2double(CDM_struct.object1_metadata_and_data('CT_T'));

covariance_object1(3,1) = str2double(CDM_struct.object1_metadata_and_data('CN_R'));
covariance_object1(3,2) = str2double(CDM_struct.object1_metadata_and_data('CN_T'));
covariance_object1(3,3) = str2double(CDM_struct.object1_metadata_and_data('CN_N'));

covariance_object1(4,1) = str2double(CDM_struct.object1_metadata_and_data('CRDOT_R'));
covariance_object1(4,2) = str2double(CDM_struct.object1_metadata_and_data('CRDOT_T'));
covariance_object1(4,3) = str2double(CDM_struct.object1_metadata_and_data('CRDOT_N'));
covariance_object1(4,4) = str2double(CDM_struct.object1_metadata_and_data('CRDOT_RDOT'));

covariance_object1(5,1) = str2double(CDM_struct.object1_metadata_and_data('CTDOT_R'));
covariance_object1(5,2) = str2double(CDM_struct.object1_metadata_and_data('CTDOT_T'));
covariance_object1(5,3) = str2double(CDM_struct.object1_metadata_and_data('CTDOT_N'));
covariance_object1(5,4) = str2double(CDM_struct.object1_metadata_and_data('CTDOT_RDOT'));
covariance_object1(5,5) = str2double(CDM_struct.object1_metadata_and_data('CTDOT_TDOT'));

covariance_object1(6,1) = str2double(CDM_struct.object1_metadata_and_data('CNDOT_R'));
covariance_object1(6,2) = str2double(CDM_struct.object1_metadata_and_data('CNDOT_T'));
covariance_object1(6,3) = str2double(CDM_struct.object1_metadata_and_data('CNDOT_N'));
covariance_object1(6,4) = str2double(CDM_struct.object1_metadata_and_data('CNDOT_RDOT'));
covariance_object1(6,5) = str2double(CDM_struct.object1_metadata_and_data('CNDOT_TDOT'));
covariance_object1(6,6) = str2double(CDM_struct.object1_metadata_and_data('CNDOT_NDOT'));


covariance_object1 = covariance_object1 + tril(covariance_object1,-1)';

% From m2/s to km2/s -> 1 m2/s = 1*1e-6 km2/s
covariance_object1 = covariance_object1*1e-6;

object1_struct.data.covariance = covariance_object1;

% Save in the Conjunction structure
conjunction_struct.object1 = object1_struct;

% -------------------------------- Object 2 -------------------------------

% Reference frame
object2_struct.reference_frame = CDM_struct.object2_metadata_and_data('REF_FRAME');

% Quantities which are not essential in the analysis
try
    
    % Maneuverability
    object2_struct.maneuverable = CDM_struct.object2_metadata_and_data('MANEUVERABLE');
    
    % Generic metadata
    object2_struct.metadata.object_designator = CDM_struct.object2_metadata_and_data('OBJECT_DESIGNATOR_1');
    object2_struct.metadata.catalog_name = CDM_struct.object2_metadata_and_data('CATALOG_NAME');
    object2_struct.metadata.object_name = CDM_struct.object2_metadata_and_data('OBJECT_NAME');
    object2_struct.metadata.international_designator = CDM_struct.object2_metadata_and_data('INTERNATIONAL_DESIGNATOR');
    object2_struct.metadata.ephemeris_name = CDM_struct.object2_metadata_and_data('EPHEMERIS_NAME');
    object2_struct.metadata.covariance_method = CDM_struct.object2_metadata_and_data('COVARIANCE_METHOD');
catch
end

% Data - radius
object2_struct.data.radius = str2double(CDM_struct.object2_metadata_and_data('RADIUS'))*1e-3; % [km]


% The actual area of the object
if isKey(CDM_struct.object2_metadata_and_data,'AREA_PC')
    object2_struct.data.Area=str2double(CDM_struct.object2_metadata_and_data('AREA_PC'));
end

% Area-over-mass ratio * Cd
if isKey(CDM_struct.object2_metadata_and_data,'CD_AREA_OVER_MASS')
    object2_struct.data.Bstar=str2double(CDM_struct.object2_metadata_and_data('CD_AREA_OVER_MASS'));
end

% Mass
if isKey(CDM_struct.object2_metadata_and_data,'MASS')
    object2_struct.data.mass=str2double(CDM_struct.object2_metadata_and_data('MASS'));
end

% Cd
if isKey(CDM_struct.object2_metadata_and_data,'CD_AREA_OVER_MASS') && ...
        isKey(CDM_struct.object2_metadata_and_data,'MASS') && ...
        isKey(CDM_struct.object2_metadata_and_data,'AREA_PC')
object2_struct.data.Cd = object2_struct.data.Bstar/object2_struct.data.area*object2_struct.data.mass;
end

% Area-over-mass ratio * Cr
if isKey(CDM_struct.object2_metadata_and_data,'CR_AREA_OVER_MASS')
    object2_struct.data.Brstar=str2double(CDM_struct.object2_metadata_and_data('CR_AREA_OVER_MASS'));
end

% Data - mean state (km and km/s)
mean_state_object2(1) = str2double(CDM_struct.object2_metadata_and_data('X'));
mean_state_object2(2) = str2double(CDM_struct.object2_metadata_and_data('Y'));
mean_state_object2(3) = str2double(CDM_struct.object2_metadata_and_data('Z'));
mean_state_object2(4) = str2double(CDM_struct.object2_metadata_and_data('X_DOT'));
mean_state_object2(5) = str2double(CDM_struct.object2_metadata_and_data('Y_DOT'));
mean_state_object2(6) = str2double(CDM_struct.object2_metadata_and_data('Z_DOT'));

object2_struct.data.mean_state = mean_state_object2';


% Data - covariance
covariance_object2(1,1) = str2double(CDM_struct.object2_metadata_and_data('CR_R'));

covariance_object2(2,1) = str2double(CDM_struct.object2_metadata_and_data('CT_R'));
covariance_object2(2,2) = str2double(CDM_struct.object2_metadata_and_data('CT_T'));

covariance_object2(3,1) = str2double(CDM_struct.object2_metadata_and_data('CN_R'));
covariance_object2(3,2) = str2double(CDM_struct.object2_metadata_and_data('CN_T'));
covariance_object2(3,3) = str2double(CDM_struct.object2_metadata_and_data('CN_N'));

covariance_object2(4,1) = str2double(CDM_struct.object2_metadata_and_data('CRDOT_R'));
covariance_object2(4,2) = str2double(CDM_struct.object2_metadata_and_data('CRDOT_T'));
covariance_object2(4,3) = str2double(CDM_struct.object2_metadata_and_data('CRDOT_N'));
covariance_object2(4,4) = str2double(CDM_struct.object2_metadata_and_data('CRDOT_RDOT'));

covariance_object2(5,1) = str2double(CDM_struct.object2_metadata_and_data('CTDOT_R'));
covariance_object2(5,2) = str2double(CDM_struct.object2_metadata_and_data('CTDOT_T'));
covariance_object2(5,3) = str2double(CDM_struct.object2_metadata_and_data('CTDOT_N'));
covariance_object2(5,4) = str2double(CDM_struct.object2_metadata_and_data('CTDOT_RDOT'));
covariance_object2(5,5) = str2double(CDM_struct.object2_metadata_and_data('CTDOT_TDOT'));

covariance_object2(6,1) = str2double(CDM_struct.object2_metadata_and_data('CNDOT_R'));
covariance_object2(6,2) = str2double(CDM_struct.object2_metadata_and_data('CNDOT_T'));
covariance_object2(6,3) = str2double(CDM_struct.object2_metadata_and_data('CNDOT_N'));
covariance_object2(6,4) = str2double(CDM_struct.object2_metadata_and_data('CNDOT_RDOT'));
covariance_object2(6,5) = str2double(CDM_struct.object2_metadata_and_data('CNDOT_TDOT'));
covariance_object2(6,6) = str2double(CDM_struct.object2_metadata_and_data('CNDOT_NDOT'));


covariance_object2 = covariance_object2 + tril(covariance_object2,-1)';

% From m2/s to km2/s -> 1 m2/s = 1*1e-6 km2/s
covariance_object2 = covariance_object2*1e-6;

object2_struct.data.covariance = covariance_object2;

% Save in the Conjunction structure
conjunction_struct.object2 = object2_struct;

end