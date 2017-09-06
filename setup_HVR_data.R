## data setup script
## input: HVR data files (Excel), BD's Excel scripts
## output: R dataframe with HVR IFD data and BD' MLH1 data

data_HVR_P0 = read.csv("C:/Users/alpeterson7/Documents/HannahVR/HVR_IFD_P0.csv", header=TRUE)

#add REV.tif to end of file name for CAST
#CAST add '.tif'
#PWD, remove 'PWD' from begining these files dont have rev
#F2. remove CXP from begining, REV.tif is theme_replace
data_HVR_P0$File.ID <- ifelse( grepl("CAST", data_HVR_P0$File.ID), paste(data_HVR_P0$File.ID, ".tif", sep=""),
                ifelse(grepl("PWD", data_HVR_P0$File.ID), substring(data_HVR_P0$File.ID, 4), 
                ifelse(grepl("CXP", data_HVR_P0$File.ID), substring(data_HVR_P0$File.ID, 4), "" ) ) )     



colnames(data_HVR_P0) <- c("File.ID", "Cross", "Animal.ID", 
                           "Cell.Count", "n3CO", "Biv.ID", "IFD")

#add animal.id col
for(i in 1:length(data_HVR_P0$File.ID)){
  mouse_list = strsplit(as.character(data_HVR_P0$File.ID[i]), split="_")[[1]]
  data_HVR_P0$Animal.ID[i] = mouse_list[1] 
}

#add 3CO data to n3CO col
CO3s <- ddply(data_HVR_P0, .(File.ID), summarize,
                #if Biv.ID is duplicated, 3CO.. if there is a Biv.ID that isn't unique... count as a 3CO
    #if max and length differ, that indicates there is a 3CO 
                max = max(Biv.ID),
                measures = length(Biv.ID),
                n3CO = measures-max
)
CO3s

#push CO3s into P0 dataframe

#mact
data_HVR_P0$n3CO = CO3s

#(xu <- x[!duplicated(x)])


#HVR full data set
data_HVR = read.csv("C:/Users/alpeterson7/Documents/HannahVR/HVR_IFD_DATA_Aug17.csv", header=TRUE)
#seperate 2CO from 3CO

#merge two data sets
#remove some columns with -c()
data_HVR <- subset(data_HVR, select = -c(Notes, Date.Collected, X, X.1, X.2, X.3, X.4, X.5, X.6) )

colnames(data_HVR) <- c("File.ID", "Cross", "Animal.ID", 
                        "Cell.Count", "n3CO", "Biv.ID", "IFD")

#find file.ID which don't have REV.tif, put into a list

data_HVR_full <- rbind(data_HRV_P0, data_HVR)


##I don't know why this isn't working 
data_HVR_full$File.ID <- as.character(data_HVR_full$File.ID)

#find file names that don't contain REV
nonrv <- data_HVR_full$File.ID[!grepl("REV", data_HVR_full$File.ID)]
nonrv <- unique(nonrv)
nonrv <- gsub('.tif', '', nonrv)#remove '.tif' for better matching

#save this list and use it to not add "REV" to when processing BD data


rm(data_HVR)
rm(data_HRV_P0)

data_HVR_full 
#HVR df with F2 and P0s measures, File.ID columns are used for merging/matching to 
#BD MLH1 data in next step (nonrv list)


#LOAD BD data

BDdata_F2 = read.csv("C:/Users/alpeterson7/Documents/HannahVR/BD_F2_RecombinationPhenotypes.csv", header=TRUE)
BDdata_F2$ANIMAL_ID <- as.factor(BDdata_F2$ANIMAL_ID)
#seprate by mouse, calculate average within mouse var  and average between mouse var
BDdata_P0 = read.csv("C:/Users/alpeterson7/Documents/HannahVR/BD_MLH1_CASTxPWD_P0.csv", header=TRUE)
BD_MLH1_data = rbind(BDdata_F2, BDdata_P0)

#change CXPF2 to F2 OR viceversa

#mlh1 <- BD_MLH1_data[BD_MLH1_data$Cross == "CxPF2", ]
#mean(mlh1$nMLH1_foci )


#create file name col for mating with HVR data
BD_MLH1_data$file_name <- do.call(paste, c(BD_MLH1_data[c("ANIMAL_ID", "Slide_ID", "CellNumber")], sep = "_")) 

BD_MLH1_data$file_name <- do.call(paste, c(BD_MLH1_data[c("ANIMAL_ID", "Slide_ID", "CellNumber")], sep = "_"))

REV <- subset(BD_MLH1_data$file_name, !(BD_MLH1_data$file_name %in% nonrv) ) #this returns a matrix of T OR F
length(REV)#same length as full dataframe
#IT seems like my versions of BD's data don't have the nonREV data... most 'file names should match (ie are useful for mergeing)

BD_MLH1_data$file_name <- paste( (BD_MLH1_data$file_name[!(BD_MLH1_data$file_name %in% nonrv)]) , "_REV.tif", sep="")

#BD_MLH1_data <- subset(BD_MLH1_data, select = -c(file_name) )#$FractDistFromCent, RawDistFromCent

#TODO for merge file, make sure cross categories are consistent, make sure file names are correct
mergd_file_name <- merge.data.frame(BD_MLH1_data, data_HVR_full, by.y = "File.ID", by.x = "file_name", all=FALSE)

rm(BDdata_P0, BDdata_F2)

#HVR length(data_HVR_full$File.ID), 7485
#BD length(BD_MLH1_data$file_name)

#file_BD_only <- setdiff(BD_MLH1_data$file_name, data_HVR_full$File.ID)#4945
#file_BD_only <- setdiff(data_HVR_full$File.ID, BD_MLH1_data$file_name)#99
#not_passed_mice <- data.frame(not_passed_mice)
#colnames(not_passed_mice) <- c("mouse")

#correctly merging BD' MLH1 data to HVR IFD data
# - remove cells from BD data not in HVR data

data_PWD <- mergd_file_name[mergd_file_name$Cross.x == "PWD", ] #the file names for many PWD don't match
data_CAST <- mergd_file_name[mergd_file_name$Cross.x == "CAST", ]
data_F2 <- mergd_file_name[mergd_file_name$Cross.x == "CxPF2", ]

#FINAL 
## save data
setwd("C:/Users/alpeterson7/Documents/HannahVR/HVRrepo/")
save.image("HVR_data_setup.RData")
