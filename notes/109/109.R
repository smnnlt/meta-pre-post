#Kirchenberger et al 2021
#target ES 
# 0.71 [-0.28;1.71]
# According to MA: SMD with Post scores, Hedges G correction

library(metapp)

n_con <- 10
n_int <- 7

x_con <-  58.3
x_int <- 62.1
  
sd_con <- 3.9
sd_int <- 6.4
  
smd(x_int,x_con, sd1 = sd_int, sd2 = sd_con,n1 = n_int, n2 = n_con, hedges = TRUE ) |> get_ci()
#quite easy recalculation this time- perfect match :) 