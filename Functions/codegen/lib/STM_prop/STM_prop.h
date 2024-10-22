/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * STM_prop.h
 *
 * Code generation for function 'STM_prop'
 *
 */

#ifndef STM_PROP_H
#define STM_PROP_H

/* Include files */
#include "STM_prop_types.h"
#include "rtwtypes.h"
#include <stddef.h>
#include <stdlib.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Function Declarations */
extern void STM_prop(double mu, const emxArray_real_T *t_span_b,
                     const double x_0[42], const struct0_T *ode_options,
                     emxArray_real_T *t, emxArray_real_T *x);

#ifdef __cplusplus
}
#endif

#endif
/* End of code generation (STM_prop.h) */
