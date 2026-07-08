# dsn 0.1.0

* mem() no longer copies or converts its input: 'x' must be a double array
  and the DSN references its memory directly. Previously the address taken
  was of an internal temporary copy, eligible for garbage collection as soon
  as mem() returned.

* C_addr now returns the address of the data of a vector (not the SEXP), as
  a decimal string. This is portable to Windows (where '%p' omits the '0x'
  prefix) and removes the fixed header-offset arithmetic in mem(), which is
  also what prevented non-double types from working.

* mem() documents the GDAL >= 3.10 requirement to set GDAL_MEM_ENABLE_OPEN=YES,
  and the lifetime contract for the referenced memory.

* Native routine registration now actually occurs (the init function was
  misnamed R_init_addr, so registration silently never ran).

* unprefix() strips exactly one leading driver prefix and no longer eats
  Windows drive letters or subdataset paths; unvsicurl() is anchored to the
  start of the string.

* Removed unexported experimental rds().

* Add vsis3 and vsizip. 

* All data source functions have been removed to sds. 

* New internal C_addr, to replace lobstr import. 

* `vsicurl()` gains pc_url_signing with the `sign` arg (GDAL >= 3.5). 

* All data source functions have been removed to hypertidy/sds, so countrycode no longer needed. 

* New `nsdic_seaice()` for the GeoTIFF images. 

* New `srtm15()` source. 

* Add internal lists of tasmap_sources. 


* Fix gebco to use ice surface, add bedrock option for 2023 (thanks to Philippe Massicotte). 

* Clarify which gebco() functions return bedrock vs. ice surface. 


# dsn 0.0.1

* New 'nasadem()' for the OpenTopo VRT. 

* dsn now contains the source functions that whatarelief had, whatarelief imports them and re-exports some. 

* New functions for 'datatype()' . 

* New `mem()` function to reference an in memory array. 

* New functions `sds()` and `vrtcon()`. 

* First basic functions. 
