//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
//
// eps.cpp
//
// Code generation for function 'eps'
//

// Include files
#include "eps.h"
#include "rt_nonfinite.h"
#include "mwmathutil.h"
#include <cmath>
#include <math.h>

// Function Definitions
namespace coder {
real_T eps(real_T x)
{
  real_T absx;
  real_T r;
  int32_T exponent;
  absx = muDoubleScalarAbs(x);
  if ((!muDoubleScalarIsInf(absx)) && (!muDoubleScalarIsNaN(absx))) {
    if (absx <= 2.2250738585072014E-308) {
      r = 4.94065645841247E-324;
    } else {
      frexp(absx, &exponent);
      r = std::ldexp(1.0, exponent - 53);
    }
  } else {
    r = rtNaN;
  }
  return r;
}

} // namespace coder

// End of code generation (eps.cpp)
