function DV_norm_tot = dv_tot(DV_vect)

DV1 = DV_vect(1:3);
DV2 = DV_vect(4:6);

DV_norm_tot = norm(DV1) + norm(DV2);

end