#include <Rinternals.h>
#include <R_ext/Rdynload.h>



/* .Call calls */
extern SEXP C_addr(SEXP x);

static const R_CallMethodDef CallEntries[] = {
    {"C_addr", (DL_FUNC) &C_addr, 1},
    {NULL, NULL, 0}
};

void R_init_addr(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
