# Recalculation of MA #186 (Monserdà-Vilaró)

library(metapp)

# Study to recalculate: Irving et al. 2015 (old)
# target ES: 0.13 [-0.71, 97]

# the study only present baseline and percentage change data
# using baseline data from Tab 1 (Midthigh skeletal muscle, Older, CT vs RT)
# (data is given as mean +- SEM)

n_int <- 9 # group size is 10 but only 9 measured
mean_int_pre <- 230
se_int_pre <- 21

n_con <- 10
mean_con_pre <- 242
se_con_pre <- 15

# calculate sd from se
sd_int_pre <- se_int_pre * sqrt(n_int)
sd_con_pre <- se_con_pre * sqrt(n_con)

# matches pre data from MA Tab 4

# using the percentage change data from Tab 2 (Midthigh skeletal muscle, Older, CT vs RT)
mean_con_pc <- 5.6
mean_int_pc <- 5.1

# calculate post means
mean_int_post <- mean_int_pre * (1 + mean_int_pc / 100)
mean_con_post <- mean_con_pre * (1 + mean_con_pc / 100)

# matches post means from MA Tab 4

# calculate post sds
# using the SE of the percentage change
sem_con_pc <- 3.4
sem_int_pc <- 2.8
# calculate SD
sd_con_pc <- sem_con_pc * sqrt(n_con)
sd_int_pc <- sem_int_pc * sqrt(n_int)
# calculate as percentage of post means
sd_con_post <- mean_con_post*(sd_con_pc / 100)
sd_int_post <- mean_int_post*(sd_int_pc / 100)

# matches the post SD data from MA Tab 4

# this is not an appropriate procedure to calculate post score SDs
# but since it matches the extracted MA data, I will continue

# calculate mean changes
mean_con_d <- mean_con_post - mean_con_pre
mean_int_d <- mean_int_post - mean_int_pre

# does not match the MA forest plot data (Fig 2)
# It seems that the MA mixed up the old and young group of the study in the 
# forest plot, because the (young) matches the data with one rounding error
# so I'll now try to recalculate that ES instead:
# target ES: 0.04 [-0.86, 0.94]

# calculate change score SD with imputed r = 0.5
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.5)
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.5)
# almost perfect match (slight rounding error for sd_con_d by 0.1)

# now recalculate the SMD:
smd(mean_con_d, mean_int_d, sd_con_d, sd_int_d, n_con, n_int) |> get_ci()
# perfect match!
# but cannot verify variance estimator or hedges correction

# try another study: Ronnestad et al. 2012 (CSA knee flexor)
# target ES: 0.15 [-0.80, 1.10]

# using sample size from abstract:
r_n_int <- 11
r_n_con <- 7  # incorrect in MA Tab 4, but correct in MA forest plot

# other data would need to be extracted from Figures (Fig. 3)
# but here the goal is only to verify the hedges correction and var estimator,
# so I will not redo the extraction, but use the extracted data presented in the
# MA

# I tried to do a quick visual check but could not match the data.

# using the data presented in MA Tab 4:

r_mean_int_pre <- 52.8
r_sd_int_pre <- 19.7
r_mean_int_post <- 59.6
r_sd_int_post <- 20.2

r_mean_con_pre <- 51.7
r_sd_con_pre <- 18.5
r_mean_con_post <- 61.6
r_sd_con_post <- 20.9

r_mean_int_d <- r_mean_int_post - r_mean_int_pre
r_mean_con_d <- r_mean_con_post - r_mean_con_pre
r_sd_int_d <- r_to_sdd(r_sd_int_pre, r_sd_int_post, 0.5)
r_sd_con_d <- r_to_sdd(r_sd_con_pre, r_sd_con_post, 0.5)
# matches forest plot data (with incorrect rounding)

smd(r_mean_con_d, r_mean_int_d, r_sd_con_d, r_sd_int_d, r_n_con, r_n_int) |> get_ci()
# hedges=TRUE verified
# vartype=1 or vartype=3 possible

