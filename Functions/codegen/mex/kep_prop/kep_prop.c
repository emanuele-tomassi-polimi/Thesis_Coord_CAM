/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * kep_prop.c
 *
 * Code generation for function 'kep_prop'
 *
 */

/* Include files */
#include "kep_prop.h"
#include "eps.h"
#include "explicitRungeKutta.h"
#include "kep_prop_emxutil.h"
#include "kep_prop_types.h"
#include "num2str.h"
#include "rt_nonfinite.h"
#include "warning.h"
#include "mwmathutil.h"
#include <string.h>

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = {
    6,          /* lineNo */
    "kep_prop", /* fcnName */
    "/Users/admin/Library/CloudStorage/OneDrive-PolitecnicodiMilano/andrea "
    "polimi/PhD/CAM/Codici Emanuele Tomassi/Functions/kep_prop."
    "m" /* pathName */
};

static emlrtRSInfo
    b_emlrtRSI =
        {
            17,      /* lineNo */
            "ode78", /* fcnName */
            "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/"
            "ode78.m" /* pathName */
};

static emlrtRSInfo c_emlrtRSI = {
    629,                  /* lineNo */
    "explicitRungeKutta", /* fcnName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pathName */
};

static emlrtRSInfo d_emlrtRSI = {
    544,                  /* lineNo */
    "explicitRungeKutta", /* fcnName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pathName */
};

static emlrtRSInfo e_emlrtRSI = {
    427,                  /* lineNo */
    "explicitRungeKutta", /* fcnName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pathName */
};

static emlrtRSInfo f_emlrtRSI = {
    414,                  /* lineNo */
    "explicitRungeKutta", /* fcnName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pathName */
};

static emlrtRSInfo g_emlrtRSI = {
    417,                  /* lineNo */
    "explicitRungeKutta", /* fcnName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pathName */
};

static emlrtRSInfo h_emlrtRSI = {
    416,                  /* lineNo */
    "explicitRungeKutta", /* fcnName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pathName */
};

static emlrtRSInfo i_emlrtRSI = {
    354,                  /* lineNo */
    "explicitRungeKutta", /* fcnName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pathName */
};

static emlrtRSInfo j_emlrtRSI = {
    350,                  /* lineNo */
    "explicitRungeKutta", /* fcnName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pathName */
};

static emlrtRSInfo k_emlrtRSI = {
    333,                  /* lineNo */
    "explicitRungeKutta", /* fcnName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pathName */
};

static emlrtRSInfo l_emlrtRSI = {
    306,                  /* lineNo */
    "explicitRungeKutta", /* fcnName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pathName */
};

static emlrtRSInfo m_emlrtRSI = {
    298,                  /* lineNo */
    "explicitRungeKutta", /* fcnName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pathName */
};

static emlrtRSInfo n_emlrtRSI = {
    118,                  /* lineNo */
    "explicitRungeKutta", /* fcnName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pathName */
};

static emlrtRSInfo o_emlrtRSI = {
    90,                   /* lineNo */
    "explicitRungeKutta", /* fcnName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pathName */
};

static emlrtRSInfo p_emlrtRSI = {
    63,                               /* lineNo */
    "function_handle/parenReference", /* fcnName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/eml/+coder/+internal/"
    "function_handle.m" /* pathName */
};

static emlrtRSInfo
    w_emlrtRSI =
        {
            44,       /* lineNo */
            "mpower", /* fcnName */
            "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/matfun/"
            "mpower.m" /* pathName */
};

static emlrtRSInfo x_emlrtRSI = {
    71,      /* lineNo */
    "power", /* fcnName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/ops/power.m" /* pathName
                                                                          */
};

static emlrtRTEInfo emlrtRTEI = {
    82,         /* lineNo */
    5,          /* colNo */
    "fltpower", /* fName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/ops/power.m" /* pName
                                                                          */
};

