function n4 = get_coeff_coop_n4_newnew(A_p, A_s, A_ps, A_sp, bp, bs)


n41 = get_coeff_coop_n41(A_p, A_s, A_ps, A_sp, bp, bs);
n42 = get_coeff_coop_n42(A_p, A_s, A_ps, A_sp, bp, bs);
n43 = get_coeff_coop_n43(A_p, A_s, A_ps, A_sp, bp, bs);
n44 = get_coeff_coop_n44(A_p, A_s, A_ps, A_sp, bp, bs);
n45 = get_coeff_coop_n45(A_p, A_s, A_ps, A_sp, bp, bs);
n46 = get_coeff_coop_n46(A_p, A_s, A_ps, A_sp, bp, bs);

n4 = [n41, n42, n43, n44, n45, n46, 0];