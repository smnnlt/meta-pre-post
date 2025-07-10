# Recalculation of MA #159 (Sequi-Dominguez)

library(metapp)

# Study to recalculate: Bharath et al. 2018
# target ES: -0.1999 [-1.08, 0.68]

# using data from Tab 3 (baPWV)
n_con <- 20
n_int <- 20

mean_con_pre <- 8.3
se_con_pre <- 1
mean_con_post <- 8.4
se_con_post <- 1

mean_int_pre <- 8.5
se_int_pre <- 1.2
mean_int_post <- 8.4
se_int_post <- 1

# should be definitely change score based, because post score would give SMD = 0

# calculating change scores
mean_con_d <- mean_con_post - mean_con_pre
mean_int_d <- mean_int_post - mean_int_pre

# It is very likely that the MA authors mistook the SE values for the SD
# see also MA Tab S5, which shows the SE values labeled as "SD"

se_con_d <- r_to_sdd(se_con_pre, se_con_post, 0.5)
se_int_d <- r_to_sdd(se_int_pre, se_int_post, 0.5)
# These should be 1 when pooled to get an SMD of -0.2
# which is not the case here (maybe only post SE values were used?)

# calculate SMD
smd(mean_int_d, mean_con_d, se_int_d, se_con_d, n_int, n_con, hedges = FALSE) |> get_ci()
# ES point estimate near, CI far off

# maybe they used the incorrect n from the originals study table (n = 10)
smd(mean_int_d, mean_con_d, se_int_d, se_con_d, 10, 10, hedges = FALSE) |> get_ci()
# very close for ES and CI

# use post score SDs for standardization
o <- smd(mean_int_d, mean_con_d, se_int_post, se_con_post, 10, 10, hedges = FALSE) |> get_ci()
o
# perfect match, also for the reported SE, which was 0.4483
sqrt(o$var)

# try another study: Bruyndonckx et al. 2015
# target ES: -0.6832 [-1.27, -0.10]

# using data from Tab 1 PWV
# the data here is only given in median (interquartile range)
# so I first try to recalculate the baseline values given in MA Tab S5

# for the control group (PRE)
iqr_up <- 7.2
iqr_low <- 5.4
med <- 6.1

# assuming a normal distribution (following the Cochrane handbook)
(iqr_up - iqr_low)/1.35
# does not match the data in MA Tab S1 (0.4) or Tab S4 (2.1)

# using the formula from Wan et al. 2014
(iqr_up - iqr_low)/(2*qnorm((0.75*28-0.125)/(28+0.25)))
# also no match
# I am not able recalculate the SD values

# try next study: Son et al. 2017
# target ES: -1.4100 [-2.08, -0.74]

# data for baPWV are only presented in a plot (Fig 2) and would need to be
# extracted

# try next study: Wong et al. 2018
# target ES: -0.3882 [-1.11, 0.33]

# using data from Tab 3 baPWV
w_n_con <- 15
w_n_int <- 15

w_mean_con_pre <- 8.5
w_se_con_pre <- 0.7
w_mean_con_post <- 8.5
w_se_con_post <- 0.8
w_mean_int_pre <- 8.4
w_se_int_pre <- 0.8
w_mean_int_post <- 7.4
w_se_int_post <- 0.5

# calculate sd from se
w_sd_con_pre <- w_se_con_pre * sqrt(w_n_con)
w_sd_con_post <- w_se_con_post * sqrt(w_n_con)
w_sd_int_pre <- w_se_int_pre * sqrt(w_n_int)
w_sd_int_post <- w_se_int_post * sqrt(w_n_int)
# matches the data from MA Tab S5

# calculate change scores
w_mean_con_d <- w_mean_con_post - w_mean_con_pre
w_mean_int_d <- w_mean_int_post - w_mean_int_pre

w_sd_con_d <- r_to_sdd(w_sd_con_pre, w_sd_con_post, 0.5)
w_sd_int_d <- r_to_sdd(w_sd_int_pre, w_sd_int_post, 0.5)

# w_sd_con_d <- sd_avg(w_sd_con_pre, w_sd_con_post)
# w_sd_int_d <- sd_avg(w_sd_int_pre, w_sd_int_post)

# calculate SMD
smd(w_mean_int_d, w_mean_con_d, w_sd_int_d, w_sd_con_d, w_n_int, w_n_con, hedges = FALSE) |> get_ci()
# near, but no match

# use post score SD for standardization
smd(w_mean_int_d, w_mean_con_d, w_sd_int_post, w_sd_con_post, w_n_int, w_n_con, hedges = FALSE) |> get_ci()
# very near

# use rounded values
o2 <- smd(w_mean_int_d, w_mean_con_d, round(w_sd_int_post,1), round(w_sd_con_post,1), w_n_int, w_n_con, hedges = FALSE) |> get_ci()
o2
# perfect match
# also matches reported SE of 0.3686
sqrt(o2$var)
