function d1 = get_coeff_coop_d_newnew(A_p, A_s, A_ps, A_sp, bp, bs)


d11 = get_coeff_coop_d11(A_p, A_s, A_ps, A_sp, bp, bs);
d12 = get_coeff_coop_d12(A_p, A_s, A_ps, A_sp, bp, bs);
d13 = get_coeff_coop_d13(A_p, A_s, A_ps, A_sp, bp, bs);
d14 = get_coeff_coop_d14(A_p, A_s, A_ps, A_sp, bp, bs);
d15 = get_coeff_coop_d15(A_p, A_s, A_ps, A_sp, bp, bs);
d16 = get_coeff_coop_d16(A_p, A_s, A_ps, A_sp, bp, bs);
d17 = get_coeff_coop_d17(A_p, A_s, A_ps, A_sp, bp, bs);

d1 = [d11, d12, d13, d14, d15, d16, d17];