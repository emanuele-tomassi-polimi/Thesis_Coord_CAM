/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * explicitRungeKutta.c
 *
 * Code generation for function 'explicitRungeKutta'
 *
 */

/* Include files */
#include "explicitRungeKutta.h"
#include "kep_prop.h"
#include "rt_nonfinite.h"
#include "mwmathutil.h"

/* Function Definitions */
void computeCEStages78(real_T c_df_workspace_ODEFunction_work,
                       const real_T y[6], real_T h, real_T f[72],
                       int32_T *nfevals)
{
  real_T b_y[6];
  int32_T i;
  for (i = 0; i < 6; i++) {
    b_y[i] = y[i] + h * (((((((0.044279894190079508 * f[i] +
                               0.3541049391724449 * f[i + 6]) +
                              0.2479692154956438 * f[i + 12]) +
                             -15.694202038838084 * f[i + 18]) +
                            25.084064965558564 * f[i + 24]) +
                           -31.738367786260277 * f[i + 30]) +
                          22.938283273988784 * f[i + 36]) +
                         -0.23613246330715421 * f[i + 42]);
  }
  kep_prop_anonFcn1(c_df_workspace_ODEFunction_work, b_y,
                    *(real_T(*)[6]) & f[48]);
  for (i = 0; i < 6; i++) {
    b_y[i] = y[i] + h * ((((((((0.046207006467549633 * f[i] +
                                0.045039041608424805 * f[i + 6]) +
                               0.23368166977134244 * f[i + 12]) +
                              37.839013684210677 * f[i + 18]) +
                             -15.949113289454246 * f[i + 24]) +
                            23.028368351816102 * f[i + 30]) +
                           -44.855785077694122 * f[i + 36]) +
                          -0.063798587686474437 * f[i + 42]) +
                         -0.012595035543861663 * f[i + 48]);
  }
  kep_prop_anonFcn1(c_df_workspace_ODEFunction_work, b_y,
                    *(real_T(*)[6]) & f[54]);
  for (i = 0; i < 6; i++) {
    b_y[i] = y[i] + h * (((((((((0.050379468554820409 * f[i] +
                                 0.041098361310460796 * f[i + 6]) +
                                0.17180541533481958 * f[i + 12]) +
                               4.614105319981519 * f[i + 18]) +
                              -1.7916678830853965 * f[i + 24]) +
                             2.5316589304850412 * f[i + 30]) +
                            -5.3249778602057312 * f[i + 36]) +
                           -0.030655325953856349 * f[i + 42]) +
                          -0.0052544799794296132 * f[i + 48]) +
                         -0.083991946442247931 * f[i + 54]);
  }
  kep_prop_anonFcn1(c_df_workspace_ODEFunction_work, b_y,
                    *(real_T(*)[6]) & f[60]);
  for (i = 0; i < 6; i++) {
    b_y[i] = y[i] + h * ((((((((((0.0408289713299708 * f[i] +
                                  0.42444795142476321 * f[i + 6]) +
                                 0.23260915312752345 * f[i + 12]) +
                                2.6779825207118062 * f[i + 18]) +
                               0.74208266573389448 * f[i + 24]) +
                              0.14603778479414611 * f[i + 30]) +
                             -3.5793445098905652 * f[i + 36]) +
                            0.11388443896001738 * f[i + 42]) +
                           0.012677906510331901 * f[i + 48]) +
                          -0.074434363499466749 * f[i + 54]) +
                         0.047827480797578516 * f[i + 60]);
  }
  kep_prop_anonFcn1(c_df_workspace_ODEFunction_work, b_y,
                    *(real_T(*)[6]) & f[66]);
  *nfevals += 4;
}

