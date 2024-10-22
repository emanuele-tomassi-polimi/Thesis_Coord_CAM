function n6 = get_coeff_coop_n6_newnew(A_p, A_s, A_ps, A_sp, bp, bs)


n61 = get_coeff_coop_n61(A_p, A_s, A_ps, A_sp, bp, bs);
n62 = get_coeff_coop_n62(A_p, A_s, A_ps, A_sp, bp, bs);
n63 = get_coeff_coop_n63(A_p, A_s, A_ps, A_sp, bp, bs);
n64 = get_coeff_coop_n64(A_p, A_s, A_ps, A_sp, bp, bs);
n65 = get_coeff_coop_n65(A_p, A_s, A_ps, A_sp, bp, bs);
n66 = get_coeff_coop_n66(A_p, A_s, A_ps, A_sp, bp, bs);

n6 = [n61, n62, n63, n64, n65, n66, 0];