//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// _coder_STM_prop_api.cpp
//
// Code generation for function '_coder_STM_prop_api'
//

// Include files
#include "_coder_STM_prop_api.h"
#include "STM_prop.h"
#include "STM_prop_data.h"
#include "STM_prop_types.h"
#include "rt_nonfinite.h"
#include "coder_array.h"

// Function Declarations
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               coder::array<real_T, 2U> &ret);

static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *x_0,
                                   const char_T *identifier))[42];

static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[42];

static struct0_T c_emlrt_marshallIn(const emlrtStack *sp,
                                    const mxArray *ode_options,
                                    const char_T *identifier);

static struct0_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId);

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId);

static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                 const emlrtMsgIdentifier *msgId);

static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *mu,
                               const char_T *identifier);

static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *t_span_b,
                             const char_T *identifier,
                             coder::array<real_T, 2U> &y);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             coder::array<real_T, 2U> &y);

static const mxArray *emlrt_marshallOut(const coder::array<real_T, 1U> &u);

static const mxArray *emlrt_marshallOut(const coder::array<real_T, 2U> &u);

static real_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId))[42];

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId);

// Function Definitions
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               coder::array<real_T, 2U> &ret)
{
  static const int32_T dims[2]{1, -1};
  int32_T iv[2];
  const boolean_T bv[2]{false, true};
  emlrtCheckVsBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"double",
                            false, 2U, (void *)&dims[0], &bv[0], &iv[0]);
  ret.prealloc(iv[0] * iv[1]);
  ret.set_size(static_cast<emlrtRTEInfo *>(nullptr), sp, iv[0], iv[1]);
  ret.set(static_cast<real_T *>(emlrtMxGetData(src)), ret.size(0), ret.size(1));
  emlrtDestroyArray(&src);
}

static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *x_0,
                                   const char_T *identifier))[42]
{
  emlrtMsgIdentifier thisId;
  real_T(*y)[42];
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(x_0), &thisId);
  emlrtDestroyArray(&x_0);
  return y;
}

static real_T (*b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId))[42]
{
  real_T(*y)[42];
  y = f_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static struct0_T c_emlrt_marshallIn(const emlrtStack *sp,
                                    const mxArray *ode_options,
                                    const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  struct0_T y;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = c_emlrt_marshallIn(sp, emlrtAlias(ode_options), &thisId);
  emlrtDestroyArray(&ode_options);
  return y;
}

static struct0_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId)
{
  static const int32_T dims{0};
  static const char_T *fieldNames[22]{
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
      emlrt_marshallIn(sp,
                       emlrtAlias(emlrtGetFieldR2017b(
                           (emlrtCTX)sp, u, 0, 0, (const char_T *)"AbsTol")),
                       &thisId);
  thisId.fIdentifier = "BDF";
  d_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 1,
                                                    (const char_T *)"BDF")),
                     &thisId);
  thisId.fIdentifier = "Events";
  d_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 2,
                                                    (const char_T *)"Events")),
                     &thisId);
  thisId.fIdentifier = "InitialStep";
  d_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b(
                         (emlrtCTX)sp, u, 0, 3, (const char_T *)"InitialStep")),
                     &thisId);
  thisId.fIdentifier = "Jacobian";
  d_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b(
                         (emlrtCTX)sp, u, 0, 4, (const char_T *)"Jacobian")),
                     &thisId);
  thisId.fIdentifier = "JConstant";
  d_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b(
                         (emlrtCTX)sp, u, 0, 5, (const char_T *)"JConstant")),
                     &thisId);
  thisId.fIdentifier = "JPattern";
  d_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b(
                         (emlrtCTX)sp, u, 0, 6, (const char_T *)"JPattern")),
                     &thisId);
  thisId.fIdentifier = "Mass";
  d_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 7,
                                                    (const char_T *)"Mass")),
                     &thisId);
  thisId.fIdentifier = "MassSingular";
  d_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 8,
                                     (const char_T *)"MassSingular")),
      &thisId);
  thisId.fIdentifier = "MaxOrder";
  d_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b(
                         (emlrtCTX)sp, u, 0, 9, (const char_T *)"MaxOrder")),
                     &thisId);
  thisId.fIdentifier = "MaxStep";
  d_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 10,
                                                    (const char_T *)"MaxStep")),
                     &thisId);
  thisId.fIdentifier = "NonNegative";
  d_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 11,
                                     (const char_T *)"NonNegative")),
      &thisId);
  thisId.fIdentifier = "NormControl";
  d_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 12,
                                     (const char_T *)"NormControl")),
      &thisId);
  thisId.fIdentifier = "OutputFcn";
  d_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b(
                         (emlrtCTX)sp, u, 0, 13, (const char_T *)"OutputFcn")),
                     &thisId);
  thisId.fIdentifier = "OutputSel";
  d_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b(
                         (emlrtCTX)sp, u, 0, 14, (const char_T *)"OutputSel")),
                     &thisId);
  thisId.fIdentifier = "Refine";
  d_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 15,
                                                    (const char_T *)"Refine")),
                     &thisId);
  thisId.fIdentifier = "RelTol";
  y.RelTol =
      emlrt_marshallIn(sp,
                       emlrtAlias(emlrtGetFieldR2017b(
                           (emlrtCTX)sp, u, 0, 16, (const char_T *)"RelTol")),
                       &thisId);
  thisId.fIdentifier = "Stats";
  d_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 17,
                                                    (const char_T *)"Stats")),
                     &thisId);
  thisId.fIdentifier = "Vectorized";
  d_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b(
                         (emlrtCTX)sp, u, 0, 18, (const char_T *)"Vectorized")),
                     &thisId);
  thisId.fIdentifier = "MStateDependence";
  d_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 19,
                                     (const char_T *)"MStateDependence")),
      &thisId);
  thisId.fIdentifier = "MvPattern";
  d_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b(
                         (emlrtCTX)sp, u, 0, 20, (const char_T *)"MvPattern")),
                     &thisId);
  thisId.fIdentifier = "InitialSlope";
  d_emlrt_marshallIn(
      sp,
      emlrtAlias(emlrtGetFieldR2017b((emlrtCTX)sp, u, 0, 21,
                                     (const char_T *)"InitialSlope")),
      &thisId);
  emlrtDestroyArray(&u);
  return y;
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId)
{
  g_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
}

