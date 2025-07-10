# Recalculation of MA #165 (Wood)

library(metapp)

# Study to recalculate: Kiens et al. 1980
# target ES: 0.130 [-0.012, 0.272]

# using data from Tab 2 (Apo A-I)

n_int <- 24
mean_int_pre <- 1.06
se_int_pre <- 0.04
mean_int_post <- 1.17
se_int_post <- 0.05

n_con <- 13
mean_con_pre <- 0.99
se_con_pre <- 0.05
mean_con_post <- 0.97
se_con_post <- 0.05

# calculate SD from SE
sd_int_pre <- se_int_pre * sqrt(n_int)
sd_int_post <- se_int_post * sqrt(n_int)
sd_con_pre <- se_con_pre * sqrt(n_con)
sd_con_post <- se_con_post * sqrt(n_con)

# calculate change scores and change score with imputed r = 0.5
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre

sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.5)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.5)

# calculate MD
md(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()
# point estimate matches, CI almost matches (off by 0.01)

# try another study to verify. This now needs to be from a different forest plot
# because the forest plot shows a cumulative meta-analysis, which means only the
# first ES displayed is an individual study ES. Also for some studies combined 
# measures are used, but for simplicity we only consider studies with one 
# outcome. Therefore the first study of the forest plot in MA Fig 4 is used:

# Hagan et al. 1986 (f)
# target ES: 0.000 [-1.140, 1.140]

# using data from Tab 5 (Cholesterol HDL-C)
# Timepoints: Pre vs Post; Groups: E (INT) vs C (CON)
h_mean_int_pre <- 3.6
h_mean_con_pre <- 4.1
h_sd_int_pre <- 0.9
h_sd_con_pre <- 1.7

h_mean_int_post <- 4.0
h_mean_con_post <- 4.5
h_sd_int_post <- 1.3
h_sd_con_post <- 1.6

# calculate change scores and change score with imputed r = 0.5
h_mean_int_d <- h_mean_int_post - h_mean_int_pre
h_mean_con_d <- h_mean_con_post - h_mean_con_pre

h_sd_int_d <- r_to_sdd(h_sd_int_pre, h_sd_int_post, 0.5)
h_sd_con_d <- r_to_sdd(h_sd_con_pre, h_sd_con_post, 0.5)

# using sample size data from the abstract
h_n_int <- 12
h_n_con <- 12
# matches data from MA forest plot

# calculate MD
md(h_mean_int_d, h_mean_con_d, h_sd_int_d, h_sd_con_d, h_n_int, h_n_con) |> get_ci()
# perfect match

# so maybe for the first ES there were minor rounding errors or an extraction 
# typo