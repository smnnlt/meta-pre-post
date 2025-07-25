# Recalculation of MA #198 (Marques)

library(metapp)

# Study to recalculate: Correa et al. 2014
# target ES: -0.03 [-0.85, 0.79]

# the data need to be extracted from Fig 1, but the figure shows no SD

# this is also indicated by the MA Tab S1, but the study is nonetheless used 
# for calculating an ES, even with no SD available.

# just out of curiosity I try to recalculate the values given the extracted
# mean data reported in MA Tab S1
smd(36.1-26.0, 35.6-25.0, 15, 15, 11, 12) |> get_ci()
# so the MA authors used imputed SDs of around 15. The authors say they used
# the RevMan Calculator to calculate missing SDs, but I do not know how this 
# should work in this case

# but for the recalculation I need a study that does present data. 
# try the next: Radaelli et al. 2014
# target ES: 0.19 [-0.57, 0.95]

# using data from Tab 1 (Knee-extension 1-RM)
n_con <- 14
mean_con_pre <- 49.5
mean_con_post <- 56.5
sd_con_pre <- 16.4
sd_con_post <- 15.5

n_int <- 13
mean_int_pre <- 50.8
mean_int_post <- 60.3
sd_int_pre <- 16.4
sd_int_post <- 17.8
# matches data from MA Tab S1

# calculate mean change and change score sd using r = 0.7
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre

sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.7)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.7)

# calculating SMD (with RevMan default vartype = 3)
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con, vartype = 3) |> get_ci()
# perfect match

# in theory could also be vartype=1 in this case because it makes no difference:
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con, vartype = 1) |> get_ci()
