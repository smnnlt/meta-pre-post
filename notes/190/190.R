# Recalculation of MA #190 (Oliveira)

library(metapp)

# Study to recalculate: Bjerre et al. 2019
# target ES: -754.00 [-2298.57, 790.57]

# this study reports only change scores (Tab 2)
# from the Table it is clear that the adjusted between group comparison was
# used for data extraction, as it has a mean of -754

# The Table also provides a 95% CI, but it does not match the MA CI
ci_low <- -2316
ci_up <- 808

# recalculate CI using z instead of t-distribution
-754 + ((ci_up - ci_low)/qt(0.975, df = 175) * qnorm(0.975)/2)
# no match

# I'll try the next study: Pereira et al. 2020
# target ES: 557.00 [-428.98, 1542.98]

# using data from Results section (habitual PA)

# using data from Fig 1
n_int <- 41
n_con <- 26

# using data for habitual PA

mean_int_pre <- 3051
sd_int_pre <- 2834
mean_con_pre <- 2458
sd_con_pre <- 2364

mean_int_post <- 3038
sd_int_post <- 1936
mean_con_post <- 3002
sd_con_post <- 2685

# calculate change scores
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre

# calculate MD
# using pre score SD
md(mean_int_d, mean_con_d, sd_int_pre, sd_con_pre, n_int, n_con) |> get_ci()
# estimate matches (but wrong direction!), CI does not match

# try imputed change score SD (although this is not what the MA methods say)
md(mean_int_d, mean_con_d, r_to_sdd(sd_int_pre, sd_int_post, 0.7), r_to_sdd(sd_con_pre, sd_con_post, 0.7), n_int, n_con) |> get_ci()
# near but no match

# hm, try next study instead, but I have to use a different forest plot:
# using study 1 from forest plot MA Fig 3: Andersen et al. 2014
# target ES: 4.50 [-0.12, 9.12]

# using data from the abstract (FG as INT, CO as CON)
a_n_int <- 9
a_n_con <- 8

# using data from Tab 1 (maximal bicycle testing, oxygen uptake)
# note that SEM is presented
a_mean_int_pre <- 28.2
a_se_int_pre <- 2.1
a_mean_int_post <- 32.0
a_se_int_post <- 1.9

a_mean_con_pre <- 30.8
a_se_con_pre <- 1.2
a_mean_con_post <- 30.1
a_se_con_post <- 2.4

# calculate SD from SE
a_sd_int_pre <- a_se_int_pre * sqrt(a_n_int)
a_sd_int_post <- a_se_int_post * sqrt(a_n_int)
a_sd_con_pre <- a_se_con_pre * sqrt(a_n_con)
a_sd_con_post <- a_se_con_post * sqrt(a_n_con)
# calculate mean differences
a_mean_int_d <- a_mean_int_post - a_mean_int_pre
a_mean_con_d <- a_mean_con_post - a_mean_con_pre

# MD using pre SD
md(a_mean_int_d, a_mean_con_d, a_sd_int_pre, a_sd_con_pre, a_n_int, a_n_con) |> get_ci()
# ES point estimate match, CI near but not exact

# MD using post SD
md(a_mean_int_d, a_mean_con_d, a_sd_int_post, a_sd_con_post, a_n_int, a_n_con) |> get_ci()
# ES point estimate match, CI off

# I could not reproduce the CI for the MD ES

# Now I will try to reproduce the SMD ES as presented in forest plot MA Fig 4
# study to recalculate: Sundstrup et al. 2016
# target ES: 0.43 [-0.52, 1.37]

# IT is not clear to me which of the 6 strength measures reported in Tab 1 was 
# used for the MA
# I will just try the first (Concentric Q)

# by the way (and as indicated in MA Tab S1), the Sundstrup study reports 
# measures from the same trial as Anderson
# but the n for CON differs by 1
s_n_int <- 9
s_n_con <- 7

s_mean_int_pre <- 151
s_se_int_pre <- 7
s_mean_int_post <- 147
s_se_int_post <- 7

s_mean_con_pre <- 152
s_se_con_pre <- 7
s_mean_con_post <- 138
s_se_con_post <- 9

# calculate SD from SE
s_sd_int_pre <- s_se_int_pre * sqrt(s_n_int)
s_sd_int_post <- s_se_int_post * sqrt(s_n_int)
s_sd_con_pre <- s_se_con_pre * sqrt(s_n_con)
s_sd_con_post <- s_se_con_post * sqrt(s_n_con)
# calculate mean differences
s_mean_int_d <- s_mean_int_post - s_mean_int_pre
s_mean_con_d <- s_mean_con_post - s_mean_con_pre

# calculate SMD
smd(s_mean_int_d, s_mean_con_d, s_sd_int_post, s_sd_con_post, s_n_int, s_n_con) |> get_ci()
# try different variance estimator
smd(s_mean_int_d, s_mean_con_d, s_sd_int_post, s_sd_con_post, s_n_int, s_n_con, vartype = 2) |> get_ci()
# perfect match for CI, point estimate matches perfectly when incorrectly rounded

# I will try to verify for one last study: Uth et al. 2014
# target ES: 0.38 [-0.18, 0.93]

# using data from Tab 2 (1 RM)
# SMD with post score SD for standardization and vartype=2
smd(71.7-62.8, 73.9-71.7, 18.8, 16.0, 26, 23, vartype = 2) |> get_ci()
# perfect match
