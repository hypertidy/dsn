#include <Rinternals.h>
#include <stdint.h>

/* Return the address of the DATA of a vector (not the SEXP header),
   formatted as a decimal string. Decimal is deliberate: it is accepted by
   the GDAL MEM driver DATAPOINTER, parses with as.double() on all
   platforms, and avoids the Windows quirk where %p omits the 0x prefix. */
SEXP C_addr(SEXP x)
{
  char buffer[32];
  void *p = NULL;
  switch (TYPEOF(x)) {
  case REALSXP: p = (void *)REAL(x);    break;
  case INTSXP:  p = (void *)INTEGER(x); break;
  case LGLSXP:  p = (void *)LOGICAL(x); break;
  case RAWSXP:  p = (void *)RAW(x);     break;
  case CPLXSXP: p = (void *)COMPLEX(x); break;
  default:
    Rf_error("unsupported type '%s' for address", Rf_type2char(TYPEOF(x)));
  }
  snprintf(buffer, sizeof(buffer), "%llu", (unsigned long long)(uintptr_t)p);
  return Rf_mkString(buffer);
}