void computeMainStages78(real_T c_df_workspace_ODEFunction_work,
                         const real_T y[6], real_T h, real_T f[72],
                         int32_T *nfevals, real_T fC[6], real_T fE[6])
{
  real_T b_y[6];
  real_T f2[6];
  real_T f4[6];
  real_T a;
  int32_T i;
  a = h * 0.05;
  for (i = 0; i < 6; i++) {
    b_y[i] = y[i] + a * f[i];
  }
  kep_prop_anonFcn1(c_df_workspace_ODEFunction_work, b_y, f2);
  for (i = 0; i < 6; i++) {
    b_y[i] = y[i] + h * (-0.0069931640625 * f[i] + 0.1135556640625 * f2[i]);
  }
  kep_prop_anonFcn1(c_df_workspace_ODEFunction_work, b_y, f2);
  for (i = 0; i < 6; i++) {
    b_y[i] = y[i] + h * (0.0399609375 * f[i] + 0.1198828125 * f2[i]);
  }
  kep_prop_anonFcn1(c_df_workspace_ODEFunction_work, b_y, f4);
  for (i = 0; i < 6; i++) {
    b_y[i] =
        y[i] + h * ((0.36139756280045754 * f[i] + -1.3415240667004928 * f2[i]) +
                    1.3701265039000352 * f4[i]);
  }
  kep_prop_anonFcn1(c_df_workspace_ODEFunction_work, b_y, f2);
  for (i = 0; i < 6; i++) {
    b_y[i] = y[i] +
             h * ((0.049047202797202795 * f[i] + 0.23509720422144048 * f4[i]) +
                  0.18085559298135673 * f2[i]);
  }
  kep_prop_anonFcn1(c_df_workspace_ODEFunction_work, b_y,
                    *(real_T(*)[6]) & f[6]);
  for (i = 0; i < 6; i++) {
    b_y[i] = y[i] +
             h * (((0.06169289044289044 * f[i] + 0.11236568314640277 * f4[i]) +
                   -0.038850460714513667 * f2[i]) +
                  0.01979188712522046 * f[i + 6]);
  }
  kep_prop_anonFcn1(c_df_workspace_ODEFunction_work, b_y,
                    *(real_T(*)[6]) & f[12]);
  for (i = 0; i < 6; i++) {
    b_y[i] = y[i] + h * ((((-1.767630240222327 * f[i] + -62.5 * f4[i]) +
                           -6.0618893773766693 * f2[i]) +
                          5.6508231982227635 * f[i + 6]) +
                         65.621696419376235 * f[i + 12]);
  }
  kep_prop_anonFcn1(c_df_workspace_ODEFunction_work, b_y,
                    *(real_T(*)[6]) & f[18]);
  for (i = 0; i < 6; i++) {
    b_y[i] =
        y[i] +
        h * (((((-1.1809450665549708 * f[i] + -41.504734411143211 * f4[i]) +
                -4.4344383191037249 * f2[i]) +
               4.2604081885861333 * f[i + 6]) +
              43.753640224461719 * f[i + 12]) +
             0.00787142548991231 * f[i + 18]);
  }
  kep_prop_anonFcn1(c_df_workspace_ODEFunction_work, b_y,
                    *(real_T(*)[6]) & f[24]);
  for (i = 0; i < 6; i++) {
    b_y[i] =
        y[i] +
        h * ((((((-1.2814059994414884 * f[i] + -45.047139960139866 * f4[i]) +
                 -4.7313620694495766 * f2[i]) +
                4.5149670165938076 * f[i + 6]) +
               47.449095571729849 * f[i + 12]) +
              0.010592282971116612 * f[i + 18]) +
             -0.0057468422638446166 * f[i + 24]);
  }
  kep_prop_anonFcn1(c_df_workspace_ODEFunction_work, b_y,
                    *(real_T(*)[6]) & f[30]);
  for (i = 0; i < 6; i++) {
    b_y[i] =
        y[i] +
        h * (((((((-1.7244701342624853 * f[i] + -60.92349008483054 * f4[i]) +
                  -5.9515183762223929 * f2[i]) +
                 5.5565237306984558 * f[i + 6]) +
                63.983011980333053 * f[i + 12]) +
               0.014642028250414961 * f[i + 18]) +
              0.064604087723582032 * f[i + 24]) +
             -0.0793032316900888 * f[i + 30]);
  }
  kep_prop_anonFcn1(c_df_workspace_ODEFunction_work, b_y,
                    *(real_T(*)[6]) & f[36]);
  for (i = 0; i < 6; i++) {
    b_y[i] =
        y[i] +
        h * ((((((((-3.301622667747079 * f[i] + -118.01127235975251 * f4[i]) +
                   -10.141422388456112 * f2[i]) +
                  9.139311332232058 * f[i + 6]) +
                 123.37594282840426 * f[i + 12]) +
                4.62324437887458 * f[i + 18]) +
               -3.3832777380682018 * f[i + 24]) +
              4.5275921003246182 * f[i + 30]) +
             -5.8284954858116231 * f[i + 36]);
  }
  kep_prop_anonFcn1(c_df_workspace_ODEFunction_work, b_y,
                    *(real_T(*)[6]) & f[42]);
  *nfevals += 11;
  for (i = 0; i < 6; i++) {
    fC[i] = ((((((0.044279894190079508 * f[i] + 0.3541049391724449 * f[i + 6]) +
                 0.2479692154956438 * f[i + 12]) +
                -15.694202038838084 * f[i + 18]) +
               25.084064965558564 * f[i + 24]) +
              -31.738367786260277 * f[i + 30]) +
             22.938283273988784 * f[i + 36]) +
            -0.23613246330715421 * f[i + 42];
  }
  for (i = 0; i < 6; i++) {
    f4[i] =
        y[i] +
        h * (((((((-3.039515033766309 * f[i] + -109.26086808941763 * f4[i]) +
                  -9.2906424974002935 * f2[i]) +
                 8.43050498176491 * f[i + 6]) +
                114.20100103783314 * f[i + 12]) +
               -0.96372713421454792 * f[i + 18]) +
              -5.0348840888021895 * f[i + 24]) +
             5.9581308240029234 * f[i + 30]);
  }
  kep_prop_anonFcn1(c_df_workspace_ODEFunction_work, f4, fE);
  for (i = 0; i < 6; i++) {
    fE[i] = (((((((3.2721039010287758E-5 * f[i] +
                   0.0005046250618777735 * f[i + 6]) +
                  -0.00012117235897844563 * f[i + 12]) +
                 20.142336771313868 * f[i + 18]) +
                -5.2371785994398277 * f[i + 24]) +
               8.1567444087946583 * f[i + 30]) +
              -22.938283273988784 * f[i + 36]) +
             0.23613246330715421 * f[i + 42]) +
            -0.36016794372897754 * fE[i];
  }
  (*nfevals)++;
}

real_T maxScaledError(real_T threshold, const real_T fE[6], const real_T y[6],
                      const real_T ynew[6])
{
  real_T mxerr;
  int32_T k;
  mxerr = 0.0;
  for (k = 0; k < 6; k++) {
    real_T d1;
    real_T d2;
    real_T num;
    num = muDoubleScalarAbs(fE[k]);
    d1 = muDoubleScalarAbs(y[k]);
    d2 = muDoubleScalarAbs(ynew[k]);
    if ((d1 > d2) || muDoubleScalarIsNaN(d2)) {
      if (d1 > threshold) {
        num /= d1;
      } else {
        num /= threshold;
      }
    } else if (d2 > threshold) {
      num /= d2;
    } else {
      num /= threshold;
    }
    if ((num > mxerr) || muDoubleScalarIsNaN(num)) {
      mxerr = num;
    }
  }
  return mxerr;
}

/* End of code generation (explicitRungeKutta.c) */
