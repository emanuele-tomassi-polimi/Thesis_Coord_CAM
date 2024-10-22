//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// STM_prop.h
//
// Code generation for function 'STM_prop'
//

#pragma once

// Include files
#include "STM_prop_types.h"
#include "rtwtypes.h"
#include "coder_array.h"
#include "emlrt.h"
#include "mex.h"
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

// Function Declarations
void STM_prop(const emlrtStack *sp, real_T mu,
              const coder::array<real_T, 2U> &t_span_b, const real_T x_0[42],
              const struct0_T *ode_options, coder::array<real_T, 1U> &t,
              coder::array<real_T, 2U> &x);

void STM_prop_anonFcn1(real_T mu, const real_T x[42], real_T varargout_1[42]);

// End of code generation (STM_prop.h)
