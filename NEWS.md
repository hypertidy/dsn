# dev

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
