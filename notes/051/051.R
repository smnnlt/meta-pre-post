# Recalculation of MA #051 (Dong)

library(metapp)
library(readxl)

# Study to recalculate: Li et al. 2020
# target ES: 0.58 [-0.12, 1.28]

# using the raw data provided by Li in S1:

# read data
qi <- read_excel("notes/051/Rawdata.xlsx", sheet = 2, skip = 3)[,c(4,7)]
tai <- read_excel("notes/051/Rawdata.xlsx", sheet = 4, skip = 3)[,c(4,7)]
con <- read_excel("notes/051/Rawdata.xlsx", sheet = 6, skip = 3)[,c(4,7)] |> as.data.frame()

# combine intervention groups
int <- rbind(qi, tai) |> as.data.frame()
# calculate change scores
int$d <- int[,2] - int[,1]
con$d <- con[,2] - con[,1]

# check mean and sd for change scores from forest plot:
# INT 0.18 (1.58), CON -0.4 (1.56)
mean(int$d)
sd(int$d)
mean(con$d)
sd(con$d)
# means match, but sd does not!

# maybe use some imputation instead
r_to_sdd(sd(int[,1]), sd(int[,2]), 0.65)
r_to_sdd(sd(con[,1]), sd(con[,2]), 0.65)
# no, does not work (at least not for the same r)

# try MD
metapp::md(mean(int$d), mean(con$d), sd(int$d), sd(con$d), nrow(int), nrow(con)) |> get_ci()
# ES correct, CI not, but this is not surprising, because the sds do not match

# try the sds given in the forest plot:
metapp::md(mean(int$d), mean(con$d), 1.58, 1.56, nrow(int), nrow(con)) |> get_ci()
# almost correct
# now with rounded means
metapp::md(round(mean(int$d),2), round(mean(con$d), 2), 1.58, 1.56, nrow(int), nrow(con)) |> get_ci()
# perfect match

# to investigate the data extraction and imputation procedure I take another
# study: Liu et al. 2011

# using data from Tab 2:
# mean change INT (0.1) matches forest plot (0.1)
# mean change CON (0.14) does not match forest plot (0.22)
# calculate sd of change from CIs of change
get_sd_from_ci <- function(lower, upper, n) {
  se <- (upper - lower)/(2* qt(0.975, n-1))
  se * sqrt(n)
}
get_sd_from_ci(-0.16, 0.35, 20)
# matches SD for INT (0.54)
get_sd_from_ci(0.05, 0.25, 21)
# does not match SD for CON (way off, 0.21 instead of 0.71)

# maybe the MA accidentally used the group difference as the control
# (because the mean almost matches)
get_sd_from_ci(-0.45, -0.01, 21)
# no

# check next one that is available 
# (I have much trouble finding available article texts)
# Tsang et al. 2008
# matches change score SD, but still no information on imputation

# check next one available:
# Lam et al. 2008
mean_int <- 8.1 - 8.4
mean_con <- 8.5 - 8.7
# matches
sd_int <- r_to_sdd(1.2, 1.4, r = 0.5)
sd_con <- r_to_sdd(1.3, 1.5, r = 0.5)
# matches both!
# So imputation of r = 0.5

# just as a double check, calculate the ES for this study
md(mean_int, mean_con, sd_int, sd_con, 24, 20) |> get_ci()

# perfect match

