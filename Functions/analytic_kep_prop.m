function[yf]=analytic_kep_prop(y0, t_vect, mu)
    T0_et = 6e8;
    T0_utc = cspice_unitim(T0_et, 'ET', 'TDT');
    
    % compute keplerian elements at time t0
    elems_0 = cspice_oscelt(y0, T0_et, mu);
    dt = diff(t_vect);
    Tf_utc = T0_utc + dt;
    Tf_et = cspice_unitim(Tf_utc, 'ET', 'TDT');

    % From orbital elements to state
    a_1 = elems_0(1)/(1-elems_0(2));
    n_1 = (elems_0(8)/(a_1^3))^(1/2);
    M_1 = elems_0(6) + n_1 *  dt;
    elems_0(6) = M_1;
    elems_0(7) = Tf_et;
    yf = cspice_conics(elems_0, Tf_et);
end