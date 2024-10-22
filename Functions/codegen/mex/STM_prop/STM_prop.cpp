//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// STM_prop.cpp
//
// Code generation for function 'STM_prop'
//

// Include files
#include "STM_prop.h"
#include "STM_prop_internal_types.h"
#include "STM_prop_internal_types1.h"
#include "STM_prop_types.h"
#include "anonymous_function.h"
#include "anonymous_function1.h"
#include "eps.h"
#include "explicitRungeKutta.h"
#include "num2str.h"
#include "rt_nonfinite.h"
#include "warning.h"
#include "coder_array.h"
#include "mwmathutil.h"
#include <algorithm>
#include <cstring>

// Variable Definitions
static emlrtRSInfo emlrtRSI{
    6,          // lineNo
    "STM_prop", // fcnName
    "/Users/admin/Library/CloudStorage/OneDrive-PolitecnicodiMilano/andrea "
    "polimi/PhD/CAM/Codici Emanuele Tomassi/Functions/STM_prop."
    "m" // pathName
};

static emlrtRSInfo b_emlrtRSI{
    17,      // lineNo
    "ode78", // fcnName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/ode78.m" // pathName
};

static emlrtRSInfo c_emlrtRSI{
    629,                  // lineNo
    "explicitRungeKutta", // fcnName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pathName
};

static emlrtRSInfo d_emlrtRSI{
    578,                  // lineNo
    "explicitRungeKutta", // fcnName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pathName
};

static emlrtRSInfo e_emlrtRSI{
    427,                  // lineNo
    "explicitRungeKutta", // fcnName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pathName
};

static emlrtRSInfo f_emlrtRSI{
    414,                  // lineNo
    "explicitRungeKutta", // fcnName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pathName
};

static emlrtRSInfo g_emlrtRSI{
    417,                  // lineNo
    "explicitRungeKutta", // fcnName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pathName
};

static emlrtRSInfo h_emlrtRSI{
    416,                  // lineNo
    "explicitRungeKutta", // fcnName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pathName
};

static emlrtRSInfo i_emlrtRSI{
    354,                  // lineNo
    "explicitRungeKutta", // fcnName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pathName
};

static emlrtRSInfo j_emlrtRSI{
    350,                  // lineNo
    "explicitRungeKutta", // fcnName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pathName
};

static emlrtRSInfo k_emlrtRSI{
    333,                  // lineNo
    "explicitRungeKutta", // fcnName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pathName
};

static emlrtRSInfo l_emlrtRSI{
    306,                  // lineNo
    "explicitRungeKutta", // fcnName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pathName
};

static emlrtRSInfo m_emlrtRSI{
    298,                  // lineNo
    "explicitRungeKutta", // fcnName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pathName
};

static emlrtRSInfo n_emlrtRSI{
    252,                  // lineNo
    "explicitRungeKutta", // fcnName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pathName
};

static emlrtRSInfo o_emlrtRSI{
    118,                  // lineNo
    "explicitRungeKutta", // fcnName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pathName
};

static emlrtRSInfo p_emlrtRSI{
    90,                   // lineNo
    "explicitRungeKutta", // fcnName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pathName
};

static emlrtRSInfo q_emlrtRSI{
    63,                               // lineNo
    "function_handle/parenReference", // fcnName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/eml/+coder/+internal/"
    "function_handle.m" // pathName
};

static emlrtRSInfo hb_emlrtRSI{
    44,       // lineNo
    "mpower", // fcnName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/matfun/mpower.m" // pathName
};

static emlrtRSInfo ib_emlrtRSI{
    71,      // lineNo
    "power", // fcnName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/ops/power.m" // pathName
};

static emlrtRTEInfo emlrtRTEI{
    82,         // lineNo
    5,          // colNo
    "fltpower", // fName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/ops/power.m" // pName
};

static emlrtRTEInfo b_emlrtRTEI{
    49,                   // lineNo
    5,                    // colNo
    "explicitRungeKutta", // fName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pName
};

