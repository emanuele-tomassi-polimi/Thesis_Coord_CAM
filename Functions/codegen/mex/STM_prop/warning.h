//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// warning.h
//
// Code generation for function 'warning'
//

#pragma once

// Include files
#include "rtwtypes.h"
#include "emlrt.h"
#include "mex.h"
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

// Function Declarations
namespace coder {
namespace internal {
void b_warning(const emlrtStack *sp);

void warning(const emlrtStack *sp);

void warning(const emlrtStack *sp, const char_T varargin_1[23],
             const char_T varargin_2[23]);

} // namespace internal
} // namespace coder

// End of code generation (warning.h)
