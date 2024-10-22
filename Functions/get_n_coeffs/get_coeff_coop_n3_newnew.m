function n3 = get_coeff_coop_n3_newnew(A_p, A_s, A_ps, A_sp, bp, bs)


n31 = get_coeff_coop_n31(A_p, A_s, A_ps, A_sp, bp, bs);
n32 = get_coeff_coop_n32(A_p, A_s, A_ps, A_sp, bp, bs);
n33 = get_coeff_coop_n33(A_p, A_s, A_ps, A_sp, bp, bs);
n34 = get_coeff_coop_n34(A_p, A_s, A_ps, A_sp, bp, bs);
n35 = get_coeff_coop_n35(A_p, A_s, A_ps, A_sp, bp, bs);
n36 = get_coeff_coop_n36(A_p, A_s, A_ps, A_sp, bp, bs);

n3 = [n31, n32, n33, n34, n35, n36, 0];