static emlrtRTEInfo c_emlrtRTEI{
    51,                   // lineNo
    5,                    // colNo
    "explicitRungeKutta", // fName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pName
};

static emlrtRTEInfo d_emlrtRTEI{
    54,                   // lineNo
    1,                    // colNo
    "explicitRungeKutta", // fName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pName
};

static emlrtRTEInfo e_emlrtRTEI{
    56,                   // lineNo
    15,                   // colNo
    "explicitRungeKutta", // fName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pName
};

static emlrtRTEInfo f_emlrtRTEI{
    113,                  // lineNo
    15,                   // colNo
    "explicitRungeKutta", // fName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pName
};

static emlrtRTEInfo g_emlrtRTEI{
    122,                  // lineNo
    15,                   // colNo
    "explicitRungeKutta", // fName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pName
};

static emlrtRTEInfo h_emlrtRTEI{
    293,                  // lineNo
    15,                   // colNo
    "explicitRungeKutta", // fName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pName
};

static emlrtRTEInfo i_emlrtRTEI{
    254,                  // lineNo
    5,                    // colNo
    "explicitRungeKutta", // fName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pName
};

static emlrtRTEInfo j_emlrtRTEI{
    255,                  // lineNo
    5,                    // colNo
    "explicitRungeKutta", // fName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pName
};

static emlrtRTEInfo k_emlrtRTEI{
    654,                  // lineNo
    1,                    // colNo
    "explicitRungeKutta", // fName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pName
};

static emlrtRTEInfo l_emlrtRTEI{
    655,                  // lineNo
    1,                    // colNo
    "explicitRungeKutta", // fName
    "/Applications/MATLAB_R2022a.app/toolbox/eml/lib/matlab/funfun/private/"
    "explicitRungeKutta.m" // pName
};

