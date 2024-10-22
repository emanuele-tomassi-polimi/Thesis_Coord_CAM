//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// explicitRungeKutta.h
//
// Code generation for function 'explicitRungeKutta'
//

#pragma once

// Include files
#include "rtwtypes.h"
#include "coder_array.h"
#include "emlrt.h"
#include "mex.h"
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

// Type Declarations
namespace coder {
class b_anonymous_function;

}

// Function Declarations
namespace coder {
void computeCEStages78(const b_anonymous_function df, const real_T y[42],
                       real_T h, real_T f[504], int32_T *nfevals);

void computeMainStages78(const b_anonymous_function df, const real_T y[42],
                         real_T h, real_T f[504], int32_T *nfevals,
                         real_T fC[42], real_T fE[42]);

boolean_T ismonotonic(const ::coder::array<real_T, 2U> &x);

real_T maxScaledError(real_T threshold, const real_T fE[42], const real_T y[42],
                      const real_T ynew[42]);

} // namespace coder

// End of code generation (explicitRungeKutta.h)
