# Recalculation of MA #180 (O'Riordan)

library(metapp)

# the random number generator of the project website did not work for this MA,
# so I used this R code instead:
set.seed(4711)
sample(1:22, 1)

# Study to recalculate: O'Riordan et al. 2023 (thigh/tight)
# target ES: 0.59 [-0.02, 1.19]

# this seems to be a cross-over study without pre-measurements for each 
# condition

# using data from Tab S1 (row Thigh Calf muscle blood flow)
# Tights (INT) vs CON
# note that the INT column gives the delta to CON, not the absolute values
smd(0.15, 0.19, 0.5, 0.03, 22, 22)
# far off
# there may be a data error in the SD of CON
# also we cannot for sure know the SD of INT, because we only have the SD of 
# CON and delta
# also the MA author may have simply used the raw data for calculation, because 
# it is his study

# I'll just try the next study: Riexinger et al. 2021
# data would need to be extracted from figures

# next study: Smale et al. 2018
# data would need to be extracted from a figure

# next study: Sperlich et al. 2013
# target ES: -0.53 [-1.69, 0.63]

# using data from Tab 3 blood flow
# use the mean of both measurements (deep and superficial)

mean_int <- mean(c(1.2, 1.5))
mean_con <- mean(c(1.4, 2.0))
sd_int <- sd_avg(0.4, 0.6)
sd_con <- sd_avg(0.6, 0.9)
n <- 6

# calculate SMD without Hedges' correction
smd(mean_int, mean_con, sd_int, sd_con, n, n, hedges = FALSE) |> get_ci()
# very near match (ES point estimate 0.01 off, CI upper 0.02 off)
# but the next study recalculation proved that Hedges = TRUE and vartype = 3
# were the default settings, so:
smd(mean_int, mean_con, sd_int, sd_con, n, n, vartype = 3) |> get_ci()
# slightly off

# maybe use combined group sds instead
int <- metapp::pool_groups(1.2, 1.5, 0.4, 0.6, 6, 6)
con <- metapp::pool_groups(1.4, 2.0, 0.6, 0.9, 6, 6)
smd(int$x, con$x, int$sd, con$sd, n, n, vartype = 3) |> get_ci()
# slightly off


# try next study: Venckunas et al. 2014
# target ES: -1.20 [-2.05, -0.36]

# using data from Tab 4 (Baseline, Arterial Blood Flow)
v_mean_con <- 4.56
v_sd_con <- 1.06
v_mean_int <- 3.01
v_sd_int <- 1.41
v_n <- 13

# calculate SMD with RevMan variance estimator
smd(v_mean_int, v_mean_con, v_sd_int, v_sd_con, v_n, v_n, vartype = 3) |> get_ci()
# perfect match

# now I'll try to recalculate the Sperlich study
# (didn't really work)
