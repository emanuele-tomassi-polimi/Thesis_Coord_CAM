/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_STM_prop_api.h
 *
 * Code generation for function 'STM_prop'
 *
 */

#ifndef _CODER_STM_PROP_API_H
#define _CODER_STM_PROP_API_H

/* Include files */
#include "emlrt.h"
#include "tmwtypes.h"
#include <string.h>

/* Type Definitions */
#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T
struct emxArray_real_T {
  real_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};
#endif /* struct_emxArray_real_T */
#ifndef typedef_emxArray_real_T
#define typedef_emxArray_real_T
typedef struct emxArray_real_T emxArray_real_T;
#endif /* typedef_emxArray_real_T */

#ifndef typedef_struct0_T
#define typedef_struct0_T
typedef struct {
  real_T AbsTol;
  real_T RelTol;
} struct0_T;
#endif /* typedef_struct0_T */

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

#ifdef __cplusplus
extern "C" {
#endif

/* Function Declarations */
void STM_prop(real_T mu, emxArray_real_T *t_span_b, real_T x_0[42],
              struct0_T *ode_options, emxArray_real_T *t, emxArray_real_T *x);

void STM_prop_api(const mxArray *const prhs[4], int32_T nlhs,
                  const mxArray *plhs[2]);

void STM_prop_atexit(void);

void STM_prop_initialize(void);

void STM_prop_terminate(void);

void STM_prop_xil_shutdown(void);

void STM_prop_xil_terminate(void);

#ifdef __cplusplus
}
#endif

#endif
/* End of code generation (_coder_STM_prop_api.h) */
