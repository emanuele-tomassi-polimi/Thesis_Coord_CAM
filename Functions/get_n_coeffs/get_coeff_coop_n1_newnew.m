function n1 = get_coeff_coop_n1_newnew(A_p, A_s, A_ps, A_sp, bp, bs)


n11 = get_coeff_coop_n11(A_p, A_s, A_ps, A_sp, bp, bs);
n12 = get_coeff_coop_n12(A_p, A_s, A_ps, A_sp, bp, bs);
n13 = get_coeff_coop_n13(A_p, A_s, A_ps, A_sp, bp, bs);
n14 = get_coeff_coop_n14(A_p, A_s, A_ps, A_sp, bp, bs);
n15 = get_coeff_coop_n15(A_p, A_s, A_ps, A_sp, bp, bs);
n16 = get_coeff_coop_n16(A_p, A_s, A_ps, A_sp, bp, bs);

n1 = [n11, n12, n13, n14, n15, n16, 0];
