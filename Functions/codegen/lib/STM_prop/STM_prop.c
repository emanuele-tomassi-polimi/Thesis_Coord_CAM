/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * STM_prop.c
 *
 * Code generation for function 'STM_prop'
 *
 */

/* Include files */
#include "STM_prop.h"
#include "STM_prop_emxutil.h"
#include "STM_prop_types.h"
#include "rt_nonfinite.h"
#include "rt_nonfinite.h"
#include <math.h>
#include <string.h>

/* Function Declarations */
static void STM_prop_anonFcn1(double mu, const double x[42],
                              double varargout_1[42]);

static double rt_powd_snf(double u0, double u1);

/* Function Definitions */
static void STM_prop_anonFcn1(double mu, const double x[42],
                              double varargout_1[42])
{
  static const signed char iv[6] = {0, 0, 0, 1, 0, 0};
  static const signed char iv1[6] = {0, 0, 0, 0, 1, 0};
  static const signed char iv2[6] = {0, 0, 0, 0, 0, 1};
  double b_x[36];
  double dv[36];
  double dv1[36];
  double absxk;
  double d;
  double r_norm;
  double scale;
  double t;
  int i;
  int i1;
  int i2;
  /* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   */
  /*  PROTOTYPE: */
  /*    [dxdt]=TBP(t,x,mu,check) */
  /* --------------------------------------------------------------------------
   */
  /*  DESCRIPTION:  */
  /*    Function used to build the dynamics of the restricted two-body problem.
   */
  /*    Also the STM could be propagated. */
  /* --------------------------------------------------------------------------
   */
  /*  INPUT: */
  /*    t[1]            Time */
  /*    x[42x1]         State vector: It could contain also the state */
  /*                    transition matrix (STM) terms */
  /*    mu[1]           Earth mass parameter [km^3/s^2] */
  /*    check[1]        Value used to select if also the STM needs to be */
  /*                    included in the dynamics. In particular: */
  /*                    check==1 the dynamics contains also the STM terms   */
  /* --------------------------------------------------------------------------
   */
  /*  OUTPUT: */
  /*    dxdt[42x1]      System dynamics    */
  /* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   */
  /*  State  */
  /*  Norm of the position */
  scale = 3.3121686421112381E-170;
  absxk = fabs(x[0]);
  if (absxk > 3.3121686421112381E-170) {
    r_norm = 1.0;
    scale = absxk;
  } else {
    t = absxk / 3.3121686421112381E-170;
    r_norm = t * t;
  }
  absxk = fabs(x[1]);
  if (absxk > scale) {
    t = scale / absxk;
    r_norm = r_norm * t * t + 1.0;
    scale = absxk;
  } else {
    t = absxk / scale;
    r_norm += t * t;
  }
  absxk = fabs(x[2]);
  if (absxk > scale) {
    t = scale / absxk;
    r_norm = r_norm * t * t + 1.0;
    scale = absxk;
  } else {
    t = absxk / scale;
    r_norm += t * t;
  }
  r_norm = scale * sqrt(r_norm);
  /*  Initial STM  */
  /*  Definition of the A matrix */
  /*  Observation: A = df/dx(x*) where f is the dynamics function */
  /*  Computing the equation dphidt=A*phi */
  /*  Trasform the matrix into a vector */
  /*  Dynamics implementation */
  memcpy(&b_x[0], &x[6], 36U * sizeof(double));
  for (i = 0; i < 6; i++) {
    dv[6 * i] = iv[i];
    dv[6 * i + 1] = iv1[i];
    dv[6 * i + 2] = iv2[i];
  }
  d = 3.0 * mu / rt_powd_snf(r_norm, 5.0);
  scale = rt_powd_snf(r_norm, 3.0);
  absxk = mu / scale;
  dv[3] = d * (x[0] * x[0]) - absxk;
  t = d * x[0];
  r_norm = t * x[1];
  dv[9] = r_norm;
  t *= x[2];
  dv[15] = t;
  dv[21] = 0.0;
  dv[27] = 0.0;
  dv[33] = 0.0;
  dv[4] = r_norm;
  dv[10] = d * (x[1] * x[1]) - absxk;
  r_norm = d * x[1] * x[2];
  dv[16] = r_norm;
  dv[22] = 0.0;
  dv[28] = 0.0;
  dv[34] = 0.0;
  dv[5] = t;
  dv[11] = r_norm;
  dv[17] = d * (x[2] * x[2]) - absxk;
  dv[23] = 0.0;
  dv[29] = 0.0;
  dv[35] = 0.0;
  for (i = 0; i < 6; i++) {
    for (i1 = 0; i1 < 6; i1++) {
      d = 0.0;
      for (i2 = 0; i2 < 6; i2++) {
        d += dv[i + 6 * i2] * b_x[i2 + 6 * i1];
      }
      dv1[i + 6 * i1] = d;
    }
  }
  varargout_1[0] = x[3];
  varargout_1[1] = x[4];
  varargout_1[2] = x[5];
  scale = -mu / scale;
  varargout_1[3] = scale * x[0];
  varargout_1[4] = scale * x[1];
  varargout_1[5] = scale * x[2];
  memcpy(&varargout_1[6], &dv1[0], 36U * sizeof(double));
}

