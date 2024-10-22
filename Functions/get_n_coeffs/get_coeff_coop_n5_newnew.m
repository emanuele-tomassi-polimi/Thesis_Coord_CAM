function n5 = get_coeff_coop_n5_newnew(A_p, A_s, A_ps, A_sp, bp, bs)


n51 = get_coeff_coop_n51(A_p, A_s, A_ps, A_sp, bp, bs);
n52 = get_coeff_coop_n52(A_p, A_s, A_ps, A_sp, bp, bs);
n53 = get_coeff_coop_n53(A_p, A_s, A_ps, A_sp, bp, bs);
n54 = get_coeff_coop_n54(A_p, A_s, A_ps, A_sp, bp, bs);
n55 = get_coeff_coop_n55(A_p, A_s, A_ps, A_sp, bp, bs);
n56 = get_coeff_coop_n56(A_p, A_s, A_ps, A_sp, bp, bs);

n5 = [n51, n52, n53, n54, n55, n56, 0];