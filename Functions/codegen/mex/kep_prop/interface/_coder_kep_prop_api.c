/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_kep_prop_api.c
 *
 * Code generation for function '_coder_kep_prop_api'
 *
 */

/* Include files */
#include "_coder_kep_prop_api.h"
#include "kep_prop.h"
#include "kep_prop_data.h"
#include "kep_prop_emxutil.h"
#include "kep_prop_types.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRTEInfo l_emlrtRTEI = {
    1,                     /* lineNo */
    1,                     /* colNo */
    "_coder_kep_prop_api", /* fName */
    ""                     /* pName */
};

/* Function Declarations */
static const mxArray *b_emlrt_marshallOut(const emxArray_real_T *u);

static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *mu,
                                 const char_T *identifier);

static real_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId);

static real_T (*e_emlrt_marshallIn(const emlrtStack *sp,
                                   const mxArray *t_span_b,
                                   const char_T *identifier))[2];

static const mxArray *emlrt_marshallOut(const emxArray_real_T *u);

static real_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[2];

static real_T (*g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *x_0,
                                   const char_T *identifier))[6];

static real_T (*h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[6];

static struct0_T i_emlrt_marshallIn(const emlrtStack *sp,
                                    const mxArray *ode_options,
                                    const char_T *identifier);

static struct0_T j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId);

static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId);

static real_T m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                 const emlrtMsgIdentifier *msgId);

static real_T (*n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId))[2];

static real_T (*o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId))[6];

static void p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId);

/* Function Definitions */
static const mxArray *b_emlrt_marshallOut(const emxArray_real_T *u)
{
  static const int32_T iv[2] = {0, 0};
  const mxArray *m;
  const mxArray *y;
  const real_T *u_data;
  u_data = u->data;
  y = NULL;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, (void *)&u_data[0]);
  emlrtSetDimensions((mxArray *)m, &u->size[0], 2);
  emlrtAssign(&y, m);
  return y;
}

static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *mu,
                                 const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  real_T y;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(sp, emlrtAlias(mu), &thisId);
  emlrtDestroyArray(&mu);
  return y;
}

static real_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = m_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T (*e_emlrt_marshallIn(const emlrtStack *sp,
                                   const mxArray *t_span_b,
                                   const char_T *identifier))[2]
{
  emlrtMsgIdentifier thisId;
  real_T(*y)[2];
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = f_emlrt_marshallIn(sp, emlrtAlias(t_span_b), &thisId);
  emlrtDestroyArray(&t_span_b);
  return y;
}

static const mxArray *emlrt_marshallOut(const emxArray_real_T *u)
{
  static const int32_T i = 0;
  const mxArray *m;
  const mxArray *y;
  const real_T *u_data;
  u_data = u->data;
  y = NULL;
  m = emlrtCreateNumericArray(1, (const void *)&i, mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, (void *)&u_data[0]);
  emlrtSetDimensions((mxArray *)m, &u->size[0], 1);
  emlrtAssign(&y, m);
  return y;
}

static real_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[2]
{
  real_T(*y)[2];
  y = n_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static real_T (*g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *x_0,
                                   const char_T *identifier))[6]
{
  emlrtMsgIdentifier thisId;
  real_T(*y)[6];
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = h_emlrt_marshallIn(sp, emlrtAlias(x_0), &thisId);
  emlrtDestroyArray(&x_0);
  return y;
}

