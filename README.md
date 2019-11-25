# AppsInPlantSci_phenoVein

This repository is for compiling and reorganizing output from the phenoVein program for downstream data analyses. It includes: 1) The R script 2) sample input files (generated using phenoVein) and 3) a sample output file

This script reads in a .csv generated in Phenovein (https://www.plant-image-analysis.org/software/phenovein) and outputs a single .csv file with data from each individual phenovein .csv compiled in a more usef-friendly wasy (i.e. rectangular data frame) for subsequent data analysis in R (or any other statistical analysis platform). This script assumes that all .csv files have a numerical name (i.e. 236.csv) where the number gives some unique identying information about the leaf being analyzed AND is the value listed in line 2 of the phenoVein output under "Analysis name:;" (e.g. "Analysis name:; 236).

Citations: 
1. R Core Team (2019). R: A language and environment for statistical computing. R Foundation forStatistical Computing, Vienna, Austria. URL https://www.R-project.org/.
2. Bühler, J., L. Rishmawi, D. Pflugfelder, G. Huber, H. Scharr, M. Hüslkamp, M. Koornneef, U. Schurr, and S. Jahnke (2015). phenoVein - A tool for leaf vein segmentation and  analysis. Plant Physiology 169(4)2359-2370; DOI: 10.11/04/pp.1500974.
3. Newsome, E. L., G. L. Brock, J. Lutz, and R. L. Baker. 20xx. Applications in Plant Sciences (This manuscript).