static emlrtRTEInfo b_emlrtRTEI = {
    54,                   /* lineNo */
    1,                    /* colNo */
    "explicitRungeKutta", /* fName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pName */
};

static emlrtRTEInfo c_emlrtRTEI = {
    56,                   /* lineNo */
    15,                   /* colNo */
    "explicitRungeKutta", /* fName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pName */
};

static emlrtRTEInfo d_emlrtRTEI = {
    113,                  /* lineNo */
    15,                   /* colNo */
    "explicitRungeKutta", /* fName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pName */
};

static emlrtRTEInfo e_emlrtRTEI = {
    122,                  /* lineNo */
    15,                   /* colNo */
    "explicitRungeKutta", /* fName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pName */
};

static emlrtRTEInfo f_emlrtRTEI = {
    293,                  /* lineNo */
    15,                   /* colNo */
    "explicitRungeKutta", /* fName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pName */
};

static emlrtRTEInfo g_emlrtRTEI = {
    239,                  /* lineNo */
    5,                    /* colNo */
    "explicitRungeKutta", /* fName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pName */
};

static emlrtRTEInfo h_emlrtRTEI = {
    240,                  /* lineNo */
    5,                    /* colNo */
    "explicitRungeKutta", /* fName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pName */
};

static emlrtRTEInfo i_emlrtRTEI = {
    654,                  /* lineNo */
    1,                    /* colNo */
    "explicitRungeKutta", /* fName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pName */
};

static emlrtRTEInfo j_emlrtRTEI = {
    655,                  /* lineNo */
    1,                    /* colNo */
    "explicitRungeKutta", /* fName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" /* pName */
};

static emlrtRTEInfo k_emlrtRTEI = {
    14,                  /* lineNo */
    9,                   /* colNo */
    "appendZeroColumns", /* fName */
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "appendZeroColumns.m" /* pName */
};

