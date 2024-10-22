//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// num2str.cpp
//
// Code generation for function 'num2str'
//

// Include files
#include "num2str.h"
#include "rt_nonfinite.h"

// Variable Definitions
static emlrtRSInfo
    wb_emlrtRSI{
        15,        // lineNo
        "num2str", // fcnName
        "/Applications/MATLAB_R2022a.app/toolbox/eml/eml/+coder/+internal/"
        "num2str.m" // pathName
    };

static emlrtMCInfo
    c_emlrtMCI{
        53,        // lineNo
        19,        // colNo
        "flt2str", // fName
        "/Applications/MATLAB_R2022a.app/toolbox/eml/eml/+coder/+internal/"
        "flt2str.m" // pName
    };

static emlrtRSInfo
    dc_emlrtRSI{
        53,        // lineNo
        "flt2str", // fcnName
        "/Applications/MATLAB_R2022a.app/toolbox/eml/eml/+coder/+internal/"
        "flt2str.m" // pathName
    };

// Function Declarations
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId, char_T ret[23]);

static const mxArray *b_sprintf(const emlrtStack *sp, const mxArray *m1,
                                const mxArray *m2, emlrtMCInfo *location);

static void emlrt_marshallIn(const emlrtStack *sp,
                             const mxArray *a__output_of_sprintf_,
                             const char_T *identifier, char_T y[23]);

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId, char_T y[23]);

// Function Definitions
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId, char_T ret[23])
{
  static const int32_T dims[2]{1, 23};
  emlrtCheckBuiltInR2012b((emlrtCTX)sp, msgId, src, (const char_T *)"char",
                          false, 2U, (void *)&dims[0]);
  emlrtImportCharArrayR2015b((emlrtCTX)sp, src, &ret[0], 23);
  emlrtDestroyArray(&src);
}

static const mxArray *b_sprintf(const emlrtStack *sp, const mxArray *m1,
                                const mxArray *m2, emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  const mxArray *m;
  pArrays[0] = m1;
  pArrays[1] = m2;
  return emlrtCallMATLABR2012b((emlrtCTX)sp, 1, &m, 2, &pArrays[0],
                               (const char_T *)"sprintf", true, location);
}

static void emlrt_marshallIn(const emlrtStack *sp,
                             const mxArray *a__output_of_sprintf_,
                             const char_T *identifier, char_T y[23])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(sp, emlrtAlias(a__output_of_sprintf_), &thisId, y);
  emlrtDestroyArray(&a__output_of_sprintf_);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId, char_T y[23])
{
  b_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

namespace coder {
namespace internal {
void num2str(const emlrtStack *sp, real_T x, char_T str[23])
{
  static const int32_T iv[2]{1, 7};
  static const char_T rfmt[7]{'%', '2', '3', '.', '1', '5', 'e'};
  emlrtStack b_st;
  emlrtStack st;
  const mxArray *b_y;
  const mxArray *m;
  const mxArray *y;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &wb_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  y = nullptr;
  m = emlrtCreateCharArray(2, &iv[0]);
  emlrtInitCharArrayR2013a(&st, 7, m, &rfmt[0]);
  emlrtAssign(&y, m);
  b_y = nullptr;
  m = emlrtCreateDoubleScalar(x);
  emlrtAssign(&b_y, m);
  b_st.site = &dc_emlrtRSI;
  emlrt_marshallIn(&b_st, b_sprintf(&b_st, y, b_y, &c_emlrtMCI),
                   "<output of sprintf>", str);
}

} // namespace internal
} // namespace coder

// End of code generation (num2str.cpp)
