#include <Rinternals.h>
#include <R_ext/Rdynload.h>



/* .Call calls */
extern SEXP C_addr(SEXP x);
extern SEXP C_native(SEXP b0, SEXP b1, SEXP b2);

static const R_CallMethodDef CallEntries[] = {
    {"C_addr", (DL_FUNC) &C_addr, 1},
    {"C_native", (DL_FUNC) &C_addr, 3},
    {NULL, NULL, 0}
};

void R_init_addr(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
