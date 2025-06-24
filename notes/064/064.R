# Recalculation of MA #064 (Ramos-Campo)

library(metapp)

# Study to recalculate: Thomas & Burns 2016
# target ES: 3.27 [-1.54, 8.08]

# mean and sd of change scores is presented in the text:
mean_int_d <- 9.07
sd_int_d <- 6.33
mean_con_d <- 5.8
sd_con_d <- 4.26
n_int <- 10
n_con <- 9

# calculate MD
md(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()
# perfect match

# use the next ES to determine the imputation procedure:
# Zaroni et al. 2019
# target ES: 1.60 [-19.37, 22.57]
# means match the change scores for 1RM Bench
# for example for the TOTAL (FB) group
113.5 - 104.2 # matches mean FB
# match sd
r_to_sdd(17.6, 19.3, 0) # assuming r = 0 matches sd
r_to_sdd(13.5, 12.9, 0) # also match
# just to make it complete, calculate ES
md(113.5-104.2, 100.9-93.2, r_to_sdd(17.6, 19.3, 0), r_to_sdd(13.5, 12.9, 0), 9, 9) |> get_ci()
# almost perfect
# incorrect rounding of sd
md(113.5-104.2, 100.9-93.2, 26.11, r_to_sdd(13.5, 12.9, 0), 9, 9) |> get_ci()
# perfect match