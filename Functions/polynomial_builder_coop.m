%% Get coefficients for the lambda polynomial
clear
clc

syms lambda b0 real

bp_T = sym('bp_T', [1 3],'real');
bs_T = sym('bs_T', [1 3],'real');

A_p = sym('A_p', [3 3], 'real');
A_s = sym('A_s', [3 3], 'real');
A_ps = sym('A_ps', [3 3], 'real');
A_sp = sym('A_sp', [3 3], 'real');

n1 = sym('n1', [1 7],'real');
n2 = sym('n2', [1 7],'real');
n3 = sym('n3', [1 7],'real');
n4 = sym('n4', [1 7],'real');
n5 = sym('n5', [1 7],'real');
n6 = sym('n6', [1 7],'real');
d = sym('d', [1 7],'real');

n1(7) = 0;
n2(7) = 0;
n3(7) = 0;

n4(7) = 0;
n5(7) = 0;
n6(7) = 0;

dv1_n = [( poly2sym(n1, lambda) ) ;
         ( poly2sym(n2, lambda) ) ;
         ( poly2sym(n3, lambda) ) ];

dv2_n = [( poly2sym(n4, lambda) ) ;
         ( poly2sym(n5, lambda) ) ;
         ( poly2sym(n6, lambda) ) ];

den = (poly2sym(d, lambda));

eq_lambda = den * den * b0 + den * 2 * bp_T * dv1_n - den * 2 * bs_T * dv2_n + dv1_n.' * A_p * dv1_n + ...
    dv2_n.' * A_s * dv2_n - dv1_n.' * A_ps * dv2_n - dv2_n.' * A_sp * dv1_n;

[coeff_lambda, terms] = coeffs(eq_lambda, lambda, 'All');

syms n17 n27 n37 n47 n57 n67 real

n1(7) = n17;
n2(7) = n27;
n3(7) = n37;

n4(7) = n47;
n5(7) = n57;
n6(7) = n67;

path_f_aug8= 'get_coeff_coop_l';
matlabFunction(coeff_lambda,'File',path_f_aug8, 'Vars', {b0, bp_T, bs_T, A_p, A_s, A_ps, A_sp, n1, n2, n3, n4, n5, n6, d});

%% get coefficients for DV1 and DV2 as function of lambda

clear
clc
close all

syms lambda real
A_p = sym('A_p', [3 3], 'real');
A_s = sym('A_s', [3 3], 'real');
A_ps = sym('A_ps', [3 3], 'real');
A_sp = sym('A_sp', [3 3], 'real');
bp = sym('bp', [3 1],'real');
bs = sym('bs', [3 1],'real');

dv1 = sym('dv1', [3 1],'real');
dv2 = sym('dv2', [3 1],'real');

eqs1 = (eye(3)+ lambda * A_p) * dv1 - lambda * A_ps * dv2 + lambda * bp == 0;

S_dv2 = solve(eqs1, dv2);

S_dv21 = S_dv2.dv21;
S_dv22 = S_dv2.dv22;
S_dv23 = S_dv2.dv23;

coeff_dv21_dv1 = fliplr(coeffs(collect(S_dv21, [dv1(1), dv1(2), dv1(3)]), [dv1(1), dv1(2), dv1(3)])); % coeff di dv11, dv12, dv13, e termine noto

coeff_dv22_dv1 = fliplr(coeffs(collect(S_dv22, [dv1(1), dv1(2), dv1(3)]), [dv1(1), dv1(2), dv1(3)]));

coeff_dv23_dv1 = fliplr(coeffs(collect(S_dv23, [dv1(1), dv1(2), dv1(3)]), [dv1(1), dv1(2), dv1(3)]));


syms m211 m212 m213 m214 real
syms m221 m222 m223 m224 real
syms m231 m232 m233 m234 real

dv2 = [(m211*dv1(1) + m212*dv1(2) + m213*dv1(3) + m214);
       (m221*dv1(1) + m222*dv1(2) + m223*dv1(3) + m224);
       (m231*dv1(1) + m232*dv1(2) + m233*dv1(3) + m234)];