static real_T e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                 const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims{0};
  real_T ret;
  emlrtCheckBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"double",
                          false, 0U, (void *)&dims);
  ret = *static_cast<real_T *>(emlrtMxGetData(src));
  emlrtDestroyArray(&src);
  return ret;
}

static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *mu,
                               const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  real_T y;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = emlrt_marshallIn(sp, emlrtAlias(mu), &thisId);
  emlrtDestroyArray(&mu);
  return y;
}

static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = e_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *t_span_b,
                             const char_T *identifier,
                             coder::array<real_T, 2U> &y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(sp, emlrtAlias(t_span_b), &thisId, y);
  emlrtDestroyArray(&t_span_b);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             coder::array<real_T, 2U> &y)
{
  b_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static const mxArray *emlrt_marshallOut(const coder::array<real_T, 1U> &u)
{
  static const int32_T i{0};
  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateNumericArray(1, (const void *)&i, mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, &(((coder::array<real_T, 1U> *)&u)->data())[0]);
  emlrtSetDimensions((mxArray *)m, ((coder::array<real_T, 1U> *)&u)->size(), 1);
  emlrtAssign(&y, m);
  return y;
}

static const mxArray *emlrt_marshallOut(const coder::array<real_T, 2U> &u)
{
  static const int32_T iv[2]{0, 0};
  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateNumericArray(2, (const void *)&iv[0], mxDOUBLE_CLASS, mxREAL);
  emlrtMxSetData((mxArray *)m, &(((coder::array<real_T, 2U> *)&u)->data())[0]);
  emlrtSetDimensions((mxArray *)m, ((coder::array<real_T, 2U> *)&u)->size(), 2);
  emlrtAssign(&y, m);
  return y;
}

static real_T (*f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId))[42]
{
  static const int32_T dims{42};
  real_T(*ret)[42];
  emlrtCheckBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"double",
                          false, 1U, (void *)&dims);
  ret = (real_T(*)[42])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims[2]{0, 0};
  emlrtCheckBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"double",
                          false, 2U, (void *)&dims[0]);
  emlrtMxGetData(src);
  emlrtDestroyArray(&src);
}

void STM_prop_api(const mxArray *const prhs[4], int32_T nlhs,
                  const mxArray *plhs[2])
{
  coder::array<real_T, 2U> t_span_b;
  coder::array<real_T, 2U> x;
  coder::array<real_T, 1U> t;
  emlrtStack st{
      nullptr, // site
      nullptr, // tls
      nullptr  // prev
  };
  struct0_T ode_options;
  real_T(*x_0)[42];
  real_T mu;
  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  // Marshall function inputs
  mu = emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "mu");
  t_span_b.no_free();
  emlrt_marshallIn(&st, emlrtAlias(prhs[1]), "t_span_b", t_span_b);
  x_0 = b_emlrt_marshallIn(&st, emlrtAlias(prhs[2]), "x_0");
  ode_options = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[3]), "ode_options");
  // Invoke the target function
  STM_prop(&st, mu, t_span_b, *x_0, &ode_options, t, x);
  // Marshall function outputs
  t.no_free();
  plhs[0] = emlrt_marshallOut(t);
  if (nlhs > 1) {
    x.no_free();
    plhs[1] = emlrt_marshallOut(x);
  }
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

// End of code generation (_coder_STM_prop_api.cpp)
