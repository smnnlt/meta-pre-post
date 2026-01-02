#MA Barrera-Domínguez, et al. 
#Study used for Recalculation 
#Brini et al 2020

#Target ES -0.16 [-1.14, 0.82]

#There seems to be an extraction error in table 2 of the MA
#The T-Test was used for analysis, 
#the mean change is 3.38 +-1.13 for intervention group, Tab2 states 3.5 
library(metapp)
n <- 8
mean_int <- 3.38
sd_int <- 1.13
mean_con <- 1.7
sd_con <- 1.24

smd(mean_int, mean_con, sd_int, sd_con, n , n, hedges = FALSE, homo= TRUE, vartype = 1)|> get_ci()
#doesn't match 

# As the forest plot states the post-intervention values, I'll try to calculate SMD using them 

post_int <- 9.86
post_sd_int <- 0.91
post_con <- 10.01
post_sd_con <- 0.87

smd(post_int, post_con, post_sd_int, post_sd_con, n, n, hedges = FALSE,homo= TRUE, vartype = 1)|> get_ci() 
#almost a perfect match

#using hedges g correction:
smd(post_int, post_con, post_sd_int, post_sd_con, n, n, hedges = TRUE, homo= TRUE, vartype = 1)|> get_ci() 
#thats the target ES 
