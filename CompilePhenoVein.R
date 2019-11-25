#rlbakerlab.com
#robert.baker@miamioh.edu
#11 April 2019

###This script reads in a .csv generated in Phenovein (https://www.plant-image-analysis.org/software/phenovein) and outputs a single .csv file with data from each individual phenovein .csv compiled in a more usef-friendly wasy (i.e. rectangular data frame) for subsequent data analysis in R (or any other statistical analysis platform). This script assumes that all .csv files have a numerical name (i.e. 236.csv) where the number gives some unique identying information about the leaf being analyzed AND is the value listed in line 2 of the phenoVein output under "Analysis name:;" (e.g. "Analysis name:; 236).

###Citations: 
#1. R Core Team (2019). R: A language and environment for statistical computing. R Foundation forStatistical Computing, Vienna, Austria. URL https://www.R-project.org/.
#2. Bühler, J., L. Rishmawi, D. Pflugfelder, G. Huber, H. Scharr, M. Hüslkamp, M. Koornneef, U. Schurr, and S. Jahnke (2015). phenoVein - A tool for leaf vein segmentation and  analysis. Plant Physiology 169(4)2359-2370; DOI: 10.11/04/pp.1500974.
#3. Newsome, E. L., G. L. Brock, J. Lutz, and R. L. Baker. 2019. Applications in Plant Sciences (This paper).

#clears the deck by deleting eveything stored in memory
rm(list=ls())

#clear RAM:
gc()

#specify the directory the .csv files to import are in (you will neec to edit "your path")
 setwd("~/yourpath/S1_Rcode_and_example_phenoVein_output")

#generates a list of all the .csv files in the directory
csvs<-list.files(pattern = "*.csv")

#sets up an empty data frame to dump everything in to at the end
venation<-data.frame()

#start a loop that will import each .csv and extract relevant data from it:

for (i in 1:length(csvs)){

   #read in the first .csv
    dat<-read.csv(paste(csvs[i]), as.is=1)

   #get identifying information from the file name. 
    filename<-dat[1,]
    plant<-substring(filename, regexpr(";", filename)+1)

   #extract voxel size in mm:
    vox_size<-dat[2,]
    vox<-data.frame(strsplit(vox_size, ";"))

   #extract # of pixels observed:
    px_observed<-dat[3,]
    px_obs<-data.frame(strsplit(px_observed, ";"))

   #extract length of vein skeleton in mm:
    skel_length_mm<-dat[5,]
    skel<-data.frame(strsplit(skel_length_mm, ";"))

   #extract vein density in mm2:
    vein_density_mm2<-dat[6,]
    density<-data.frame(strsplit(vein_density_mm2, ";"))

   #extract # of endpoints in vein skeleton:
    end_points<-dat[8,]
    ends<-data.frame(strsplit(end_points, ";"))
        
   #extract # of branch points in vein skeleton:
    branch_points<-dat[9,]
    branch<-data.frame(strsplit(branch_points, ";"))
    
   #extract areole number (note: in our datasets the 1st areole number is very large because it is the sum of all non-closed/edge areas.  We remove this value from all subsequent analyses)
    areole_num<-dat[10,]
    areole_num<-data.frame(strsplit(areole_num, ";"))
    areole_num<-areole_num[-1,] #comment out this line to keep all values for areole number; alternatively increase to [-X,] to remove X number of values starting with the largest.
    areole_num<-data.frame(areole_num)
    colnames(areole_num)<-"tot_num"
    num<-as.numeric(as.character(areole_num$tot_num))
    
   #extract the area of each individual areole in pixels. Recall that we remove the first, very large area as it is the sum of all non-closed/edge areas:
    areole_px<-dat[11,]
    areole_px<-data.frame(strsplit(areole_px, ";"))
    areole_px<-data.frame(areole_px[-c(1:2),])
    colnames(areole_px)<-"areole_px"
    
   #extract the area of each individual areole in mm. The first areole is again removed:
    areole_area_mm2<-dat[12,]
    areole_mmsq<-data.frame(strsplit(areole_area_mm2, ";"))
    areole_mmsq<-data.frame(areole_mmsq[-c(1:2),])
    colnames(areole_mmsq)<-"areole_mm2"
    
   #assemple it all in to one data frame:
	  veins<-areole_px
	  veins$plant<-plant
	  veins$vox_size<-vox[2,1]
	  veins$px_obs<-px_obs[2,1]
	  veins$skel_length_mm<-skel[2,1]
	  veins$vein_density_mm2<-density[2,1]
	  veins$end_points<-ends[2,1]
	  veins$branch_points<-branch[2,1]
	  veins$areole_num<-num-1
	  veins$areole_px<-veins$areole_px
	  veins$areole_mmsq<-areole_mmsq$areole_mm2
	  veins<-veins[,-1]
	
   #append it to the larger data frame for each plant/location:
	  venation<-rbind(venation, veins)
	
	}

#create a new sub-directory to store output in:
dir.create("compiled_phenovein_output")

#change working directory to the new subdirectory:
setwd("./compiled_phenovein_output")

#save the new dataframe as a .csv with the filename of your choosing:
write.csv(file="name_your_file.csv", venation, row.names=FALSE)

