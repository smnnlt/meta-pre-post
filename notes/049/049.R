# Recalculation of MA #049 (De Lemos Muller)

library(metapp)

# Study to recalculate: Kim et al. 2016 (study before could not be be retrieved)
# target ES: 0.13 [-0.73, 0.99]

# okay, I took a look at Tab 3 which has the 1RM values
# first it is not clear which group acts as control (CON or VI)
# second it is not clear which of the dynamic 1RM measures is used
# (extension or flexion)

# looking at the table it seems as if the extension values were compared between
# VI and LI-BFR

mean_con_pre <- 101.3
sd_con_pre <- 16.2
mean_con_post <- 106.1
sd_con_post <- 15.5
n_con <- 10

mean_int_pre <- 107.6
sd_int_pre <- 23.4
mean_int_post <- 114.0
sd_int_post <- 26.3
n_int <- 11

# calculate mean changes
mean_con_d <- mean_con_post - mean_con_pre
mean_int_d <- mean_int_post - mean_int_pre

# calculate sd of change scores
# unclear imputation, I just try it out
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.87)
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.84)

# hm, I dont know why different values for r are used here

# nevertheless try to recalculate the ES and come back to the imputation issus
# later (try RevMan default SMD)

metapp::smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()

# perfect match!

# vartype = 2 and hedges = FALSE get different results, vartype = 1 similar

# now back to the imputation question. I select the ES before (de Oliveira 2012b)
# Tab 3 (BFR vs LOW for Strength)
# I only try the imputation stage

# BFR (should be 53.17)
r_to_sdd(97, 89, 0.84)
# LOW (should be 50.35)
r_to_sdd(102, 91, 0.87)

# verify for Oliveira 2012a (which is HIT vs HIT+BFR)
# HIT (should be 51.82)
r_to_sdd(104, 83, 0.87)
# HIT + BFR (should be 61.06)
r_to_sdd(112, 100, 0.84)

# okay so it is clear that r = 0.87 is imputed for the intervention group 
# and r = 0.84 for the control group

# now I try to find out if this is anywhere in the Behringer paper that is 
# referenced for imputation

# use Tab 2: change score mean [95% CI] for CON (n = 12)
# 0.3 [-0.2, 0.6]

# back-calculate sd of change scores
b_sd_con <- (0.3 / qt(0.975, 11)) * sqrt(12)
sdd_to_r(1.4, 1.3, b_sd_con)

# for INT (n = 12): 0.5 [0.03 to 1.0]
b_sd_int <- (0.47 / qt(0.975, 11)) * sqrt(12)
sdd_to_r(1.6, 1.6, b_sd_int)
