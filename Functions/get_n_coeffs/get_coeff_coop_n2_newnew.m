function n2 = get_coeff_coop_n2_newnew(A_p, A_s, A_ps, A_sp, bp, bs)

n21 = get_coeff_coop_n21(A_p, A_s, A_ps, A_sp, bp, bs);
n22 = get_coeff_coop_n22(A_p, A_s, A_ps, A_sp, bp, bs);
n23 = get_coeff_coop_n23(A_p, A_s, A_ps, A_sp, bp, bs);
n24 = get_coeff_coop_n24(A_p, A_s, A_ps, A_sp, bp, bs);
n25 = get_coeff_coop_n25(A_p, A_s, A_ps, A_sp, bp, bs);
n26 = get_coeff_coop_n26(A_p, A_s, A_ps, A_sp, bp, bs);

n2 = [n21, n22, n23, n24, n25, n26, 0];