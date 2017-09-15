## data setup script
## input: HVR data files P0 and F2 sheets. Because data was 
#collected at different stages, they are in a slightly different format. BD's Excel scripts.
## output: R dataframe with HVR IFD data and BD' MLH1 data


library(plyr)

data_HVR_P0 = read.csv("C:/Users/alpeterson7/Documents/HannahVR/HVR_IFD_P0.csv", header=TRUE)

#add REV.tif to end of file name for CAST
#CAST add '.tif'
#PWD, remove 'PWD' from begining these files dont have rev
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

#create HVR_full
#HVR full data set
data_HVR = read.csv("C:/Users/alpeterson7/Documents/HannahVR/HVR_IFD_DATA_Sep17.csv", header=TRUE)

#seperate 2CO from 3CO
#merge two data sets
#remove some columns with -c()
data_HVR <- subset(data_HVR, select = -c(Notes, Date.Collected) )
colnames(data_HVR) <- c("File.ID", "Cross", "Animal.ID", 
                        "Cell.Count", "n3CO", "Biv.ID", "IFD")

#find file.ID which don't have REV.tif, put into a list
data_HVR_full <- rbind(data_HVR_P0, data_HVR)

#does cell count need to be filled in for P0s...?
#fill in n3CO columns
#this marks 3CO biv (one of the biv measures), as a 3CO with a "1", else everything is NA
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
#remove all strains but PWD, CAST and CXP PXC, PxCF2, PxCF1, WSBxCASTF1, CxPF1, CxPF2


BDdata_F2 = read.csv("C:/Users/alpeterson7/Documents/HannahVR/BD_F2_RecombinationPhenotypes.csv", header=TRUE)
BDdata_F2$ANIMAL_ID <- as.factor(BDdata_F2$ANIMAL_ID)
#seprate by mouse, calculate average within mouse var  and average between mouse var
BDdata_P0 = read.csv("C:/Users/alpeterson7/Documents/HannahVR/BD_MLH1_CASTxPWD_P0.csv", header=TRUE)
BD_MLH1_data = rbind(BDdata_F2, BDdata_P0)
#it seems like ~the first 7 PWD mice aren't in BD's master phenotype file

#subset BD data (don't include )
BD_data <- subset(BD_data, select= -c( PixelHeight))#

#create file name col for merging with HVR data
BD_data$file_name <- do.call(paste, c(BD_data[c("ANIMAL_ID", "Slide_ID", "CellNumber")], sep = "_")) 

#don't know if this is working
REV <- subset(BD_data$file_name, !(BD_data$file_name %in% nonrv) ) #this returns a matrix of T OR F
length(REV)#same length as full dataframe
#IT seems like my versions of BD's data don't have the nonREV data... most 'file names should match (ie are useful for merging)

#can't find the mice, (2144 and 2146 in BD's df), 2146 and 2605 are the two PWD in HVR
# there should be 3 HVR PWD mice, they should show up in BD data
BD_MLH1_data$file_name <- paste( (BD_MLH1_data$file_name[!(BD_MLH1_data$file_name %in% nonrv)]) , "_REV.tif", sep="")

#BD_MLH1_data <- subset(BD_MLH1_data, select = -c(file_name) )#$FractDistFromCent, RawDistFromCent
#TODO for merge file, make sure cross categories are consistent, make sure file names are correct
IFD_nMLH1 <- merge.data.frame(BD_MLH1_data, data_HVR_full, by.y = "File.ID", by.x = "file_name", all=FALSE)

# subset some data
data_PWD <- IFD_nMLH1[IFD_nMLH1$Cross.x == "PWD", ] #the file names for many PWD don't match
data_CAST <- IFD_nMLH1[IFD_nMLH1$Cross.x == "CAST", ]
data_F2 <- IFD_nMLH1[IFD_nMLH1$Cross.x == "CXPF2", ]

#Make some tables for basic stats. (number of categories)
category_numbers_full <- ddply(IFD_nMLH1, .(Cross.x), summarize,
                          N_mice  = length(unique(Animal.ID)),#number of measurements
                          #N_IFD_MLH1 = ,
                          mean_MLH1 = mean(IFD),
                          var_IFD = var(IFD),#this is very large within mouse
                          sd_IFD   = sd(IFD)
                          #se   = sd / sqrt(N)
)
category_numbers_full #currently there is just one PWD, there should be 
#3 from HVR data and 10 from BD data

category_numbers_HVR <- ddply(data_HVR_full, .(Cross), summarize,
                               N_mice  = length(unique(Animal.ID)),#number of measurements
                               #N_IFD_MLH1 = ,
                               mean_MLH1 = mean(IFD),
                               var_IFD = var(IFD),#this is very large within mouse
                               sd_IFD   = sd(IFD)
                               #se   = sd / sqrt(N)
)
category_numbers_HVR

#BDs lacie folder has 17 PWD folders, not sure why it's not in Excel sheet
category_numbers_BD_full <- ddply(BD_MLH1_data, .(Cross), summarize,
                               N_mice  = length(unique(ANIMAL_ID))#number of measurements
                               #N_IFD_MLH1 = ,
                              # mean_MLH1 = mean(IFD),
                              # var_IFD = var(IFD),#this is very large within mouse
                              # sd_IFD   = sd(IFD)
                               #se   = sd / sqrt(N)
)
category_numbers_BD_full


#FINAL 
## save data
setwd("C:/Users/alpeterson7/Documents/HannahVR/HVRrepo/")
save.image("HVR_data_setup.RData")

# CLEAN UP
#save this list and use it to not add "REV" to when processing BD data
#rm(data_HVR)
#rm(data_HRV_P0)
