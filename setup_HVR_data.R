## data setup script
## input: HVR data files P0 and F2 sheets. Because data was 
#collected at different stages, they are in a slightly different format. BD's Excel scripts.
## output: R dataframe with HVR IFD data, BD' MLH1 data, merged HVR_BD_data

library(plyr)

data_HVR_P0 = read.csv("C:/Users/alpeterson7/Documents/HannahVR/HVR_IFD_P0.csv", header=TRUE)

#add REV.tif to end of file name for CAST
#CAST add '.tif' #PWD, remove 'PWD' from begining these files dont have rev
#F2. remove CXP from begining, REV.tif is theme_replace
data_HVR_P0$File.ID <- ifelse( grepl("CAST", data_HVR_P0$File.ID), paste(data_HVR_P0$File.ID, ".tif", sep=""),
                ifelse(grepl("PWD", data_HVR_P0$File.ID), substring(data_HVR_P0$File.ID, 4), 
                ifelse(grepl("CXP", data_HVR_P0$File.ID), substring(data_HVR_P0$File.ID, 4), "" ) ) )     

#this colnames, should be changed in the original google doc file.
colnames(data_HVR_P0) <- c( "File.ID","Cross","Animal.ID", 
                           "Cell.Count", "n3CO", "Biv.ID", "IFD")

#fill in animal.id cells
for(i in 1:length(data_HVR_P0$File.ID)){
  mouse_list = strsplit(as.character(data_HVR_P0$File.ID[i]), split="_")[[1]]
  data_HVR_P0$Animal.ID[i] = mouse_list[1] 
}

#create HVR_full, P0 + F2s
data_HVR = read.csv("C:/Users/alpeterson7/Documents/HannahVR/HVR_IFD_DATA_Sep17.csv", header=TRUE)

#seperate 2CO from 3CO
data_HVR <- subset(data_HVR, select = -c(Notes, Date.Collected) )
colnames(data_HVR) <- c("File.ID", "Cross", "Animal.ID", 
                        "Cell.Count", "n3CO", "Biv.ID", "IFD")

#merge 2 dataframes
data_HVR_full <- rbind(data_HVR_P0, data_HVR)

#fill in n3CO columns, #this marks 3CO biv (one of the biv measures), as a 3CO with a "1", else everything is NA
# this marks the first IFD measure as 3CO (with 1), maybe it should be a X for both IFD measures?
for(h in 1:length(data_HVR_full$File.ID)){
  #if col 6 of 7 match and 7th(IFD doesn't ) 3CO  
  if( (data_HVR_full$File.ID[h] == data_HVR_full$File.ID[h+1]  ) &&      
      (data_HVR_full$Biv.ID[h]==data_HVR_full$Biv.ID[h+1] ) ){
    print(c("double ", h) )
    data_HVR_full$n3CO[h] = 1
  }
}

# there are a subset of PWD file names which don't have REV. 
# Correctly add REV to image names so that file name is correct 
# .tif added at later steps
#find file names that don't contain REV..I don't know if this is actually useful
nonrv <- data_HVR_full$File.ID[!grepl("REV", data_HVR_full$File.ID)]
nonrv <- unique(nonrv) #42 biv measures without REV
nonrv <- gsub('.tif', '', nonrv)#remove '.tif' for better matching


#LOAD BD data (why did I have two seperate files for BD data)
BD_data = read.csv("C:/Users/alpeterson7/Documents/HannahVR/BD_RecombinationPhenotypes.csv", header=TRUE)
#there are only 10 PWD in this excel sheet, but 17 PWD mouse folders on lacie. First 7folders don't contain 'REV'
#suffix.

#remove all strains but PWD, CAST and CXP PXC, PxCF2, PxCF1, WSBxCASTF1, CxPF1, CxPF2, CZCHEI
BD_data <- BD_data[( (BD_data$Cross == "CxPF2") | (BD_data$Cross == "PxCF1") 
                | (BD_data$Cross == "CZECHI") | (BD_data$Cross == "PWD") 
                | (BD_data$Cross == "CAST") | (BD_data$Cross == "PxCF2")  ), ]

#subset BD data. columns not to include
BD_data <- subset(BD_data, select= -c(InchWidth, InchHeight, PixelHeight, PixelWidth, RawDistFromCent, FractDistFromCent))
#InchWidth, InchHeight, PixelHeight, PixelWidth, RawDistFromCent#FractDistFromCent

#create file name col for merging with HVR data
BD_data$file_name <- do.call(paste, c(BD_data[c("ANIMAL_ID", "Slide_ID", "CellNumber")], sep = "_")) 

#add REV to correct cells
REV <- subset(BD_data$file_name, !(BD_data$file_name %in% nonrv) )
#length(REV)#same length as full dataframe

BD_data$file_name <- paste( (BD_data$file_name[!(BD_data$file_name %in% nonrv)]) , "_REV.tif", sep="")

#merge HVR and BD dataframes, make sure cross categories are consistent, make sure file names are correct
IFD_nMLH1 <- merge.data.frame(BD_data, data_HVR_full, by.y = "File.ID", by.x = "file_name", all=FALSE)

# CLEAN UP
#don't remove the user specific data set since the PWD measures don't comppletely overlap
rm(data_HVR)
rm(data_HVR_P0)

#FINAL 
## save data
setwd("C:/Users/alpeterson7/Documents/HannahVR/HVRrepo/")
save.image("HVR_data_setup.RData")

