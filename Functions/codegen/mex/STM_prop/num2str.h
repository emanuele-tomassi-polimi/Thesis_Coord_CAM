//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// num2str.h
//
// Code generation for function 'num2str'
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
void num2str(const emlrtStack *sp, real_T x, char_T str[23]);

}
} // namespace coder

// End of code generation (num2str.h)
