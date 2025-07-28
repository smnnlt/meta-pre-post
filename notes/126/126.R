#MA Junge
#target ES 
#SMD -0.26 [-1.00, 0.49]
library(metapp)
#Contreras 2017
n <- 14

change_ht <- 103.42 # typo in suppl. ? 
change_fs <- 107.30 #typo again ? 

sd_fs <- 7.82/58.23 # 13.43 fits to suppl.
sd_ht <- 8.22/56.09 # 14.65 does not fit -> 15.72 in suppl 

smd(change_ht, change_fs, sd_ht, sd_fs, n, n) |> get_ci()
#nope
#try without "100%"

smd(3.42, 7.30, 13.43, 14.65, n,n)|> get_ci()
#close, try with sd_ht as in suppl. mat 

smd(3.42, 7.30, 13.43, 15.72, n,n)|> get_ci()
#matches to MA 