static real_T (*h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[6]
{
  real_T(*y)[6];
  y = o_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static struct0_T i_emlrt_marshallIn(const emlrtStack *sp,
                                    const mxArray *ode_options,
                                    const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  struct0_T y;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = j_emlrt_marshallIn(sp, emlrtAlias(ode_options), &thisId);
  emlrtDestroyArray(&ode_options);
  return y;
}

static struct0_T j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId)
{
  static const int32_T dims = 0;
  static const char_T *fieldNames[22] = {
      "AbsTol",       "BDF",         "Events",     "InitialStep",
      "Jacobian",     "JConstant",   "JPattern",   "Mass",
      "MassSingular", "MaxOrder",    "MaxStep",    "NonNegative",
      "NormControl",  "OutputFcn",   "OutputSel",  "Refine",
      "RelTol",       "Stats",       "Vectorized", "MStateDependence",
      "MvPattern",    "InitialSlope"};
  emlrtMsgIdentifier thisId;
  struct0_T y;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtCTX)sp, parentId, u, 22,
                         (const char_T **)&fieldNames[0], 0U, (void *)&dims);
  thisId.fIdentifier = "AbsTol";
  y.AbsTol =
      d_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b(
                             (emlrtCTX)sp, u, 0, 0, (const char_T *)"AbsTol")),
                         &thisId);
  thisId.fIdentifier = "BDF";
  k_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 1,
                                                    (const char_T *)"BDF")),
                     &thisId);
  thisId.fIdentifier = "Events";
  k_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 2,
                                                    (const char_T *)"Events")),
                     &thisId);
  thisId.fIdentifier = "InitialStep";
  k_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b(
                         (emlrtCTX)sp, u, 0, 3, (const char_T *)"InitialStep")),
                     &thisId);
  thisId.fIdentifier = "Jacobian";
  k_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b(
                         (emlrtCTX)sp, u, 0, 4, (const char_T *)"Jacobian")),
                     &thisId);
  thisId.fIdentifier = "JConstant";
  k_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b(
                         (emlrtCTX)sp, u, 0, 5, (const char_T *)"JConstant")),
                     &thisId);
  thisId.fIdentifier = "JPattern";
  k_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b(
                         (emlrtCTX)sp, u, 0, 6, (const char_T *)"JPattern")),
                     &thisId);
  thisId.fIdentifier = "Mass";
  k_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 7,
                                                    (const char_T *)"Mass")),
                     &thisId);
  thisId.fIdentifier = "MassSingular";
  k_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 8,
                                     (const char_T *)"MassSingular")),
      &thisId);
  thisId.fIdentifier = "MaxOrder";
  k_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b(
                         (emlrtCTX)sp, u, 0, 9, (const char_T *)"MaxOrder")),
                     &thisId);
  thisId.fIdentifier = "MaxStep";
  k_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 10,
                                                    (const char_T *)"MaxStep")),
                     &thisId);
  thisId.fIdentifier = "NonNegative";
  k_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 11,
                                     (const char_T *)"NonNegative")),
      &thisId);
  thisId.fIdentifier = "NormControl";
  k_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 12,
                                     (const char_T *)"NormControl")),
      &thisId);
  thisId.fIdentifier = "OutputFcn";
  k_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b(
                         (emlrtCTX)sp, u, 0, 13, (const char_T *)"OutputFcn")),
                     &thisId);
  thisId.fIdentifier = "OutputSel";
  k_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b(
                         (emlrtCTX)sp, u, 0, 14, (const char_T *)"OutputSel")),
                     &thisId);
  thisId.fIdentifier = "Refine";
  k_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 15,
                                                    (const char_T *)"Refine")),
                     &thisId);
  thisId.fIdentifier = "RelTol";
  y.RelTol =
      d_emlrt_marshallIn(sp,
                         emlrtAlias(emlrtGetFieldR2017b(
                             (emlrtCTX)sp, u, 0, 16, (const char_T *)"RelTol")),
                         &thisId);
  thisId.fIdentifier = "Stats";
  k_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 17,
                                                    (const char_T *)"Stats")),
                     &thisId);
  thisId.fIdentifier = "Vectorized";
  k_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b(
                         (emlrtCTX)sp, u, 0, 18, (const char_T *)"Vectorized")),
                     &thisId);
  thisId.fIdentifier = "MStateDependence";
  k_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 19,
                                     (const char_T *)"MStateDependence")),
      &thisId);
  thisId.fIdentifier = "MvPattern";
  k_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b(
                         (emlrtCTX)sp, u, 0, 20, (const char_T *)"MvPattern")),
                     &thisId);
  thisId.fIdentifier = "InitialSlope";
  k_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 21,
                                     (const char_T *)"InitialSlope")),
      &thisId);
  emlrtDestroyArray(&u);
  return y;
}

static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId)
{
  p_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
}

static real_T m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                 const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims = 0;
  real_T ret;
  emlrtCheckBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"double",
                          false, 0U, (void *)&dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T (*n_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId))[2]
{
  static const int32_T dims[2] = {1, 2};
  real_T(*ret)[2];
  emlrtCheckBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"double",
                          false, 2U, (void *)&dims[0]);
  ret = (real_T(*)[2])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static real_T (*o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId))[6]
{
  static const int32_T dims = 6;
  real_T(*ret)[6];
  emlrtCheckBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"double",
                          false, 1U, (void *)&dims);
  ret = (real_T(*)[6])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims[2] = {0, 0};
  emlrtCheckBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"double",
                          false, 2U, (void *)&dims[0]);
  emlrtMxGetData(src);
  emlrtDestroyArray(&src);
}

void kep_prop_api(const mxArray *const prhs[4], int32_T nlhs,
                  const mxArray *plhs[2])
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  emxArray_real_T *t;
  emxArray_real_T *x;
  struct0_T ode_options;
  real_T(*x_0)[6];
  real_T(*t_span_b)[2];
  real_T mu;
  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_real_T(&st, &t, 1, &l_emlrtRTEI);
  emxInit_real_T(&st, &x, 2, &l_emlrtRTEI);
  /* Marshall function inputs */
  mu = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "mu");
  t_span_b = e_emlrt_marshallIn(&st, emlrtAlias(prhs[1]), "t_span_b");
  x_0 = g_emlrt_marshallIn(&st, emlrtAlias(prhs[2]), "x_0");
  ode_options = i_emlrt_marshallIn(&st, emlrtAliasP(prhs[3]), "ode_options");
  /* Invoke the target function */
  kep_prop(&st, mu, *t_span_b, *x_0, &ode_options, t, x);
  /* Marshall function outputs */
  t->canFreeData = false;
  plhs[0] = emlrt_marshallOut(t);
  emxFree_real_T(&st, &t);
  if (nlhs > 1) {
    x->canFreeData = false;
    plhs[1] = b_emlrt_marshallOut(x);
  }
  emxFree_real_T(&st, &x);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

/* End of code generation (_coder_kep_prop_api.c) */
