#include <Rinternals.h>

SEXP C_addr(SEXP x)
{
  // A better way than : http://stackoverflow.com/a/10913296/403310
  char buffer[32];
  snprintf(buffer, 32, "%p", (void *)x);
  return(Rf_mkString(buffer));
}