/* Function Definitions */
void kep_prop(const emlrtStack *sp, real_T mu, const real_T t_span_b[2],
              const real_T x_0[6], const struct0_T *ode_options,
              emxArray_real_T *t, emxArray_real_T *x)
{
  static const real_T BI2[12] = {
      -7.2385507835764331, 11.153308875889351,  2.3487522980730935,
      -1027.3216753392408, 1568.546608927282,   -2000.8820619210419,
      1496.6204006934463,  -16.413207755609335, -4.2967244317824651,
      -20.416280692948217, 16.530071842642716,  -18.630641713134295};
  static const real_T BI3[12] = {
      26.00913483254676,  -91.76096563989617,  -11.672489417201843,
      9198.7143236076081, -13995.388525416005, 17864.363803476917,
      -13397.55405171476, 147.60970454070025,  38.644474611167809,
      153.52132325248365, -96.6861433615782,   164.19941122801831};
  static const real_T BI4[12] = {
      -50.23684777762567,  291.70742417220595, -3.3391390765059286,
      -33189.780481573638, 50256.212469810242, -64205.190751556285,
      48323.560219943749,  -535.7199637147321, -140.35034717628091,
      -436.550261021122,   268.9599342195317,  -579.27225624954042};
  static const real_T BI5[12] = {
      52.120720846010222, -430.40966929108629, 94.885262249720611,
      57750.083134888715, -86974.512803622,    111224.84899303781,
      -84051.4283423393,  938.28624707782069,  246.39546696975026,
      598.21464426265084, -428.68190978896467, 980.19825570886678};
  static const real_T BI6[12] = {
      -27.06472451211777,  299.45311881989977,  -143.07112658301202,
      -47698.933157062616, 71494.797709599763,  -91509.339210213031,
      69399.858211157087,  -779.43830963934931, -205.83416869641673,
      -398.78239500712908, 354.57823115243337,  -786.22417901551387};
  static const real_T BI7[12] = {
      5.4545472889529654,  -79.789111997840152, 61.096709744421737,
      14951.543653440334,  -22324.571394333743, 28594.460859389379,
      -21748.118154466232, 245.43939702786273,  65.441298723562014,
      104.01296920606484,  -114.70018406406496, 239.72941004130359};
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack st;
  emxArray_real_T *tout;
  emxArray_real_T *yout;
  real_T f[72];
  real_T f0[6];
  real_T y[6];
  real_T absh;
  real_T absx;
  real_T b_t;
  real_T d;
  real_T d1;
  real_T err;
  real_T hmax;
  real_T hmin;
  real_T rtol;
  real_T tdir;
  real_T tfinal;
  real_T threshold;
  real_T *t_data;
  real_T *tout_data;
  real_T *yout_data;
  int32_T b_ncols;
  int32_T i;
  int32_T j;
  int32_T k;
  int32_T ncols;
  int32_T nfevals;
  int32_T nout;
  boolean_T Done;
  boolean_T MinStepExit;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b((emlrtCTX)sp);
  /*  Define the ODE function */
  /*  Solve the ODE using ode45 */
  st.site = &emlrtRSI;
  b_st.site = &b_emlrtRSI;
  tfinal = t_span_b[1];
  if (t_span_b[0] == t_span_b[1]) {
    emlrtErrorWithMessageIdR2018a(
        &b_st, &b_emlrtRTEI, "MATLAB:odearguments:TspanEndpointsNotDistinct",
        "MATLAB:odearguments:TspanEndpointsNotDistinct", 0);
  }
  MinStepExit = true;
  if (!(t_span_b[1] > t_span_b[0])) {
    MinStepExit = (t_span_b[0] > t_span_b[1]);
  }
  if (!MinStepExit) {
    emlrtErrorWithMessageIdR2018a(&b_st, &c_emlrtRTEI,
                                  "MATLAB:odearguments:TspanNotMonotonic",
                                  "MATLAB:odearguments:TspanNotMonotonic", 0);
  }
  c_st.site = &o_emlrtRSI;
  d_st.site = &p_emlrtRSI;
  kep_prop_anonFcn1(mu, x_0, f0);
  nfevals = 1;
  rtol = ode_options->RelTol;
  if (!(ode_options->RelTol > 0.0)) {
    emlrtErrorWithMessageIdR2018a(&b_st, &d_emlrtRTEI,
                                  "MATLAB:odearguments:RelTolNotPosScalar",
                                  "MATLAB:odearguments:RelTolNotPosScalar", 0);
  }
  if (ode_options->RelTol < 2.2204460492503131E-14) {
    rtol = 2.2204460492503131E-14;
    c_st.site = &n_emlrtRSI;
    warning(&c_st);
  }
  if (!(ode_options->AbsTol > 0.0)) {
    emlrtErrorWithMessageIdR2018a(&b_st, &e_emlrtRTEI,
                                  "MATLAB:odearguments:AbsTolNotPos",
                                  "MATLAB:odearguments:AbsTolNotPos", 0);
  }
  emxInit_real_T(&b_st, &tout, 2, &g_emlrtRTEI);
  threshold = ode_options->AbsTol / rtol;
  i = tout->size[0] * tout->size[1];
  tout->size[0] = 1;
  tout->size[1] = 400;
  emxEnsureCapacity_real_T(&b_st, tout, i, &g_emlrtRTEI);
  tout_data = tout->data;
  for (i = 0; i < 400; i++) {
    tout_data[i] = 0.0;
  }
  emxInit_real_T(&b_st, &yout, 2, &h_emlrtRTEI);
  i = yout->size[0] * yout->size[1];
  yout->size[0] = 6;
  yout->size[1] = 400;
  emxEnsureCapacity_real_T(&b_st, yout, i, &h_emlrtRTEI);
  yout_data = yout->data;
  for (i = 0; i < 2400; i++) {
    yout_data[i] = 0.0;
  }
  nout = 0;
  tout_data[0] = t_span_b[0];
  for (i = 0; i < 6; i++) {
    yout_data[i] = x_0[i];
  }
  err = t_span_b[1] - t_span_b[0];
  absx = muDoubleScalarAbs(err);
  hmax = muDoubleScalarMin(
      absx,
      muDoubleScalarMax(0.1 * absx,
                        3.5527136788005009E-15 *
                            muDoubleScalarMax(muDoubleScalarAbs(t_span_b[0]),
                                              muDoubleScalarAbs(t_span_b[1]))));
  if (!(hmax > 0.0)) {
    emlrtErrorWithMessageIdR2018a(&b_st, &f_emlrtRTEI,
                                  "MATLAB:odearguments:MaxStepLEzero",
                                  "MATLAB:odearguments:MaxStepLEzero", 0);
  }
  c_st.site = &m_emlrtRSI;
  hmin = 16.0 * eps(t_span_b[0]);
  absh = muDoubleScalarMin(hmax, absx);
  for (k = 0; k < 6; k++) {
    y[k] = muDoubleScalarMax(muDoubleScalarAbs(x_0[k]), threshold);
  }
  c_st.site = &l_emlrtRSI;
  d_st.site = &w_emlrtRSI;
  d1 = 0.0;
  for (k = 0; k < 6; k++) {
    d = f0[k] / y[k];
    y[k] = d;
    absx = muDoubleScalarAbs(d);
    if (muDoubleScalarIsNaN(absx) || (absx > d1)) {
      d1 = absx;
    }
  }
  absx = d1 / (0.8 * muDoubleScalarPower(rtol, 0.125));
  if (absh * absx > 1.0) {
    absh = 1.0 / absx;
  }
  absh = muDoubleScalarMax(absh, hmin);
  b_t = t_span_b[0];
  for (i = 0; i < 6; i++) {
    y[i] = x_0[i];
  }
  memset(&f[0], 0, 72U * sizeof(real_T));
  for (i = 0; i < 6; i++) {
    f[i] = f0[i];
  }
  tdir = muDoubleScalarSign(err);
  MinStepExit = false;
  Done = false;
  int32_T exitg1;
  do {
    real_T ynew[6];
    real_T h_tmp;
    real_T tnew;
    boolean_T NoFailedAttempts;
    exitg1 = 0;
    c_st.site = &k_emlrtRSI;
    hmin = 16.0 * eps(b_t);
    absh = muDoubleScalarMin(hmax, muDoubleScalarMax(hmin, absh));
    absx = tdir * absh;
    d = tfinal - b_t;
    d1 = muDoubleScalarAbs(d);
    if (1.1 * absh >= d1) {
      absx = d;
      absh = d1;
      Done = true;
    }
    NoFailedAttempts = true;
    int32_T exitg2;
    do {
      real_T varargin_1[6];
      exitg2 = 0;
      if (b_t == t_span_b[0]) {
        for (i = 0; i < 6; i++) {
          f[i] = f0[i];
        }
      } else if (NoFailedAttempts) {
        c_st.site = &j_emlrtRSI;
        d_st.site = &p_emlrtRSI;
        kep_prop_anonFcn1(mu, y, *(real_T(*)[6]) & f[0]);
        nfevals++;
      }
      c_st.site = &i_emlrtRSI;
      computeMainStages78(mu, y, absx, f, &nfevals, ynew, varargin_1);
      for (i = 0; i < 6; i++) {
        ynew[i] = y[i] + absx * ynew[i];
      }
      tnew = b_t + absx;
      if (Done) {
        tnew = tfinal;
      }
      h_tmp = tnew - b_t;
      if (NoFailedAttempts) {
        err = absh * maxScaledError(threshold, varargin_1, y, ynew);
      } else {
        err = 0.0;
        for (k = 0; k < 6; k++) {
          absx = muDoubleScalarAbs(varargin_1[k]);
          d1 = muDoubleScalarAbs(y[k]);
          if (d1 > threshold) {
            absx /= d1;
          } else {
            absx /= threshold;
          }
          if ((absx > err) || muDoubleScalarIsNaN(absx)) {
            err = absx;
          }
        }
        err *= absh;
      }
      if (!(err <= rtol)) {
        if (absh <= hmin) {
          char_T cv[23];
          char_T cv1[23];
          c_st.site = &h_emlrtRSI;
          num2str(&c_st, b_t, cv);
          c_st.site = &g_emlrtRSI;
          num2str(&c_st, hmin, cv1);
          c_st.site = &f_emlrtRSI;
          b_warning(&c_st, cv, cv1);
          MinStepExit = true;
          exitg2 = 1;
        } else {
          if (NoFailedAttempts) {
            NoFailedAttempts = false;
            c_st.site = &e_emlrtRSI;
            absx = rtol / err;
            d_st.site = &w_emlrtRSI;
            e_st.site = &x_emlrtRSI;
            if (absx < 0.0) {
              emlrtErrorWithMessageIdR2018a(
                  &e_st, &emlrtRTEI, "Coder:toolbox:power_domainError",
                  "Coder:toolbox:power_domainError", 0);
            }
            absh = muDoubleScalarMax(
                hmin, absh * muDoubleScalarMax(
                                 0.1, 0.8 * muDoubleScalarPower(absx, 0.125)));
          } else {
            absh = muDoubleScalarMax(hmin, 0.5 * absh);
          }
          absx = tdir * absh;
          Done = false;
        }
      } else {
        exitg2 = 1;
      }
    } while (exitg2 == 0);
    if (MinStepExit) {
      exitg1 = 1;
    } else {
      real_T youtnew[48];
      real_T yinterp[42];
      real_T toutnew[8];
      int32_T outidx;
      c_st.site = &d_emlrtRSI;
      computeCEStages78(mu, y, h_tmp, f, &nfevals);
      outidx = nout + 1;
      toutnew[7] = tnew;
      for (k = 0; k < 7; k++) {
        real_T b[12];
        d = b_t + h_tmp * (0.125 * (real_T)k + 0.125);
        toutnew[k] = d;
        for (i = 0; i < 6; i++) {
          yinterp[i + 6 * k] = y[i];
        }
        absx = (d - b_t) / h_tmp;
        d1 = absx * absx;
        for (i = 0; i < 12; i++) {
          b[i] =
              (((((BI7[i] * absx + BI6[i]) * absx + BI5[i]) * absx + BI4[i]) *
                    absx +
                BI3[i]) *
                   absx +
               BI2[i]) *
              d1;
        }
        b[0] += absx;
        for (i = 0; i < 6; i++) {
          d = 0.0;
          for (b_ncols = 0; b_ncols < 12; b_ncols++) {
            d += f[i + 6 * b_ncols] * b[b_ncols];
          }
          b_ncols = i + 6 * k;
          d = yinterp[b_ncols] + h_tmp * d;
          yinterp[b_ncols] = d;
          youtnew[b_ncols] = d;
        }
      }
      for (i = 0; i < 6; i++) {
        youtnew[i + 42] = ynew[i];
      }
      nout += 8;
      if (nout + 1 > tout->size[1]) {
        ncols = tout->size[1];
        i = tout->size[0] * tout->size[1];
        tout->size[0] = 1;
        tout->size[1] += 400;
        emxEnsureCapacity_real_T(&b_st, tout, i, &k_emlrtRTEI);
        tout_data = tout->data;
        b_ncols = yout->size[1];
        i = yout->size[0] * yout->size[1];
        yout->size[0] = 6;
        yout->size[1] += 400;
        emxEnsureCapacity_real_T(&b_st, yout, i, &k_emlrtRTEI);
        yout_data = yout->data;
        for (j = 0; j < 400; j++) {
          tout_data[ncols + j] = 0.0;
          for (i = 0; i < 6; i++) {
            yout_data[i + 6 * (b_ncols + j)] = 0.0;
          }
        }
      }
      for (k = 0; k < 8; k++) {
        ncols = k + outidx;
        tout_data[ncols] = toutnew[k];
        for (j = 0; j < 6; j++) {
          yout_data[j + 6 * ncols] = youtnew[j + 6 * k];
        }
      }
      if (Done) {
        exitg1 = 1;
      } else {
        if (NoFailedAttempts) {
          c_st.site = &c_emlrtRSI;
          absx = err / rtol;
          d_st.site = &w_emlrtRSI;
          e_st.site = &x_emlrtRSI;
          if (absx < 0.0) {
            emlrtErrorWithMessageIdR2018a(&e_st, &emlrtRTEI,
                                          "Coder:toolbox:power_domainError",
                                          "Coder:toolbox:power_domainError", 0);
          }
          absx = 1.25 * muDoubleScalarPower(absx, 0.125);
          if (absx > 0.2) {
            absh /= absx;
          } else {
            absh *= 5.0;
          }
        }
        b_t = tnew;
        for (i = 0; i < 6; i++) {
          y[i] = ynew[i];
        }
      }
    }
  } while (exitg1 == 0);
  if (nout + 1 < 1) {
    ncols = -1;
  } else {
    ncols = nout;
  }
  i = t->size[0];
  t->size[0] = ncols + 1;
  emxEnsureCapacity_real_T(&b_st, t, i, &i_emlrtRTEI);
  t_data = t->data;
  for (i = 0; i <= ncols; i++) {
    t_data[i] = tout_data[i];
  }
  emxFree_real_T(&b_st, &tout);
  if (nout + 1 < 1) {
    ncols = -1;
  } else {
    ncols = nout;
  }
  i = x->size[0] * x->size[1];
  x->size[0] = ncols + 1;
  x->size[1] = 6;
  emxEnsureCapacity_real_T(&b_st, x, i, &j_emlrtRTEI);
  tout_data = x->data;
  for (i = 0; i < 6; i++) {
    for (b_ncols = 0; b_ncols <= ncols; b_ncols++) {
      tout_data[b_ncols + x->size[0] * i] = yout_data[i + 6 * b_ncols];
    }
  }
  emxFree_real_T(&b_st, &yout);
  emlrtHeapReferenceStackLeaveFcnR2012b((emlrtCTX)sp);
}

