function [DRDV] = DrDv(t0, t, xP, xS)
%
% DeltaR-DeltaV Function
%
%DESCRIPTION:
%This code provides the function for the computation of dot-product between
%DeltaR and DeltaV. It is meant to be used as handle-function for the TCA
%refinement process.
%
%PROTOTYPE
%   [DRDV] = DrDv(t0, t, xP, xS)
%
%--------------------------------------------------------------------------
% INPUTS:
%   t0         [1x1]       Initial Time               [s]
%   t          [1x1]       Simulation Time            [s]
%   xP         [6x1]       Primary Synodic IC         [km],[km][s-1] or [-]
%   xS         [6x1]       Secondary Synodic IC       [km],[km][s-1] or [-]
%--------------------------------------------------------------------------
% OUTPUTS:
%   DRDV       [1x1]       Condition Check            [km2][s-1] or [-]
%--------------------------------------------------------------------------
%
%NOTES:
% - The input "t0" shall be the nominal TCA of the distribution. It is used
%   to refine the TCA.
% - The input "AstroMod" shall be 'kep' or 'cr3bp', on the base of the
%   problem under study.
% - The use of "scale" is adviced when dealing with CR3BP problems. The
%   non-dimensionality of the framework makes the solution of the
%   optimization difficult. Using a scale about 1e8 helps solve smoothly
%   the problem.
%
%CALLED FUNCTIONS:
% analytic_kep_prop
%
%UPDATES:
% - 17-04-2024, Emanuele Tomassi: removed scale factor and normalized Dr
%                                 and Dv in the scalar product
% - 15-04-2024, Emanuele Tomassi: removed cr3bp case, added different scale
%                                 parameter for position and velocity and
%                                 updated inputs
%
%REFERENCES:
% (none)
%
%AUTHOR(s):
%Luigi De Maria, 2022
%

%% Main Code

%Propagation
mu   = 398600.4415; %Earth Planetary Parameter [km3][s-2]
[x1] = analytic_kep_prop(xP, [t0 t], mu);
[x2] = analytic_kep_prop(xS, [t0 t], mu);

Dr = x1(1:3)-x2(1:3);
Dv = x1(4:6)-x2(4:6);

DRDV = dot(Dr/norm(Dr), Dv/norm(Dv));

end