static double rt_powd_snf(double u0, double u1)
{
  double y;
  if (rtIsNaN(u0) || rtIsNaN(u1)) {
    y = rtNaN;
  } else {
    double d;
    double d1;
    d = fabs(u0);
    d1 = fabs(u1);
    if (rtIsInf(u1)) {
      if (d == 1.0) {
        y = 1.0;
      } else if (d > 1.0) {
        if (u1 > 0.0) {
          y = rtInf;
        } else {
          y = 0.0;
        }
      } else if (u1 > 0.0) {
        y = 0.0;
      } else {
        y = rtInf;
      }
    } else if (d1 == 0.0) {
      y = 1.0;
    } else if (d1 == 1.0) {
      if (u1 > 0.0) {
        y = u0;
      } else {
        y = 1.0 / u0;
      }
    } else if (u1 == 2.0) {
      y = u0 * u0;
    } else if ((u1 == 0.5) && (u0 >= 0.0)) {
      y = sqrt(u0);
    } else if ((u0 < 0.0) && (u1 > floor(u1))) {
      y = rtNaN;
    } else {
      y = pow(u0, u1);
    }
  }
  return y;
}

void STM_prop(double mu, const emxArray_real_T *t_span_b, const double x_0[42],
              const struct0_T *ode_options, emxArray_real_T *t,
              emxArray_real_T *x)
{
  static const double BI2[12] = {
      -7.2385507835764331, 11.153308875889351,  2.3487522980730935,
      -1027.3216753392408, 1568.546608927282,   -2000.8820619210419,
      1496.6204006934463,  -16.413207755609335, -4.2967244317824651,
      -20.416280692948217, 16.530071842642716,  -18.630641713134295};
  static const double BI3[12] = {
      26.00913483254676,  -91.76096563989617,  -11.672489417201843,
      9198.7143236076081, -13995.388525416005, 17864.363803476917,
      -13397.55405171476, 147.60970454070025,  38.644474611167809,
      153.52132325248365, -96.6861433615782,   164.19941122801831};
  static const double BI4[12] = {
      -50.23684777762567,  291.70742417220595, -3.3391390765059286,
      -33189.780481573638, 50256.212469810242, -64205.190751556285,
      48323.560219943749,  -535.7199637147321, -140.35034717628091,
      -436.550261021122,   268.9599342195317,  -579.27225624954042};
  static const double BI5[12] = {
      52.120720846010222, -430.40966929108629, 94.885262249720611,
      57750.083134888715, -86974.512803622,    111224.84899303781,
      -84051.4283423393,  938.28624707782069,  246.39546696975026,
      598.21464426265084, -428.68190978896467, 980.19825570886678};
  static const double BI6[12] = {
      -27.06472451211777,  299.45311881989977,  -143.07112658301202,
      -47698.933157062616, 71494.797709599763,  -91509.339210213031,
      69399.858211157087,  -779.43830963934931, -205.83416869641673,
      -398.78239500712908, 354.57823115243337,  -786.22417901551387};
  static const double BI7[12] = {
      5.4545472889529654,  -79.789111997840152, 61.096709744421737,
      14951.543653440334,  -22324.571394333743, 28594.460859389379,
      -21748.118154466232, 245.43939702786273,  65.441298723562014,
      104.01296920606484,  -114.70018406406496, 239.72941004130359};
  emxArray_real_T *tout;
  emxArray_real_T *yout;
  double f[504];
  double f0[42];
  double f5[42];
  double y[42];
  const double *t_span_b_data;
  double absh;
  double absx;
  double b_t;
  double err;
  double hmax;
  double rtol;
  double tdir;
  double tfinal;
  double threshold;
  double twidth;
  double *t_data;
  double *tout_data;
  double *yout_data;
  int b_i;
  int exponent;
  int i;
  int k;
  int next;
  int nnxt;
  int nout;
  boolean_T Done;
  boolean_T MinStepExit;
  t_span_b_data = t_span_b->data;
  /*  Define the ODE function */
  /*  Solve the ODE using ode45 */
  tfinal = t_span_b_data[t_span_b->size[1] - 1];
  STM_prop_anonFcn1(mu, x_0, f0);
  rtol = ode_options->RelTol;
  if (ode_options->RelTol < 2.2204460492503131E-14) {
    rtol = 2.2204460492503131E-14;
  }
  emxInit_real_T(&tout, 2);
  threshold = ode_options->AbsTol / rtol;
  i = tout->size[0] * tout->size[1];
  tout->size[0] = 1;
  tout->size[1] = t_span_b->size[1];
  emxEnsureCapacity_real_T(tout, i);
  tout_data = tout->data;
  next = t_span_b->size[1];
  for (i = 0; i < next; i++) {
    tout_data[i] = 0.0;
  }
  emxInit_real_T(&yout, 2);
  i = yout->size[0] * yout->size[1];
  yout->size[0] = 42;
  yout->size[1] = t_span_b->size[1];
  emxEnsureCapacity_real_T(yout, i);
  yout_data = yout->data;
  next = 42 * t_span_b->size[1];
  for (i = 0; i < next; i++) {
    yout_data[i] = 0.0;
  }
  nout = 1;
  tout_data[0] = t_span_b_data[0];
  for (i = 0; i < 42; i++) {
    yout_data[i] = x_0[i];
  }
  twidth = fabs(t_span_b_data[t_span_b->size[1] - 1] - t_span_b_data[0]);
  absx = fabs(t_span_b_data[0]);
  hmax = fmin(twidth,
              fmax(0.1 * twidth,
                   3.5527136788005009E-15 *
                       fmax(absx, fabs(t_span_b_data[t_span_b->size[1] - 1]))));
  if ((!rtIsInf(absx)) && (!rtIsNaN(absx))) {
    if (absx <= 2.2250738585072014E-308) {
      err = 4.94065645841247E-324;
    } else {
      frexp(absx, &nnxt);
      err = ldexp(1.0, nnxt - 53);
    }
  } else {
    err = rtNaN;
  }
  absh = fmin(hmax, fabs(t_span_b_data[1] - t_span_b_data[0]));
  twidth = 0.0;
  for (k = 0; k < 42; k++) {
    absx = fabs(f0[k] / fmax(fabs(x_0[k]), threshold));
    if (rtIsNaN(absx) || (absx > twidth)) {
      twidth = absx;
    }
  }
  twidth /= 0.8 * rt_powd_snf(rtol, 0.125);
  if (absh * twidth > 1.0) {
    absh = 1.0 / twidth;
  }
  absh = fmax(absh, 16.0 * err);
  b_t = t_span_b_data[0];
  memcpy(&y[0], &x_0[0], 42U * sizeof(double));
  memset(&f[0], 0, 504U * sizeof(double));
  memcpy(&f[0], &f0[0], 42U * sizeof(double));
  tdir = t_span_b_data[t_span_b->size[1] - 1] - t_span_b_data[0];
  if (!rtIsNaN(tdir)) {
    if (tdir < 0.0) {
      tdir = -1.0;
    } else {
      tdir = (tdir > 0.0);
    }
  }
  next = 0;
  MinStepExit = false;
  Done = false;
  int exitg1;
  do {
    double b_y[42];
    double d;
    double h;
    double hmin;
    double tnew;
    boolean_T NoFailedAttempts;
    exitg1 = 0;
    absx = fabs(b_t);
    if ((!rtIsInf(absx)) && (!rtIsNaN(absx))) {
      if (absx <= 2.2250738585072014E-308) {
        err = 4.94065645841247E-324;
      } else {
        frexp(absx, &exponent);
        err = ldexp(1.0, exponent - 53);
      }
    } else {
      err = rtNaN;
    }
    hmin = 16.0 * err;
    absh = fmin(hmax, fmax(hmin, absh));
    h = tdir * absh;
    d = tfinal - b_t;
    if (1.1 * absh >= fabs(d)) {
      h = d;
      absh = fabs(d);
      Done = true;
    }
    NoFailedAttempts = true;
    int exitg2;
    do {
      double f3[42];
      double f4[42];
      double f3_tmp;
      exitg2 = 0;
      if (b_t == t_span_b_data[0]) {
        memcpy(&f[0], &f0[0], 42U * sizeof(double));
      } else if (NoFailedAttempts) {
        STM_prop_anonFcn1(mu, y, *(double(*)[42]) & f[0]);
      }
      twidth = h * 0.05;
      for (i = 0; i < 42; i++) {
        b_y[i] = y[i] + twidth * f[i];
      }
      STM_prop_anonFcn1(mu, b_y, f3);
      for (i = 0; i < 42; i++) {
        b_y[i] = y[i] + h * (-0.0069931640625 * f[i] + 0.1135556640625 * f3[i]);
      }
      STM_prop_anonFcn1(mu, b_y, f3);
      for (i = 0; i < 42; i++) {
        b_y[i] = y[i] + h * (0.0399609375 * f[i] + 0.1198828125 * f3[i]);
      }
      STM_prop_anonFcn1(mu, b_y, f4);
      for (i = 0; i < 42; i++) {
        f3[i] =
            y[i] +
            h * ((0.36139756280045754 * f[i] + -1.3415240667004928 * f3[i]) +
                 1.3701265039000352 * f4[i]);
      }
      STM_prop_anonFcn1(mu, f3, f5);
      for (i = 0; i < 42; i++) {
        b_y[i] =
            y[i] +
            h * ((0.049047202797202795 * f[i] + 0.23509720422144048 * f4[i]) +
                 0.18085559298135673 * f5[i]);
      }
      STM_prop_anonFcn1(mu, b_y, *(double(*)[42]) & f[42]);
      for (i = 0; i < 42; i++) {
        b_y[i] =
            y[i] +
            h * (((0.06169289044289044 * f[i] + 0.11236568314640277 * f4[i]) +
                  -0.038850460714513667 * f5[i]) +
                 0.01979188712522046 * f[i + 42]);
      }
      STM_prop_anonFcn1(mu, b_y, *(double(*)[42]) & f[84]);
      for (i = 0; i < 42; i++) {
        b_y[i] = y[i] + h * ((((-1.767630240222327 * f[i] + -62.5 * f4[i]) +
                               -6.0618893773766693 * f5[i]) +
                              5.6508231982227635 * f[i + 42]) +
                             65.621696419376235 * f[i + 84]);
      }
      STM_prop_anonFcn1(mu, b_y, *(double(*)[42]) & f[126]);
      for (i = 0; i < 42; i++) {
        b_y[i] =
            y[i] +
            h * (((((-1.1809450665549708 * f[i] + -41.504734411143211 * f4[i]) +
                    -4.4344383191037249 * f5[i]) +
                   4.2604081885861333 * f[i + 42]) +
                  43.753640224461719 * f[i + 84]) +
                 0.00787142548991231 * f[i + 126]);
      }
      STM_prop_anonFcn1(mu, b_y, *(double(*)[42]) & f[168]);
      for (i = 0; i < 42; i++) {
        b_y[i] = y[i] + h * ((((((-1.2814059994414884 * f[i] +
                                  -45.047139960139866 * f4[i]) +
                                 -4.7313620694495766 * f5[i]) +
                                4.5149670165938076 * f[i + 42]) +
                               47.449095571729849 * f[i + 84]) +
                              0.010592282971116612 * f[i + 126]) +
                             -0.0057468422638446166 * f[i + 168]);
      }
      STM_prop_anonFcn1(mu, b_y, *(double(*)[42]) & f[210]);
      for (i = 0; i < 42; i++) {
        b_y[i] = y[i] + h * (((((((-1.7244701342624853 * f[i] +
                                   -60.92349008483054 * f4[i]) +
                                  -5.9515183762223929 * f5[i]) +
                                 5.5565237306984558 * f[i + 42]) +
                                63.983011980333053 * f[i + 84]) +
                               0.014642028250414961 * f[i + 126]) +
                              0.064604087723582032 * f[i + 168]) +
                             -0.0793032316900888 * f[i + 210]);
      }
      STM_prop_anonFcn1(mu, b_y, *(double(*)[42]) & f[252]);
      for (i = 0; i < 42; i++) {
        b_y[i] = y[i] + h * ((((((((-3.301622667747079 * f[i] +
                                    -118.01127235975251 * f4[i]) +
                                   -10.141422388456112 * f5[i]) +
                                  9.139311332232058 * f[i + 42]) +
                                 123.37594282840426 * f[i + 84]) +
                                4.62324437887458 * f[i + 126]) +
                               -3.3832777380682018 * f[i + 168]) +
                              4.5275921003246182 * f[i + 210]) +
                             -5.8284954858116231 * f[i + 252]);
      }
      STM_prop_anonFcn1(mu, b_y, *(double(*)[42]) & f[294]);
      for (i = 0; i < 42; i++) {
        f4[i] = y[i] + h * (((((((-3.039515033766309 * f[i] +
                                  -109.26086808941763 * f4[i]) +
                                 -9.2906424974002935 * f5[i]) +
                                8.43050498176491 * f[i + 42]) +
                               114.20100103783314 * f[i + 84]) +
                              -0.96372713421454792 * f[i + 126]) +
                             -5.0348840888021895 * f[i + 168]) +
                            5.9581308240029234 * f[i + 210]);
      }
      STM_prop_anonFcn1(mu, f4, f3);
      for (i = 0; i < 42; i++) {
        double b_f3_tmp;
        double c_f3_tmp;
        twidth = f[i + 42];
        absx = f[i + 84];
        err = f[i + 126];
        f3_tmp = f[i + 168];
        tnew = f[i + 210];
        b_f3_tmp = f[i + 252];
        c_f3_tmp = f[i + 294];
        d = f[i];
        f3[i] =
            (((((((3.2721039010287758E-5 * d + 0.0005046250618777735 * twidth) +
                  -0.00012117235897844563 * absx) +
                 20.142336771313868 * err) +
                -5.2371785994398277 * f3_tmp) +
               8.1567444087946583 * tnew) +
              -22.938283273988784 * b_f3_tmp) +
             0.23613246330715421 * c_f3_tmp) +
            -0.36016794372897754 * f3[i];
        f5[i] =
            y[i] +
            h * (((((((0.044279894190079508 * d + 0.3541049391724449 * twidth) +
                      0.2479692154956438 * absx) +
                     -15.694202038838084 * err) +
                    25.084064965558564 * f3_tmp) +
                   -31.738367786260277 * tnew) +
                  22.938283273988784 * b_f3_tmp) +
                 -0.23613246330715421 * c_f3_tmp);
      }
      tnew = b_t + h;
      if (Done) {
        tnew = tfinal;
      }
      h = tnew - b_t;
      if (NoFailedAttempts) {
        f3_tmp = 0.0;
        for (k = 0; k < 42; k++) {
          twidth = fabs(f3[k]);
          absx = fabs(y[k]);
          err = fabs(f5[k]);
          if ((absx > err) || rtIsNaN(err)) {
            if (absx > threshold) {
              twidth /= absx;
            } else {
              twidth /= threshold;
            }
          } else if (err > threshold) {
            twidth /= err;
          } else {
            twidth /= threshold;
          }
          if ((twidth > f3_tmp) || rtIsNaN(twidth)) {
            f3_tmp = twidth;
          }
        }
        err = absh * f3_tmp;
      } else {
        f3_tmp = 0.0;
        for (k = 0; k < 42; k++) {
          twidth = fabs(f3[k]);
          absx = fabs(y[k]);
          if (absx > threshold) {
            twidth /= absx;
          } else {
            twidth /= threshold;
          }
          if ((twidth > f3_tmp) || rtIsNaN(twidth)) {
            f3_tmp = twidth;
          }
        }
        err = absh * f3_tmp;
      }
      if (!(err <= rtol)) {
        if (absh <= hmin) {
          MinStepExit = true;
          exitg2 = 1;
        } else {
          if (NoFailedAttempts) {
            NoFailedAttempts = false;
            absh = fmax(hmin,
                        absh * fmax(0.1, 0.8 * rt_powd_snf(rtol / err, 0.125)));
          } else {
            absh = fmax(hmin, 0.5 * absh);
          }
          h = tdir * absh;
          Done = false;
        }
      } else {
        exitg2 = 1;
      }
    } while (exitg2 == 0);
    if (MinStepExit) {
      exitg1 = 1;
    } else {
      int noutnew;
      nnxt = next;
      while ((nnxt + 2 <= t_span_b->size[1]) &&
             (tdir * (tnew - t_span_b_data[nnxt + 1]) >= 0.0)) {
        nnxt++;
      }
      noutnew = nnxt - next;
      if (noutnew > 0) {
        double b[12];
        for (i = 0; i < 42; i++) {
          b_y[i] = y[i] + h * (((((((0.044279894190079508 * f[i] +
                                     0.3541049391724449 * f[i + 42]) +
                                    0.2479692154956438 * f[i + 84]) +
                                   -15.694202038838084 * f[i + 126]) +
                                  25.084064965558564 * f[i + 168]) +
                                 -31.738367786260277 * f[i + 210]) +
                                22.938283273988784 * f[i + 252]) +
                               -0.23613246330715421 * f[i + 294]);
        }
        STM_prop_anonFcn1(mu, b_y, *(double(*)[42]) & f[336]);
        for (i = 0; i < 42; i++) {
          b_y[i] = y[i] + h * ((((((((0.046207006467549633 * f[i] +
                                      0.045039041608424805 * f[i + 42]) +
                                     0.23368166977134244 * f[i + 84]) +
                                    37.839013684210677 * f[i + 126]) +
                                   -15.949113289454246 * f[i + 168]) +
                                  23.028368351816102 * f[i + 210]) +
                                 -44.855785077694122 * f[i + 252]) +
                                -0.063798587686474437 * f[i + 294]) +
                               -0.012595035543861663 * f[i + 336]);
        }
        STM_prop_anonFcn1(mu, b_y, *(double(*)[42]) & f[378]);
        for (i = 0; i < 42; i++) {
          b_y[i] = y[i] + h * (((((((((0.050379468554820409 * f[i] +
                                       0.041098361310460796 * f[i + 42]) +
                                      0.17180541533481958 * f[i + 84]) +
                                     4.614105319981519 * f[i + 126]) +
                                    -1.7916678830853965 * f[i + 168]) +
                                   2.5316589304850412 * f[i + 210]) +
                                  -5.3249778602057312 * f[i + 252]) +
                                 -0.030655325953856349 * f[i + 294]) +
                                -0.0052544799794296132 * f[i + 336]) +
                               -0.083991946442247931 * f[i + 378]);
        }
        STM_prop_anonFcn1(mu, b_y, *(double(*)[42]) & f[420]);
        for (i = 0; i < 42; i++) {
          b_y[i] = y[i] + h * ((((((((((0.0408289713299708 * f[i] +
                                        0.42444795142476321 * f[i + 42]) +
                                       0.23260915312752345 * f[i + 84]) +
                                      2.6779825207118062 * f[i + 126]) +
                                     0.74208266573389448 * f[i + 168]) +
                                    0.14603778479414611 * f[i + 210]) +
                                   -3.5793445098905652 * f[i + 252]) +
                                  0.11388443896001738 * f[i + 294]) +
                                 0.012677906510331901 * f[i + 336]) +
                                -0.074434363499466749 * f[i + 378]) +
                               0.047827480797578516 * f[i + 420]);
        }
        STM_prop_anonFcn1(mu, b_y, *(double(*)[42]) & f[462]);
        for (k = next + 2; k <= nnxt; k++) {
          d = t_span_b_data[k - 1];
          tout_data[k - 1] = d;
          twidth = (d - b_t) / h;
          absx = twidth * twidth;
          for (b_i = 0; b_i < 12; b_i++) {
            b[b_i] = (((((BI7[b_i] * twidth + BI6[b_i]) * twidth + BI5[b_i]) *
                            twidth +
                        BI4[b_i]) *
                           twidth +
                       BI3[b_i]) *
                          twidth +
                      BI2[b_i]) *
                     absx;
          }
          b[0] += twidth;
          for (i = 0; i < 42; i++) {
            d = 0.0;
            for (b_i = 0; b_i < 12; b_i++) {
              d += f[i + 42 * b_i] * b[b_i];
            }
            yout_data[i + 42 * (k - 1)] = y[i] + h * d;
          }
        }
        tout_data[nnxt] = t_span_b_data[nnxt];
        if (t_span_b_data[nnxt] == tnew) {
          for (i = 0; i < 42; i++) {
            yout_data[i + 42 * nnxt] = f5[i];
          }
        } else {
          twidth = (t_span_b_data[nnxt] - b_t) / h;
          absx = twidth * twidth;
          for (b_i = 0; b_i < 12; b_i++) {
            b[b_i] = (((((BI7[b_i] * twidth + BI6[b_i]) * twidth + BI5[b_i]) *
                            twidth +
                        BI4[b_i]) *
                           twidth +
                       BI3[b_i]) *
                          twidth +
                      BI2[b_i]) *
                     absx;
          }
          b[0] += twidth;
          for (i = 0; i < 42; i++) {
            d = 0.0;
            for (b_i = 0; b_i < 12; b_i++) {
              d += f[i + 42 * b_i] * b[b_i];
            }
            yout_data[i + 42 * nnxt] = y[i] + h * d;
          }
        }
        nout += noutnew;
        next = nnxt;
      }
      if (Done) {
        exitg1 = 1;
      } else {
        if (NoFailedAttempts) {
          twidth = 1.25 * rt_powd_snf(err / rtol, 0.125);
          if (twidth > 0.2) {
            absh /= twidth;
          } else {
            absh *= 5.0;
          }
        }
        b_t = tnew;
        memcpy(&y[0], &f5[0], 42U * sizeof(double));
      }
    }
  } while (exitg1 == 0);
  i = t->size[0];
  t->size[0] = nout;
  emxEnsureCapacity_real_T(t, i);
  t_data = t->data;
  for (i = 0; i < nout; i++) {
    t_data[i] = tout_data[i];
  }
  emxFree_real_T(&tout);
  i = x->size[0] * x->size[1];
  x->size[0] = nout;
  x->size[1] = 42;
  emxEnsureCapacity_real_T(x, i);
  t_data = x->data;
  for (i = 0; i < 42; i++) {
    for (b_i = 0; b_i < nout; b_i++) {
      t_data[b_i + x->size[0] * i] = yout_data[i + 42 * b_i];
    }
  }
  emxFree_real_T(&yout);
}

/* End of code generation (STM_prop.c) */
