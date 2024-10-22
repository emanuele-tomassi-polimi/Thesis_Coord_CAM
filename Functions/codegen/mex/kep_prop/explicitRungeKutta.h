/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * explicitRungeKutta.h
 *
 * Code generation for function 'explicitRungeKutta'
 *
 */

#pragma once

/* Include files */
#include "rtwtypes.h"
#include "emlrt.h"
#include "mex.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Declarations */
void computeCEStages78(real_T c_df_workspace_ODEFunction_work,
                       const real_T y[6], real_T h, real_T f[72],
                       int32_T *nfevals);

void computeMainStages78(real_T c_df_workspace_ODEFunction_work,
                         const real_T y[6], real_T h, real_T f[72],
                         int32_T *nfevals, real_T fC[6], real_T fE[6]);

real_T maxScaledError(real_T threshold, const real_T fE[6], const real_T y[6],
                      const real_T ynew[6]);

/* End of code generation (explicitRungeKutta.h) */
