/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_kep_prop_mex.c
 *
 * Code generation for function '_coder_kep_prop_mex'
 *
 */

/* Include files */
#include "_coder_kep_prop_mex.h"
#include "_coder_kep_prop_api.h"
#include "kep_prop_data.h"
#include "kep_prop_initialize.h"
#include "kep_prop_terminate.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void kep_prop_mexFunction(int32_T nlhs, mxArray *plhs[2], int32_T nrhs,
                          const mxArray *prhs[4])
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  const mxArray *outputs[2];
  int32_T b_nlhs;
  st.tls = emlrtRootTLSGlobal;
  /* Check for proper number of arguments. */
  if (nrhs != 4) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 4, 4,
                        8, "kep_prop");
  }
  if (nlhs > 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 8,
                        "kep_prop");
  }
  /* Call the function. */
  kep_prop_api(prhs, nlhs, outputs);
  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }
  emlrtReturnArrays(b_nlhs, &plhs[0], &outputs[0]);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  mexAtExit(&kep_prop_atexit);
  /* Module initialization. */
  kep_prop_initialize();
  /* Dispatch the entry-point. */
  kep_prop_mexFunction(nlhs, plhs, nrhs, prhs);
  /* Module termination. */
  kep_prop_terminate();
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLSR2022a(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1,
                           NULL, (const char_T *)"UTF-8", true);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_kep_prop_mex.c) */
