#051 Dong 

#Study used for recalculation: 
#Xiaoyuan Li, 2020 
#target values MD 0.58 [-0.12, 1.28]

#Values obtained from MA: 
library(metapp)

mean_i <- 0.18
SD_i <- 1.58
n_i <- 58 
#2 interventions groups combined 


mean_c <- -0.4
SD_c <- 1.56
n_c <- 29

#values obtained from Study: 

#Raw Data is provided in Suppl. Material. Change Scores in % i1 = Qigong, i2 = Taichi 
change_mean_i1 <- -0.0088
change_mean_i2 <- 0.45
change_mean_c <- -0.4028 # Yes, in line with MA 
change_SD_i1 <- 1.125
change_SD_i2 <- 2.3672
change_SD_c <- 2.0102 #Does not fit to the SD from MA 

#pool intervention groups 
pool_i <- pool_groups(change_mean_i1, change_mean_i2, change_SD_i1, change_SD_i2, 34, 24)
change_mean_i <- 0.181 # Yes, in line with MA 
change_SD_i <- 1.75 #differs from the SD in MA 


#Test to reproduce MD with the given values by the MA 

md(x1 = mean_i, x2 = mean_c, sd1 = SD_i, sd2 = SD_c, n1 = n_i, n2 = n_c) |> get_ci()
##perfect match 

#check with the pooled SD obtained from raw data: 

md(x1 = change_mean_i, x2 = change_mean_c, sd1 = change_SD_i, sd2 = change_SD_c, n1 = n_i, n2 = n_c) |> get_ci()
###es       var     ci_low  ci_high
# 0.5838 0.1921432 -0.2753335 1.442933 

# ES is okay, CI deviates
