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
setwd("C:/Users/alpeterson7/Documents/HannahVR/HVRrepo/")#this won't work for everything on git
load(file="HVR_data_setup.RData")

#calc MLH1 / CO number
meanPWD_MLH1 = mean(data_PWD$nMLH1_foci)

data_F2 <- mergd_file_name[mergd_file_name$Cross.x == "CxPF2", ]

meanCAST_MLH1 = mean(data_CAST$nMLH1_foci)
meanF2_MLH1 = mean(data_F2$nMLH1_foci)

# clean up df
data_PWD <- subset(data_PWD, select = -c(PixelWidth,PixelHeight,FractDistFromCent,FractInterXODist,RawDistFromCent,RawInterXODist ) )

#calc proportion of Chmr classes

#calculate 3CO in PWD (not listed in 3CO column)
data_HVR_full

for(h in 1:length(data_HVR_full$File.ID)){
  #if col 6 of 7 match and 7th(IFD doesn't ) 3CO  
  if( (data_HVR_full$File.ID[h] == data_HVR_full$File.ID[h+1]  ) &&      
        (data_HVR_full$Biv.ID[h]==data_HVR_full$Biv.ID[h+1] ) ){
    print(c("double ", h) )
    data_HVR_full$n3CO[h] = 1
  }
  
}


data_PWD <- data_HVR_full[data_HVR_full$Cross == "PWD", ] 

PWD_image_averages <- ddply(data_PWD, .(File.ID), summarize,
                        mouse = unique(Animal.ID),
                        xbar_IFD = mean(IFD),
                        varIFD = var(IFD),
                        #nMLH1_foci = mean(nMLH1_foci),
                        ncells = length(unique(File.ID)),
                        n3CO = sum(n3CO, na.rm=TRUE),
                        nIFDs = length(IFD),
                        n2CO = nIFDs - n3CO,
                        n1CO = 19 - (n3CO+n2CO)                    
)
PWD_image_averages

PWD_mouse <- ddply(PWD_image_averages, .(mouse), summarize,
                 
                  avIFD = mean(xbar_IFD),
                  ncells = length(ncells),
                  totbiv = ncells*19, 
                  tot_1CO = sum(n1CO),
                  tot_2CO= sum(n2CO),
                  tot_3CO= sum(n3CO),
                   p1CO =  tot_1CO /( ncells*19 ),
                  p2CO= tot_2CO/( ncells*19 ),
                  p3CO=tot_3CO/( ncells*19 )                          
)
PWD_mouse                          

data_F2 <- data_HVR_full[data_HVR_full$Cross == "F2", ] 
data_xF2 <- data_HVR_full[data_HVR_full$Cross == "CXPF2", ] 

F2 <- rbind(data_F2, data_xF2)

F2_image_averages <- ddply(F2, .(File.ID), summarize,
                            mouse = unique(Animal.ID),
                            xbar_IFD = mean(IFD),
                            varIFD = var(IFD),
                            #nMLH1_foci = mean(nMLH1_foci),
                            ncells = length(unique(File.ID)),
                            n3CO = sum(n3CO, na.rm=TRUE),
                            nIFDs = length(IFD),
                            n2CO = nIFDs - n3CO,
                            n1CO = 19 - (n3CO+n2CO)                    
)
F2_image_averages

F2_mouse <- ddply(F2_image_averages, .(mouse), summarize,
                   
                   avIFD = mean(xbar_IFD),
                   ncells = length(ncells),
                   totbiv = ncells*19, 
                   tot_1CO = sum(n1CO),
                   tot_2CO= sum(n2CO),
                   tot_3CO= sum(n3CO),
                   p1CO =  tot_1CO /( ncells*19 ),
                   p2CO= tot_2CO/( ncells*19 ),
                   p3CO=tot_3CO/( ncells*19 )                          
)
F2_mouse


CAST_image_averages <- ddply(data_CAST, .(file_name), summarize,
                            nIFD_measures = length(IFD),
                            xbar_IFD = mean(IFD),
                            varIFD = var(IFD),
                            #SE
                            nMLH1_foci = mean(nMLH1_foci),
                            ncells = length(unique(file_name)),
                            total_bivs = (ncells*20),
                            CO3 = sum(n3CO, na.rm=TRUE),
                            num_2CO = abs(length(IFD)-(CO3*2))  #this is too large
                            
)
CAST_image_averages