// Function Definitions
void STM_prop(const emlrtStack *sp, real_T mu,
              const coder::array<real_T, 2U> &t_span_b, const real_T x_0[42],
              const struct0_T *ode_options, coder::array<real_T, 1U> &t,
              coder::array<real_T, 2U> &x)
{
  static const real_T BI2[12]{
      -7.2385507835764331, 11.153308875889351,  2.3487522980730935,
      -1027.3216753392408, 1568.546608927282,   -2000.8820619210419,
      1496.6204006934463,  -16.413207755609335, -4.2967244317824651,
      -20.416280692948217, 16.530071842642716,  -18.630641713134295};
  static const real_T BI3[12]{
      26.00913483254676,  -91.76096563989617,  -11.672489417201843,
      9198.7143236076081, -13995.388525416005, 17864.363803476917,
      -13397.55405171476, 147.60970454070025,  38.644474611167809,
      153.52132325248365, -96.6861433615782,   164.19941122801831};
  static const real_T BI4[12]{
      -50.23684777762567,  291.70742417220595, -3.3391390765059286,
      -33189.780481573638, 50256.212469810242, -64205.190751556285,
      48323.560219943749,  -535.7199637147321, -140.35034717628091,
      -436.550261021122,   268.9599342195317,  -579.27225624954042};
  static const real_T BI5[12]{
      52.120720846010222, -430.40966929108629, 94.885262249720611,
      57750.083134888715, -86974.512803622,    111224.84899303781,
      -84051.4283423393,  938.28624707782069,  246.39546696975026,
      598.21464426265084, -428.68190978896467, 980.19825570886678};
  static const real_T BI6[12]{
      -27.06472451211777,  299.45311881989977,  -143.07112658301202,
      -47698.933157062616, 71494.797709599763,  -91509.339210213031,
      69399.858211157087,  -779.43830963934931, -205.83416869641673,
      -398.78239500712908, 354.57823115243337,  -786.22417901551387};
  static const real_T BI7[12]{
      5.4545472889529654,  -79.789111997840152, 61.096709744421737,
      14951.543653440334,  -22324.571394333743, 28594.460859389379,
      -21748.118154466232, 245.43939702786273,  65.441298723562014,
      104.01296920606484,  -114.70018406406496, 239.72941004130359};
  coder::b_anonymous_function df;
  coder::array<real_T, 2U> tout;
  coder::array<real_T, 2U> yout;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack st;
  real_T f[504];
  real_T f0[42];
  real_T y[42];
  real_T ynew[42];
  real_T absh;
  real_T b_t;
  real_T d1;
  real_T hmax;
  real_T hmin;
  real_T mxerr;
  real_T rtol;
  real_T tdir;
  real_T tfinal;
  real_T threshold;
  real_T twidth;
  int32_T next;
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
  //  Define the ODE function
  df.workspace.ODEFunction.workspace.mu = mu;
  //  Solve the ODE using ode45
  st.site = &emlrtRSI;
  b_st.site = &b_emlrtRSI;
  if (t_span_b.size(1) == 0) {
    emlrtErrorWithMessageIdR2018a(
        &b_st, &b_emlrtRTEI, "MATLAB:odearguments:TspanOrY0NotSupplied",
        "MATLAB:odearguments:TspanOrY0NotSupplied", 3, 4, 5, "ode78");
  }
  if (t_span_b.size(1) < 2) {
    emlrtErrorWithMessageIdR2018a(
        &b_st, &c_emlrtRTEI, "MATLAB:odearguments:SizeTspan",
        "MATLAB:odearguments:SizeTspan", 3, 4, 5, "ode78");
  }
  tfinal = t_span_b[t_span_b.size(1) - 1];
  if (t_span_b[0] == t_span_b[t_span_b.size(1) - 1]) {
    emlrtErrorWithMessageIdR2018a(
        &b_st, &d_emlrtRTEI, "MATLAB:odearguments:TspanEndpointsNotDistinct",
        "MATLAB:odearguments:TspanEndpointsNotDistinct", 0);
  }
  if (!coder::ismonotonic(t_span_b)) {
    emlrtErrorWithMessageIdR2018a(&b_st, &e_emlrtRTEI,
                                  "MATLAB:odearguments:TspanNotMonotonic",
                                  "MATLAB:odearguments:TspanNotMonotonic", 0);
  }
  df.workspace.options = *ode_options;
  c_st.site = &p_emlrtRSI;
  d_st.site = &q_emlrtRSI;
  STM_prop_anonFcn1(mu, x_0, f0);
  nfevals = 1;
  rtol = ode_options->RelTol;
  if (!(ode_options->RelTol > 0.0)) {
    emlrtErrorWithMessageIdR2018a(&b_st, &f_emlrtRTEI,
                                  "MATLAB:odearguments:RelTolNotPosScalar",
                                  "MATLAB:odearguments:RelTolNotPosScalar", 0);
  }
  if (ode_options->RelTol < 2.2204460492503131E-14) {
    rtol = 2.2204460492503131E-14;
    c_st.site = &o_emlrtRSI;
    coder::internal::warning(&c_st);
  }
  if (!(ode_options->AbsTol > 0.0)) {
    emlrtErrorWithMessageIdR2018a(&b_st, &g_emlrtRTEI,
                                  "MATLAB:odearguments:AbsTolNotPos",
                                  "MATLAB:odearguments:AbsTolNotPos", 0);
  }
  threshold = ode_options->AbsTol / rtol;
  if (t_span_b.size(1) == 2) {
    c_st.site = &n_emlrtRSI;
    coder::internal::b_warning(&c_st);
  }
  tout.set_size(&i_emlrtRTEI, &b_st, 1, t_span_b.size(1));
  nout = t_span_b.size(1);
  for (int32_T i{0}; i < nout; i++) {
    tout[i] = 0.0;
  }
  yout.set_size(&j_emlrtRTEI, &b_st, 42, t_span_b.size(1));
  nout = 42 * t_span_b.size(1);
  for (int32_T i{0}; i < nout; i++) {
    yout[i] = 0.0;
  }
  nout = 1;
  tout[0] = t_span_b[0];
  for (int32_T i{0}; i < 42; i++) {
    yout[i] = x_0[i];
  }
  twidth = muDoubleScalarAbs(t_span_b[t_span_b.size(1) - 1] - t_span_b[0]);
  hmax = muDoubleScalarMin(
      twidth, muDoubleScalarMax(
                  0.1 * twidth,
                  3.5527136788005009E-15 *
                      muDoubleScalarMax(
                          muDoubleScalarAbs(t_span_b[0]),
                          muDoubleScalarAbs(t_span_b[t_span_b.size(1) - 1]))));
  if (!(hmax > 0.0)) {
    emlrtErrorWithMessageIdR2018a(&b_st, &h_emlrtRTEI,
                                  "MATLAB:odearguments:MaxStepLEzero",
                                  "MATLAB:odearguments:MaxStepLEzero", 0);
  }
  c_st.site = &m_emlrtRSI;
  hmin = 16.0 * coder::eps(t_span_b[0]);
  absh = muDoubleScalarMin(hmax, muDoubleScalarAbs(t_span_b[1] - t_span_b[0]));
  for (int32_T k{0}; k < 42; k++) {
    y[k] = muDoubleScalarMax(muDoubleScalarAbs(x_0[k]), threshold);
  }
  c_st.site = &l_emlrtRSI;
  d_st.site = &hb_emlrtRSI;
  d1 = 0.0;
  for (int32_T k{0}; k < 42; k++) {
    mxerr = f0[k] / y[k];
    y[k] = mxerr;
    twidth = muDoubleScalarAbs(mxerr);
    if (muDoubleScalarIsNaN(twidth) || (twidth > d1)) {
      d1 = twidth;
    }
  }
  twidth = d1 / (0.8 * muDoubleScalarPower(rtol, 0.125));
  if (absh * twidth > 1.0) {
    absh = 1.0 / twidth;
  }
  absh = muDoubleScalarMax(absh, hmin);
  b_t = t_span_b[0];
  std::copy(&x_0[0], &x_0[42], &y[0]);
  std::memset(&f[0], 0, 504U * sizeof(real_T));
  std::copy(&f0[0], &f0[42], &f[0]);
  tdir = muDoubleScalarSign(t_span_b[t_span_b.size(1) - 1] - t_span_b[0]);
  next = 0;
  MinStepExit = false;
  Done = false;
  real_T h;
  int32_T exitg1;
  do {
    real_T err;
    real_T tnew;
    boolean_T NoFailedAttempts;
    exitg1 = 0;
    c_st.site = &k_emlrtRSI;
    hmin = 16.0 * coder::eps(b_t);
    absh = muDoubleScalarMin(hmax, muDoubleScalarMax(hmin, absh));
    h = tdir * absh;
    mxerr = tfinal - b_t;
    twidth = muDoubleScalarAbs(mxerr);
    if (1.1 * absh >= twidth) {
      h = mxerr;
      absh = twidth;
      Done = true;
    }
    NoFailedAttempts = true;
    int32_T exitg2;
    do {
      real_T varargin_1[42];
      exitg2 = 0;
      if (b_t == t_span_b[0]) {
        std::copy(&f0[0], &f0[42], &f[0]);
      } else if (NoFailedAttempts) {
        c_st.site = &j_emlrtRSI;
        d_st.site = &q_emlrtRSI;
        STM_prop_anonFcn1(mu, y, *(real_T(*)[42]) & f[0]);
        nfevals++;
      }
      c_st.site = &i_emlrtRSI;
      coder::computeMainStages78(df, y, h, f, &nfevals, ynew, varargin_1);
      for (int32_T i{0}; i < 42; i++) {
        ynew[i] = y[i] + h * ynew[i];
      }
      tnew = b_t + h;
      if (Done) {
        tnew = tfinal;
      }
      h = tnew - b_t;
      if (NoFailedAttempts) {
        err = absh * coder::maxScaledError(threshold, varargin_1, y, ynew);
      } else {
        mxerr = 0.0;
        for (int32_T k{0}; k < 42; k++) {
          twidth = muDoubleScalarAbs(varargin_1[k]);
          d1 = muDoubleScalarAbs(y[k]);
          if (d1 > threshold) {
            twidth /= d1;
          } else {
            twidth /= threshold;
          }
          if ((twidth > mxerr) || muDoubleScalarIsNaN(twidth)) {
            mxerr = twidth;
          }
        }
        err = absh * mxerr;
      }
      if (!(err <= rtol)) {
        if (absh <= hmin) {
          char_T cv[23];
          char_T cv1[23];
          c_st.site = &h_emlrtRSI;
          coder::internal::num2str(&c_st, b_t, cv);
          c_st.site = &g_emlrtRSI;
          coder::internal::num2str(&c_st, hmin, cv1);
          c_st.site = &f_emlrtRSI;
          coder::internal::warning(&c_st, cv, cv1);
          MinStepExit = true;
          exitg2 = 1;
        } else {
          if (NoFailedAttempts) {
            NoFailedAttempts = false;
            c_st.site = &e_emlrtRSI;
            twidth = rtol / err;
            d_st.site = &hb_emlrtRSI;
            e_st.site = &ib_emlrtRSI;
            if (twidth < 0.0) {
              emlrtErrorWithMessageIdR2018a(
                  &e_st, &emlrtRTEI, "Coder:toolbox:power_domainError",
                  "Coder:toolbox:power_domainError", 0);
            }
            absh = muDoubleScalarMax(
                hmin, absh * muDoubleScalarMax(0.1, 0.8 * muDoubleScalarPower(
                                                              twidth, 0.125)));
          } else {
            absh = muDoubleScalarMax(hmin, 0.5 * absh);
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
      int32_T nnxt;
      int32_T noutnew;
      nnxt = next;
      while ((nnxt + 2 <= t_span_b.size(1)) &&
             (tdir * (tnew - t_span_b[nnxt + 1]) >= 0.0)) {
        nnxt++;
      }
      noutnew = nnxt - next;
      if (noutnew > 0) {
        real_T b[12];
        c_st.site = &d_emlrtRSI;
        coder::computeCEStages78(df, y, h, f, &nfevals);
        for (int32_T k{next + 2}; k <= nnxt; k++) {
          mxerr = t_span_b[k - 1];
          tout[k - 1] = mxerr;
          twidth = (mxerr - b_t) / h;
          d1 = twidth * twidth;
          for (int32_T b_i{0}; b_i < 12; b_i++) {
            b[b_i] = (((((BI7[b_i] * twidth + BI6[b_i]) * twidth + BI5[b_i]) *
                            twidth +
                        BI4[b_i]) *
                           twidth +
                       BI3[b_i]) *
                          twidth +
                      BI2[b_i]) *
                     d1;
          }
          b[0] += twidth;
          for (int32_T i{0}; i < 42; i++) {
            mxerr = 0.0;
            for (int32_T b_i{0}; b_i < 12; b_i++) {
              mxerr += f[i + 42 * b_i] * b[b_i];
            }
            yout[i + 42 * (k - 1)] = y[i] + h * mxerr;
          }
        }
        tout[nnxt] = t_span_b[nnxt];
        if (t_span_b[nnxt] == tnew) {
          for (int32_T i{0}; i < 42; i++) {
            yout[i + 42 * nnxt] = ynew[i];
          }
        } else {
          twidth = (t_span_b[nnxt] - b_t) / h;
          d1 = twidth * twidth;
          for (int32_T b_i{0}; b_i < 12; b_i++) {
            b[b_i] = (((((BI7[b_i] * twidth + BI6[b_i]) * twidth + BI5[b_i]) *
                            twidth +
                        BI4[b_i]) *
                           twidth +
                       BI3[b_i]) *
                          twidth +
                      BI2[b_i]) *
                     d1;
          }
          b[0] += twidth;
          for (int32_T i{0}; i < 42; i++) {
            mxerr = 0.0;
            for (int32_T b_i{0}; b_i < 12; b_i++) {
              mxerr += f[i + 42 * b_i] * b[b_i];
            }
            yout[i + 42 * nnxt] = y[i] + h * mxerr;
          }
        }
        nout += noutnew;
        next = nnxt;
      }
      if (Done) {
        exitg1 = 1;
      } else {
        if (NoFailedAttempts) {
          c_st.site = &c_emlrtRSI;
          twidth = err / rtol;
          d_st.site = &hb_emlrtRSI;
          e_st.site = &ib_emlrtRSI;
          if (twidth < 0.0) {
            emlrtErrorWithMessageIdR2018a(&e_st, &emlrtRTEI,
                                          "Coder:toolbox:power_domainError",
                                          "Coder:toolbox:power_domainError", 0);
          }
          twidth = 1.25 * muDoubleScalarPower(twidth, 0.125);
          if (twidth > 0.2) {
            absh /= twidth;
          } else {
            absh *= 5.0;
          }
        }
        b_t = tnew;
        std::copy(&ynew[0], &ynew[42], &y[0]);
      }
    }
  } while (exitg1 == 0);
  t.set_size(&k_emlrtRTEI, &b_st, nout);
  for (int32_T i{0}; i < nout; i++) {
    t[i] = tout[i];
  }
  x.set_size(&l_emlrtRTEI, &b_st, nout, 42);
  for (int32_T i{0}; i < 42; i++) {
    for (int32_T b_i{0}; b_i < nout; b_i++) {
      x[b_i + x.size(0) * i] = yout[i + 42 * b_i];
    }
  }
  emlrtHeapReferenceStackLeaveFcnR2012b((emlrtCTX)sp);
}

void STM_prop_anonFcn1(real_T mu, const real_T x[42], real_T varargout_1[42])
{
  static const int8_T iv[6]{0, 0, 0, 1, 0, 0};
  static const int8_T iv1[6]{0, 0, 0, 0, 1, 0};
  static const int8_T iv2[6]{0, 0, 0, 0, 0, 1};
  real_T b_x[36];
  real_T dv[36];
  real_T dv1[36];
  real_T absxk;
  real_T d;
  real_T r_norm;
  real_T scale;
  real_T t;
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //  PROTOTYPE:
  //    [dxdt]=TBP(t,x,mu,check)
  // --------------------------------------------------------------------------
  //  DESCRIPTION:
  //    Function used to build the dynamics of the restricted two-body problem.
  //    Also the STM could be propagated.
  // --------------------------------------------------------------------------
  //  INPUT:
  //    t[1]            Time
  //    x[42x1]         State vector: It could contain also the state
  //                    transition matrix (STM) terms
  //    mu[1]           Earth mass parameter [km^3/s^2]
  //    check[1]        Value used to select if also the STM needs to be
  //                    included in the dynamics. In particular:
  //                    check==1 the dynamics contains also the STM terms
  // --------------------------------------------------------------------------
  //  OUTPUT:
  //    dxdt[42x1]      System dynamics
  // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  //  State
  //  Norm of the position
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
  //  Initial STM
  //  Definition of the A matrix
  //  Observation: A = df/dx(x*) where f is the dynamics function
  //  Computing the equation dphidt=A*phi
  //  Trasform the matrix into a vector
  //  Dynamics implementation
  std::copy(&x[6], &x[42], &b_x[0]);
  for (int32_T i{0}; i < 6; i++) {
    dv[6 * i] = iv[i];
    dv[6 * i + 1] = iv1[i];
    dv[6 * i + 2] = iv2[i];
  }
  d = 3.0 * mu / muDoubleScalarPower(r_norm, 5.0);
  scale = muDoubleScalarPower(r_norm, 3.0);
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
  for (int32_T i{0}; i < 6; i++) {
    for (int32_T i1{0}; i1 < 6; i1++) {
      d = 0.0;
      for (int32_T i2{0}; i2 < 6; i2++) {
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
  std::copy(&dv1[0], &dv1[36], &varargout_1[6]);
}

// End of code generation (STM_prop.cpp)