void kep_prop_anonFcn1(real_T mu, const real_T x[6], real_T varargout_1[6])
{
  real_T absxk;
  real_T r_norm;
  real_T scale;
  real_T t;
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
  absxk = muDoubleScalarAbs(x[0]);
  if (absxk > 3.3121686421112381E-170) {
    r_norm = 1.0;
    scale = absxk;
  } else {
    t = absxk / 3.3121686421112381E-170;
    r_norm = t * t;
  }
  absxk = muDoubleScalarAbs(x[1]);
  if (absxk > scale) {
    t = scale / absxk;
    r_norm = r_norm * t * t + 1.0;
    scale = absxk;
  } else {
    t = absxk / scale;
    r_norm += t * t;
  }
  absxk = muDoubleScalarAbs(x[2]);
  if (absxk > scale) {
    t = scale / absxk;
    r_norm = r_norm * t * t + 1.0;
    scale = absxk;
  } else {
    t = absxk / scale;
    r_norm += t * t;
  }
  r_norm = scale * muDoubleScalarSqrt(r_norm);
  /*  Dynamics implementation */
  varargout_1[0] = x[3];
  varargout_1[1] = x[4];
  varargout_1[2] = x[5];
  scale = -mu / muDoubleScalarPower(r_norm, 3.0);
  varargout_1[3] = scale * x[0];
  varargout_1[4] = scale * x[1];
  varargout_1[5] = scale * x[2];
}

/* End of code generation (kep_prop.c) */