eqs2 = (eye(3)+ lambda * A_s) * dv2 - lambda * A_sp * dv1 - lambda * bs == 0;

S_dv1 = solve(eqs2, dv1);

S_dv11 = S_dv1.dv11;
S_dv12 = S_dv1.dv12;
S_dv13 = S_dv1.dv13;


S_dv11 = subs(S_dv11, {m211 m212 m213 m214 m221 m222 m223 m224 m231 m232 m233 m234}, {coeff_dv21_dv1(1) coeff_dv21_dv1(2) coeff_dv21_dv1(3) coeff_dv21_dv1(4) coeff_dv22_dv1(1) coeff_dv22_dv1(2) coeff_dv22_dv1(3) coeff_dv22_dv1(4) coeff_dv23_dv1(1) coeff_dv23_dv1(2) coeff_dv23_dv1(3) coeff_dv23_dv1(4)});
S_dv12 = subs(S_dv12, {m211 m212 m213 m214 m221 m222 m223 m224 m231 m232 m233 m234}, {coeff_dv21_dv1(1) coeff_dv21_dv1(2) coeff_dv21_dv1(3) coeff_dv21_dv1(4) coeff_dv22_dv1(1) coeff_dv22_dv1(2) coeff_dv22_dv1(3) coeff_dv22_dv1(4) coeff_dv23_dv1(1) coeff_dv23_dv1(2) coeff_dv23_dv1(3) coeff_dv23_dv1(4)});
S_dv13 = subs(S_dv13, {m211 m212 m213 m214 m221 m222 m223 m224 m231 m232 m233 m234}, {coeff_dv21_dv1(1) coeff_dv21_dv1(2) coeff_dv21_dv1(3) coeff_dv21_dv1(4) coeff_dv22_dv1(1) coeff_dv22_dv1(2) coeff_dv22_dv1(3) coeff_dv22_dv1(4) coeff_dv23_dv1(1) coeff_dv23_dv1(2) coeff_dv23_dv1(3) coeff_dv23_dv1(4)});

S_dv21 = subs(S_dv21, {dv1(1) dv1(2) dv1(3)}, {S_dv11 S_dv12 S_dv13});
S_dv22 = subs(S_dv22, {dv1(1) dv1(2) dv1(3)}, {S_dv11 S_dv12 S_dv13});
S_dv23 = subs(S_dv23, {dv1(1) dv1(2) dv1(3)}, {S_dv11 S_dv12 S_dv13});


%dv1_new = [simplify(expand(S_dv11),'Steps',50); simplify(expand(S_dv12),'Steps',50); simplify(expand(S_dv13),'Steps',50)];
dv1_new = [S_dv11; S_dv12; S_dv13];
dv2_new = [S_dv21; S_dv22; S_dv23];


[dv1_new_n, dv1_new_d] = numden(dv1_new);

