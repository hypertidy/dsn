#include <Rinternals.h>


#define R_RGB(r,g,b)	  ((r)|((g)<<8)|((b)<<16)|0xFF000000)
#define R_RGBA(r,g,b,a)	((r)|((g)<<8)|((b)<<16)|((a)<<24))

SEXP C_native(SEXP b0, SEXP b1, SEXP b2, SEXP dm) {
  SEXP res_ = PROTECT(allocVector(INTSXP, length(b0)));
  for (int i = 0; i < length(b0); i++) {
      INTEGER(res_)[i] = (int)R_RGB(RAW(b0)[i], RAW(b1)[i], RAW(b2)[i]);
  }
  SEXP dim;
  dim = allocVector(INTSXP, 2);
	    INTEGER(dim)[0] = INTEGER(dm)[1];
	    INTEGER(dim)[1] = INTEGER(dm)[0];
	    setAttrib(res_, R_DimSymbol, dim);
	    setAttrib(res_, R_ClassSymbol, mkString("nativeRaster"));
	    {
		SEXP chsym = install("channels");
		setAttrib(res_, chsym, ScalarInteger(3));
	    }
  UNPROTECT(1);
  return res_;
}
