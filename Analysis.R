#Discriptive stats and patterns in HVR IFD data


#questions to address with HVR data
correlation of co n idf

proportions of objclass? ()
how consistant is this for mice? / how variable is this across P0s?

#############
# LOAD DATA #
#############
library(dplyr)
library(plyr)
setwd("C:/Users/alpeterson7/Documents/HannahVR/HVRrepo/")
load(file="HVR_data_setup.RData")


#calc MLH1 / CO number
meanPWD_MLH1 = mean(data_PWD$nMLH1_foci)
meanCAST_MLH1 = mean(data_CAST$nMLH1_foci)
meanF2_MLH1 = mean(data_F2$nMLH1_foci)

# clean up df
data_PWD <- subset(data_PWD, select = -c(PixelWidth,PixelHeight,FractDistFromCent,FractInterXODist,RawDistFromCent,RawInterXODist ) )

#calc proportion of Chmr classes

#calculate 3CO in PWD (not listed in 3CO column)

PWD_image_averages <- ddply(data_PWD, .(file_name), summarize,
                        nIFD_measures = length(IFD),
                        xbar_IFD = mean(IFD),
                        varIFD = var(IFD),
                        #SE
                        nMLH1_foci = mean(nMLH1_foci),
                        ncells = length(unique(file_name)),
                        total_bivs = (ncells*20),
                        CO3 = max(n3CO),  #parents won't have 3CO
                        num_2CO = abs(length(IFD)-(CO3*2))  #this is too large
                        
)
PWD_image_averages


CAST_image_averages <- ddply(data_CAST, .(file_name), summarize,
                            nIFD_measures = length(IFD),
                            xbar_IFD = mean(IFD),
                            varIFD = var(IFD),
                            #SE
                            nMLH1_foci = mean(nMLH1_foci),
                            ncells = length(unique(file_name)),
                            total_bivs = (ncells*20),
                            CO3 = max(X3.XO.Count.per.cell),
                            num_2CO = abs(length(IFD)-(CO3*2))  #this is too large
                            
)
CAST_image_averages

