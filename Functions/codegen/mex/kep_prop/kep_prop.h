/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * kep_prop.h
 *
 * Code generation for function 'kep_prop'
 *
 */

#pragma once

/* Include files */
#include "kep_prop_types.h"
#include "rtwtypes.h"
#include "emlrt.h"
#include "mex.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Declarations */
void kep_prop(const emlrtStack *sp, real_T mu, const real_T t_span_b[2],
              const real_T x_0[6], const struct0_T *ode_options,
              emxArray_real_T *t, emxArray_real_T *x);

void kep_prop_anonFcn1(real_T mu, const real_T x[6], real_T varargout_1[6]);

/* End of code generation (kep_prop.h) */
