## Test environments
* local OS X 10.13.2 install, R 3.5.3
* win-builder (devel and release)

## R CMD check results
There were no ERRORs or WARNINGs. 

There was 1 NOTE:

* checking CRAN incoming feasibility ... NOTE
  Possibly mis-spelled words in DESCRIPTION:
    Guralnick (5:318)
    Informatics (5:356)
  
  "Guralnick" is an author name, "Informatics" is a journal name.

## Downstream dependencies
I have also run a devtools::revdep_check() check on downstream dependencies of 
climateStability. 

All packages that I could install passed with no ERRORs or WARNINGs.
