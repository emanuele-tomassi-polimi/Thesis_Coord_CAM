function coeff_tot = get_coeff(in1,in2,gamma)
%GET_COEFF
%    COEFF_TOT = GET_COEFF(IN1,IN2,GAMMA)

%    This function was generated by the Symbolic Math Toolbox version 9.2.
%    18-Jan-2024 02:09:28

T1_1 = in1(1);
T1_2 = in1(4);
T1_3 = in1(7);
T2_1 = in1(2);
T2_2 = in1(5);
T2_3 = in1(8);
T3_1 = in1(3);
T3_2 = in1(6);
T3_3 = in1(9);
beta1 = in2(1,:);
beta2 = in2(2,:);
beta3 = in2(3,:);
t2 = T1_1.*T2_2;
t3 = T1_2.*T2_1;
t4 = T1_1.*T2_3;
t5 = T1_3.*T2_1;
t6 = T1_2.*T2_3;
t7 = T1_3.*T2_2;
t8 = T1_1.*T3_2;
t9 = T1_2.*T3_1;
t10 = T1_1.*T3_3;
t11 = T1_3.*T3_1;
t12 = T1_2.*T3_3;
t13 = T1_3.*T3_2;
t14 = T2_1.*T3_2;
t15 = T2_2.*T3_1;
t16 = T2_1.*T3_3;
t17 = T2_3.*T3_1;
t18 = T2_2.*T3_3;
t19 = T2_3.*T3_2;
t20 = T1_1+T2_2;
t21 = T1_1+T3_3;
t22 = T2_2+T3_3;
t23 = T1_1.*beta1;
t24 = T1_2.*beta1;
t25 = T1_2.*beta2;
t26 = T1_3.*beta1;
t27 = T1_3.*beta3;
t28 = T2_1.*beta1;
t29 = T2_1.*beta2;
t30 = T2_2.*beta2;
t31 = T2_3.*beta2;
t32 = T2_3.*beta3;
t33 = T3_1.*beta1;
t34 = T3_1.*beta3;
t35 = T3_2.*beta2;
t36 = T3_2.*beta3;
t37 = T3_3.*beta3;
t38 = T3_3.*t2;
t39 = T3_2.*t4;
t40 = T3_3.*t3;
t41 = T3_1.*t6;
t42 = T3_2.*t5;
t43 = T3_1.*t7;
t44 = T3_3+t20;
t45 = -t3;
t46 = -t5;
t47 = -t7;
t48 = -t9;
t49 = -t11;
t50 = -t13;
t51 = -t15;
t52 = -t17;
t53 = -t19;
t54 = beta3.*t20;
t55 = beta2.*t21;
t56 = beta1.*t22;
t72 = t23+t29+t34;
t73 = t24+t30+t36;
t74 = t26+t31+t37;
t57 = -t39;
t58 = -t40;
t59 = -t43;
t60 = -t54;
t61 = -t55;
t62 = -t56;
t63 = t2+t45;
t64 = t4+t46;
t65 = t6+t47;
t66 = t8+t48;
t67 = t10+t49;
t68 = t12+t50;
t69 = t14+t51;
t70 = t16+t52;
t71 = t18+t53;
t75 = beta3.*t63;
t76 = beta3.*t64;
t77 = beta3.*t65;
t78 = beta2.*t66;
t79 = beta2.*t67;
t80 = beta2.*t68;
t81 = beta1.*t69;
t82 = beta1.*t70;
t83 = beta1.*t71;
t87 = t25+t27+t62;
t88 = t28+t32+t61;
t89 = t33+t35+t60;
t99 = t63+t67+t71;
t100 = t38+t41+t42+t57+t58+t59;
t84 = -t78;
t85 = -t79;
t86 = -t80;
t90 = T1_1.*t87;
t91 = T1_2.*t87;
t92 = T1_3.*t87;
t93 = T2_1.*t88;
t94 = T2_2.*t88;
t95 = T2_3.*t88;
t96 = T3_1.*t89;
t97 = T3_2.*t89;
t98 = T3_3.*t89;
t101 = t75+t81+t84;
t102 = t76+t82+t85;
t103 = t77+t83+t86;
t116 = t90+t93+t96;
t117 = t91+t94+t97;
t118 = t92+t95+t98;
t104 = T1_1.*t103;
t105 = T1_2.*t103;
t106 = T1_3.*t103;
t107 = T2_1.*t102;
t108 = T2_2.*t102;
t109 = T2_3.*t102;
t110 = T3_1.*t101;
t111 = T3_2.*t101;
t112 = T3_3.*t101;
t113 = -t107;
t114 = -t108;
t115 = -t109;
t119 = t104+t110+t113;
t120 = t105+t111+t114;
t121 = t106+t112+t115;
mt1 = [gamma,gamma.*t44.*2.0-beta1.^2.*2.0-beta2.^2.*2.0-beta3.^2.*2.0,beta1.*t72+beta2.*t73+beta3.*t74+beta1.*(t25.*2.0+t27.*2.0-t56.*2.0-beta1.*t44.*2.0)+beta2.*(t28.*2.0+t32.*2.0-t55.*2.0-beta2.*t44.*2.0)+beta3.*(t33.*2.0+t35.*2.0-t54.*2.0-beta3.*t44.*2.0)+gamma.*(t2.*2.0-t3.*2.0+t10.*2.0-t11.*2.0+t18.*2.0-t19.*2.0+t44.^2)];
mt2 = [-beta3.*(t118+T1_3.*t72+T2_3.*t73-t20.*t74)-beta2.*(t117+T1_2.*t72+T3_2.*t74-t21.*t73)-beta1.*(t116+T2_1.*t73+T3_1.*t74-t22.*t72)+gamma.*(t38.*2.0-t39.*2.0-t40.*2.0+t41.*2.0+t42.*2.0-t43.*2.0+t44.*t99.*2.0)-beta1.*(t77.*2.0-t80.*2.0+t83.*2.0+beta1.*t99.*2.0-t25.*t44.*2.0-t27.*t44.*2.0+t44.*t56.*2.0)+beta2.*(t76.*2.0-t79.*2.0+t82.*2.0-beta2.*t99.*2.0+t28.*t44.*2.0+t32.*t44.*2.0-t44.*t55.*2.0)-beta3.*(t75.*2.0-t78.*2.0+t81.*2.0+beta3.*t99.*2.0-t33.*t44.*2.0-t35.*t44.*2.0+t44.*t54.*2.0)];
mt3 = [beta3.*(t121+T1_3.*t116+T2_3.*t117+t63.*t74-t64.*t73+t65.*t72-t20.*t118)+beta2.*(t120+T1_2.*t116+T3_2.*t118-t21.*t117-t66.*t74+t67.*t73-t68.*t72)+beta1.*(t119+T2_1.*t117+T3_1.*t118-t22.*t116+t69.*t74-t70.*t73+t71.*t72)-beta1.*(beta1.*t100.*2.0+t44.*t77.*2.0-t25.*t99.*2.0-t44.*t80.*2.0-t27.*t99.*2.0+t44.*t83.*2.0+t56.*t99.*2.0)+beta2.*(beta2.*t100.*-2.0+t44.*t76.*2.0-t44.*t79.*2.0+t44.*t82.*2.0+t28.*t99.*2.0+t32.*t99.*2.0-t55.*t99.*2.0)-beta3.*(beta3.*t100.*2.0+t44.*t75.*2.0-t44.*t78.*2.0+t44.*t81.*2.0-t33.*t99.*2.0-t35.*t99.*2.0+t54.*t99.*2.0)+gamma.*(t44.*t100.*2.0+t99.^2)];
mt4 = [-beta3.*(T1_3.*t119+T2_3.*t120-t20.*t121+t63.*t118-t64.*t117+t65.*t116)-beta2.*(T1_2.*t119+T3_2.*t121-t21.*t120-t66.*t118+t67.*t117-t68.*t116)-beta1.*(T2_1.*t120+T3_1.*t121-t22.*t119+t69.*t118-t70.*t117+t71.*t116)+beta1.*(t25.*t100.*2.0+t27.*t100.*2.0-t56.*t100.*2.0-t77.*t99.*2.0+t80.*t99.*2.0-t83.*t99.*2.0)+beta2.*(t28.*t100.*2.0+t32.*t100.*2.0-t55.*t100.*2.0+t76.*t99.*2.0-t79.*t99.*2.0+t82.*t99.*2.0)+beta3.*(t33.*t100.*2.0+t35.*t100.*2.0-t54.*t100.*2.0-t75.*t99.*2.0+t78.*t99.*2.0-t81.*t99.*2.0)+gamma.*t99.*t100.*2.0];
mt5 = [gamma.*t100.^2-beta3.*(t75.*t100.*2.0-t78.*t100.*2.0+t81.*t100.*2.0)+beta2.*(t76.*t100.*2.0-t79.*t100.*2.0+t82.*t100.*2.0)-beta1.*(t77.*t100.*2.0-t80.*t100.*2.0+t83.*t100.*2.0)+beta3.*(t63.*t121-t64.*t120+t65.*t119)-beta2.*(t66.*t121-t67.*t120+t68.*t119)+beta1.*(t69.*t121-t70.*t120+t71.*t119)];
coeff_tot = [mt1,mt2,mt3,mt4,mt5];
