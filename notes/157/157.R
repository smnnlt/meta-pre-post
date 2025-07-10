# Recalculation of MA #157 (Correia)

library(metapp)

# Study to recalculate: Cornette et al. 2016
# target ES: 0.848 [0.101, 1.595]

# using data from Tab 2 (VO2peak)
mean_int_pre <- 22.5
mean_con_pre <- 23.4
sd_int_pre <- 4.4
sd_con_pre <- 5.1

# intervention endpoint data (T1)
mean_int_post <- 24.4
mean_con_post <- 22.1
sd_int_post <- 4.9
sd_con_post <- 5

# data from Fig 1 (using final n instead of T1 n)
n_int <- 15
n_con <- 15

# calculate change scores and change score sd
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre

sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.7)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.7)

smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con, hedges = FALSE) |> get_ci()
# perfect match

# Slightly incorrect n and no Hedges' correction is a bit unusual, so I try to 
# verify with another study: Moller et al. 2015
# target ES: -0.385 [-1.270, 0.499]

# using data from Tab 6 VO2peak/BW (Breast) 

# INT: LOW PED
mol_mean_int_pre <- 27.1
mol_sd_int_pre <- 6.4
mol_mean_int_post <- 22.4
mol_sd_int_post <- 6.5

# CON: Control
mol_mean_con_pre <- 30.5
mol_sd_con_pre <- 5.0
mol_mean_con_post <- 27.7
mol_sd_con_post <- 6.8

# using endpoint n
mol_n_int <- 10
mol_n_con <- 10

# calculate change scores and change score sd
mol_mean_int_d <- mol_mean_int_post - mol_mean_int_pre
mol_mean_con_d <- mol_mean_con_post - mol_mean_con_pre

mol_sd_int_d <- r_to_sdd(mol_sd_int_pre, mol_sd_int_post, 0.7)
mol_sd_con_d <- r_to_sdd(mol_sd_con_pre, mol_sd_con_post, 0.7)

# calculate SMD based on change score without Hedges' correction
smd(mol_mean_int_d, mol_mean_con_d, mol_sd_int_d, mol_sd_con_d, mol_n_int, mol_n_con, hedges = FALSE) |> get_ci()
# perfect match