%%
[n1, terms_1_1] = coeffs(dv1_new_n(1), lambda, 'All');
path_f_aug11= 'get_coeff_coop_n11';
matlabFunction(n1(1),'File',path_f_aug11, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug12= 'get_coeff_coop_n12';
matlabFunction(n1(2),'File',path_f_aug12, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug13= 'get_coeff_coop_n13';
matlabFunction(n1(3),'File',path_f_aug13, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug14= 'get_coeff_coop_n14';
matlabFunction(n1(4),'File',path_f_aug14, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug15= 'get_coeff_coop_n15';
matlabFunction(n1(5),'File',path_f_aug15, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug16= 'get_coeff_coop_n16';
matlabFunction(n1(6),'File',path_f_aug16, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});

%%
[n2, terms_1_2] = coeffs(dv1_new_n(2), lambda, 'All');
path_f_aug21= 'get_coeff_coop_n21';
matlabFunction(n2(1),'File',path_f_aug21, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug22= 'get_coeff_coop_n22';
matlabFunction(n2(2),'File',path_f_aug22, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug23= 'get_coeff_coop_n23';
matlabFunction(n2(3),'File',path_f_aug23, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug24= 'get_coeff_coop_n24';
matlabFunction(n2(4),'File',path_f_aug24, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug25= 'get_coeff_coop_n25';
matlabFunction(n2(5),'File',path_f_aug25, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug26= 'get_coeff_coop_n26';
matlabFunction(n2(6),'File',path_f_aug26, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
%%
[n3, terms_1_3] = coeffs(dv1_new_n(3), lambda, 'All');
path_f_aug31= 'get_coeff_coop_n31';
matlabFunction(-n3(1),'File',path_f_aug31, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug32= 'get_coeff_coop_n32';
matlabFunction(-n3(2),'File',path_f_aug32, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug33= 'get_coeff_coop_n33';
matlabFunction(-n3(3),'File',path_f_aug33, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug34= 'get_coeff_coop_n34';
matlabFunction(-n3(4),'File',path_f_aug34, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug35= 'get_coeff_coop_n35';
matlabFunction(-n3(5),'File',path_f_aug35, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug36= 'get_coeff_coop_n36';
matlabFunction(-n3(6),'File',path_f_aug36, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
%%
[d1, terms_1_4] = coeffs(dv1_new_d(1), lambda, 'All');
path_f_aug71= 'get_coeff_coop_d11';
matlabFunction(d1(1),'File',path_f_aug71, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug72= 'get_coeff_coop_d12';
matlabFunction(d1(2),'File',path_f_aug72, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug73= 'get_coeff_coop_d13';
matlabFunction(d1(3),'File',path_f_aug73, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug74= 'get_coeff_coop_d14';
matlabFunction(d1(4),'File',path_f_aug74, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug75= 'get_coeff_coop_d15';
matlabFunction(d1(5),'File',path_f_aug75, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug76= 'get_coeff_coop_d16';
matlabFunction(d1(6),'File',path_f_aug76, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug77= 'get_coeff_coop_d17';
matlabFunction(d1(7),'File',path_f_aug77, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});

%%

[d2, terms_1_5] = coeffs(dv1_new_d(2), lambda, 'All');
[d3, terms_1_6] = coeffs(dv1_new_d(3), lambda, 'All');

[dv2_new_n, dv2_new_d] = numden(dv2_new);

[n4, terms_2_1] = coeffs(dv2_new_n(1), lambda, 'All');
path_f_aug41= 'get_coeff_coop_n41';
matlabFunction(n4(1),'File',path_f_aug41, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug42= 'get_coeff_coop_n42';
matlabFunction(n4(2),'File',path_f_aug42, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug43= 'get_coeff_coop_n43';
matlabFunction(n4(3),'File',path_f_aug43, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug44= 'get_coeff_coop_n44';
matlabFunction(n4(4),'File',path_f_aug44, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug45= 'get_coeff_coop_n45';
matlabFunction(n4(5),'File',path_f_aug45, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug46= 'get_coeff_coop_n46';
matlabFunction(n4(6),'File',path_f_aug46, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});

[n5, terms_2_2] = coeffs(dv2_new_n(2), lambda, 'All');
path_f_aug51= 'get_coeff_coop_n51';
matlabFunction(n5(1),'File',path_f_aug51, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug52= 'get_coeff_coop_n52';
matlabFunction(n5(2),'File',path_f_aug52, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug53= 'get_coeff_coop_n53';
matlabFunction(n5(3),'File',path_f_aug53, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug54= 'get_coeff_coop_n54';
matlabFunction(n5(4),'File',path_f_aug54, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug55= 'get_coeff_coop_n55';
matlabFunction(n5(5),'File',path_f_aug55, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug56= 'get_coeff_coop_n56';
matlabFunction(n5(6),'File',path_f_aug56, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});

[n6, terms_2_3] = coeffs(dv2_new_n(3), lambda, 'All');
path_f_aug61= 'get_coeff_coop_n61';
matlabFunction(n6(1),'File',path_f_aug61, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug62= 'get_coeff_coop_n62';
matlabFunction(n6(2),'File',path_f_aug62, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug63= 'get_coeff_coop_n63';
matlabFunction(n6(3),'File',path_f_aug63, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug64= 'get_coeff_coop_n64';
matlabFunction(n6(4),'File',path_f_aug64, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug65= 'get_coeff_coop_n65';
matlabFunction(n6(5),'File',path_f_aug65, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
path_f_aug66= 'get_coeff_coop_n66';
matlabFunction(n6(6),'File',path_f_aug66, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});

[d4, terms_2_4] = coeffs(dv2_new_d(1), lambda, 'All');
[d5, terms_2_5] = coeffs(dv2_new_d(2), lambda, 'All');
[d6, terms_2_6] = coeffs(dv2_new_d(3), lambda, 'All');


%% OLD TESTS

% %% get coefficients for DV1 and DV2 as function of lambda
% 
% clear
% clc
% close all
% 
% syms lambda real
% A_p = sym('A_p', [3 3], 'real');
% A_s = sym('A_s', [3 3], 'real');
% A_ps = sym('A_ps', [3 3], 'real');
% A_sp = sym('A_sp', [3 3], 'real');
% bp = sym('bp', [3 1],'real');
% bs = sym('bs', [3 1],'real');
% 
% dv1 = sym('dv1', [3 1],'real');
% dv2 = sym('dv2', [3 1],'real');
% 
% eqs1 = (eye(3)+ lambda * A_p) * dv1 - lambda * A_ps * dv2 + lambda * bp == 0;
% 
% S_dv2 = solve(eqs1, dv2);
% 
% S_dv21 = S_dv2.dv21;
% S_dv22 = S_dv2.dv22;
% S_dv23 = S_dv2.dv23;
% 
% coeff_dv21_dv1 = fliplr(coeffs(collect(S_dv21, [dv1(1), dv1(2), dv1(3)]), [dv1(1), dv1(2), dv1(3)])); % coeff di dv11, dv12, dv13, e termine noto
% 
% coeff_dv22_dv1 = fliplr(coeffs(collect(S_dv22, [dv1(1), dv1(2), dv1(3)]), [dv1(1), dv1(2), dv1(3)]));
% 
% coeff_dv23_dv1 = fliplr(coeffs(collect(S_dv23, [dv1(1), dv1(2), dv1(3)]), [dv1(1), dv1(2), dv1(3)]));
% 
% 
% syms m211 m212 m213 m214 real
% syms m221 m222 m223 m224 real
% syms m231 m232 m233 m234 real
% 
% dv2 = [(m211*dv1(1) + m212*dv1(2) + m213*dv1(3) + m214);
%        (m221*dv1(1) + m222*dv1(2) + m223*dv1(3) + m224);
%        (m231*dv1(1) + m232*dv1(2) + m233*dv1(3) + m234)];
% 
% eqs2 = (eye(3)+ lambda * A_s) * dv2 - lambda * A_sp * dv1 - lambda * bs == 0;
% 
% S_dv1 = solve(eqs2, dv1);
% 
% S_dv11 = S_dv1.dv11;
% S_dv12 = S_dv1.dv12;
% S_dv13 = S_dv1.dv13;
% 
% 
% S_dv11 = subs(S_dv11, {m211 m212 m213 m214 m221 m222 m223 m224 m231 m232 m233 m234}, {coeff_dv21_dv1(1) coeff_dv21_dv1(2) coeff_dv21_dv1(3) coeff_dv21_dv1(4) coeff_dv22_dv1(1) coeff_dv22_dv1(2) coeff_dv22_dv1(3) coeff_dv22_dv1(4) coeff_dv23_dv1(1) coeff_dv23_dv1(2) coeff_dv23_dv1(3) coeff_dv23_dv1(4)});
% S_dv12 = subs(S_dv12, {m211 m212 m213 m214 m221 m222 m223 m224 m231 m232 m233 m234}, {coeff_dv21_dv1(1) coeff_dv21_dv1(2) coeff_dv21_dv1(3) coeff_dv21_dv1(4) coeff_dv22_dv1(1) coeff_dv22_dv1(2) coeff_dv22_dv1(3) coeff_dv22_dv1(4) coeff_dv23_dv1(1) coeff_dv23_dv1(2) coeff_dv23_dv1(3) coeff_dv23_dv1(4)});
% S_dv13 = subs(S_dv13, {m211 m212 m213 m214 m221 m222 m223 m224 m231 m232 m233 m234}, {coeff_dv21_dv1(1) coeff_dv21_dv1(2) coeff_dv21_dv1(3) coeff_dv21_dv1(4) coeff_dv22_dv1(1) coeff_dv22_dv1(2) coeff_dv22_dv1(3) coeff_dv22_dv1(4) coeff_dv23_dv1(1) coeff_dv23_dv1(2) coeff_dv23_dv1(3) coeff_dv23_dv1(4)});
% 
% S_dv21 = subs(S_dv21, {dv1(1) dv1(2) dv1(3)}, {S_dv11 S_dv12 S_dv13});
% S_dv22 = subs(S_dv22, {dv1(1) dv1(2) dv1(3)}, {S_dv11 S_dv12 S_dv13});
% S_dv23 = subs(S_dv23, {dv1(1) dv1(2) dv1(3)}, {S_dv11 S_dv12 S_dv13});
% 
% 
% %dv1_new = [simplify(expand(S_dv11),'Steps',50); simplify(expand(S_dv12),'Steps',50); simplify(expand(S_dv13),'Steps',50)];
% dv1_new = [S_dv11; S_dv12; S_dv13];
% dv2_new = [S_dv21; S_dv22; S_dv23];
% 
% 
% [dv1_new_n, dv1_new_d] = numden(dv1_new);
% 
% [n1, terms_1_1] = coeffs(dv1_new_n(1), lambda, 'All');
% 
% path_f_aug1= 'get_coeff_coop_n1_new';
% matlabFunction(n1,'File',path_f_aug1, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
% 
% 
% 
% 
% 
% 
% 
% [n2, terms_1_2] = coeffs(dv1_new_n(2), lambda, 'All');
% [n3, terms_1_3] = coeffs(dv1_new_n(3), lambda, 'All');
% 
% [d1, terms_1_4] = coeffs(dv1_new_d(1), lambda, 'All');
% [d2, terms_1_5] = coeffs(dv1_new_d(2), lambda, 'All');
% [d3, terms_1_6] = coeffs(dv1_new_d(3), lambda, 'All');
% 
% [dv2_new_n, dv2_new_d] = numden(dv2_new);
% 
% [n4, terms_2_1] = coeffs(dv2_new_n(1), lambda, 'All');
% [n5, terms_2_2] = coeffs(dv2_new_n(2), lambda, 'All');
% [n6, terms_2_3] = coeffs(dv2_new_n(3), lambda, 'All');
% 
% [d4, terms_2_4] = coeffs(dv2_new_d(1), lambda, 'All');
% [d5, terms_2_5] = coeffs(dv2_new_d(2), lambda, 'All');
% [d6, terms_2_6] = coeffs(dv2_new_d(3), lambda, 'All');
% 
% path_f_aug1= 'get_coeff_coop_n1_new';
% matlabFunction(n1,'File',path_f_aug1, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
% path_f_aug2= 'get_coeff_coop_n2_new';
% matlabFunction(n2,'File',path_f_aug2, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
% path_f_aug3= 'get_coeff_coop_n3_new';
% matlabFunction(-n3,'File',path_f_aug3, 'Vars', {A_p, A_s, A_ps, A_sp, bp, bs});
% path_f_aug4= 'get_coeff_coop_n4_new';
% matlabFunction(n4,'File',path_f_aug4, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
% path_f_aug5= 'get_coeff_coop_n5_new';
% matlabFunction(n5,'File',path_f_aug5, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
% path_f_aug6= 'get_coeff_coop_n6_new';
% matlabFunction(n6,'File',path_f_aug6, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
% 
% path_f_aug7= 'get_coeff_coop_d_new';
% matlabFunction(d1,'File',path_f_aug7, 'Vars',  {A_p, A_s, A_ps, A_sp, bp, bs});
% 
% 
% 

% %% TEST 1
% clear
% clc
% close all
% 
% syms lambda real
% A_p = sym('A_p', [3 3], 'real');
% A_s = sym('A_s', [3 3], 'real');
% A_ps = sym('A_ps', [3 3], 'real');
% A_sp = sym('A_sp', [3 3], 'real');
% bp = sym('bp', [3 1],'real');
% bs = sym('bs', [3 1],'real');
% 
% dv1 = sym('dv1', [3 1],'real');
% dv2 = sym('dv2', [3 1],'real');
% 
% % eqs = [(eye(3)+ lambda * A_p) * dv1 - lambda * A_ps * dv2 + lambda * bp == 0;
% %        (eye(3)+ lambda * A_s) * dv2 - lambda * A_sp * dv1 - lambda * bs == 0];
% 
% eqs1 = (eye(3)+ lambda * A_p) * dv1 - lambda * A_ps * dv2 + lambda * bp == 0;
% 
% %S = solve(eqs, [dv1, dv2]);
% 
% S_dv2 = solve(eqs1, dv2);
% 
% dv2_sym = [S_dv2.dv21;S_dv2.dv22;S_dv2.dv23];
% 
% [coeff_dv21, terms_dv21] = coeffs(dv2_sym(1), dv1);
% 
% %%
% path_f_aug1= 'get_coeff_coop_dv21';
% matlabFunction(coeff_dv21,'File',path_f_aug1, 'Vars',  {A_p, A_ps,bp, lambda});

% %% TEST 2
% clear
% clc
% close all 
% 
% syms lambda real
% 
% M0 = sym('M0', [3 3], 'real');
% M1 = sym('M1', [3 3], 'real');
% M2 = sym('M2', [3 3], 'real');
% M5 = sym('M5', [3 3], 'real');
% 
% m3 = sym('m3', [3 1],'real');
% m4 = sym('m4', [3 1],'real');
% 
% deltav_1 = (M0 + M1*lambda + M2*lambda^2) \ (m3*lambda + m4*lambda^2);
% 
% [dv_1_n, dv_1_d] = numden(deltav_1);
% 
% [n1, terms_1_1] = coeffs(dv_1_n(1), lambda, 'All');
% [n2, terms_1_2] = coeffs(dv_1_n(2), lambda, 'All');
% [n3, terms_1_3] = coeffs(dv_1_n(3), lambda, 'All');
% 
% [d1, terms_1_4] = coeffs(dv_1_d(1), lambda, 'All');
% [d2, terms_1_5] = coeffs(dv_1_d(2), lambda, 'All');
% [d3, terms_1_6] = coeffs(dv_1_d(3), lambda, 'All');
% 
% deltav_2 = -m3 + (M0/lambda + M5)*deltav_1;
% 
% [dv_2_n, dv_2_d] = numden(deltav_2);
% 
% [n4, terms_2_1] = coeffs(dv_2_n(1), lambda, 'All');
% [n5, terms_2_2] = coeffs(dv_2_n(2), lambda, 'All');
% [n6, terms_2_3] = coeffs(dv_2_n(3), lambda, 'All');
% 
% [d4, terms_2_4] = coeffs(dv_2_d(1), lambda, 'All');
% [d5, terms_2_5] = coeffs(dv_2_d(2), lambda, 'All');
% [d6, terms_2_6] = coeffs(dv_2_d(3), lambda, 'All');
% 
% 
% path_f_aug1= 'get_coeff_coop_n1';
% matlabFunction(n1,'File',path_f_aug1, 'Vars',  {M0, M1, M2, M5, m3, m4});
% path_f_aug2= 'get_coeff_coop_n2';
% matlabFunction(n2,'File',path_f_aug2, 'Vars',  {M0, M1, M2, M5, m3, m4});
% path_f_aug3= 'get_coeff_coop_n3';
% matlabFunction(n3,'File',path_f_aug3, 'Vars',  {M0, M1, M2, M5, m3, m4});
% path_f_aug4= 'get_coeff_coop_n4';
% matlabFunction(n4,'File',path_f_aug4, 'Vars',  {M0, M1, M2, M5, m3, m4});
% path_f_aug5= 'get_coeff_coop_n5';
% matlabFunction(n5,'File',path_f_aug5, 'Vars',  {M0, M1, M2, M5, m3, m4});
% path_f_aug6= 'get_coeff_coop_n6';
% matlabFunction(n6,'File',path_f_aug6, 'Vars',  {M0, M1, M2, M5, m3, m4});
% 
% path_f_aug7= 'get_coeff_coop_d';
% matlabFunction(d1,'File',path_f_aug7, 'Vars',  {M0, M1, M2, M5, m3, m4});

% %% TEST 3
% clear
% clc
% 
% syms lambda b0 real
% 
% bp_T = sym('bp_T', [1 3],'real');
% bs_T = sym('bs_T', [1 3],'real');
% 
% A_p = sym('A_p', [3 3], 'real');
% A_s = sym('A_s', [3 3], 'real');
% A_ps = sym('A_ps', [3 3], 'real');
% A_sp = sym('A_sp', [3 3], 'real');
% 
% n1 = sym('n1', [1 7],'real');
% n2 = sym('n2', [1 7],'real');
% n3 = sym('n3', [1 7],'real');
% n4 = sym('n4', [1 7],'real');
% n5 = sym('n5', [1 7],'real');
% n6 = sym('n6', [1 7],'real');
% d = sym('d', [1 7],'real');
% 
% n1(7) = 0;
% n2(7) = 0;
% n3(7) = 0;
% 
% n4(7) = 0;
% n5(7) = 0;
% n6(7) = 0;
% 
% dv1 = [( poly2sym(n1, lambda) ) ;
%          ( poly2sym(n2, lambda) ) ;
%          ( poly2sym(n3, lambda) ) ] ./ poly2sym(d, lambda);
% 
% dv2 = [( poly2sym(n4, lambda) ) ;
%          ( poly2sym(n5, lambda) ) ;
%          ( poly2sym(n6, lambda) ) ] ./ poly2sym(d, lambda);
% 
% den = (poly2sym(d, lambda));
% 
% eq_lambda = b0 + 2 * bp_T * dv1 - 2 * bs_T * dv2 + dv1.' * A_p * dv1 + ...
%     dv2.' * A_s * dv2 - dv1.' * A_ps * dv2 - dv2.' * A_sp * dv1;
% 
% [eq_l_n, eq_l_d] = numden(simplify(eq_lambda));
% 
% [coeff_lambda_n, terms] = coeffs(simplify(eq_l_n), lambda, 'All');
% [coeff_lambda_d, terms2] = coeffs(simplify(eq_l_d), lambda, 'All');
% 
% 
% syms n17 n27 n37 n47 n57 n67 real
% 
% n1(7) = n17;
% n2(7) = n27;
% n3(7) = n37;
% 
% n4(7) = n47;
% n5(7) = n57;
% n6(7) = n67;
% 
% path_f_aug8= 'get_coeff_coop_l_newnew';
% matlabFunction(simplify(coeff_lambda_n),'File',path_f_aug8, 'Vars', {b0, bp_T, bs_T, A_p, A_s, A_ps, A_sp, n1, n2, n3, n4, n5, n6, d});
% 


% %% TEST 4
% syms b0 real
% 
% dv1_new = [S_dv11; S_dv12; S_dv13];
% dv2_new = [S_dv21; S_dv22; S_dv23];
% 
% eq_lambda = b0 + 2 * bp.' * dv1_new - 2 * bs.' * dv2_new + dv1_new.' * A_p * dv1_new + ...
%     dv2_new.' * A_s * dv2_new - dv1_new.' * A_ps * dv2_new - dv2_new.' * A_sp * dv1_new;

% %%
% 
% [eq_l_n, eq_l_d] = numden(eq_lambda);
% 
% %%
% [coeff_lambda_n, terms] = coeffs(eq_l_n, lambda, 'All');
% [coeff_lambda_d, terms2] = coeffs(eq_l_d, lambda, 'All');
