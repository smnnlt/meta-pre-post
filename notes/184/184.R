# Recalculation of MA #184 (Thomas)

library(metapp)

# Study to recalculate: Moltubakk et al. 2021
# target ES: 

# I do not know which parameters should be used for the recalculation.
# Maybe the data in Fig 6A, but then which data there?
# Also probably would required to extract data from a plot, which is suboptimal

# I will try the next study instead: Minshull et al. 2014 (Static)
# target ES: 0.00 [-0.88, 0.88]

n <- 9

# using data from Tab 1 (PF (N), Intervention period, Passive)
mean_int_pre <- 329
sd_int_pre <- 77
mean_int_post <- 325
sd_int_post <- 75

mean_con_pre <- 321
sd_con_pre <- 64
mean_con_post <- 317
sd_con_post <- 69

# calculate mean changes
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre

# SMD using averaged SDs and vartype = 2 (as this should be the CMA default)
smd(mean_int_d, mean_con_d, mean(c(sd_int_pre, sd_int_post)), mean(c(sd_con_pre, sd_con_post)), n, n, vartype = 2) |> get_ci()
# perfect match

# but also try average SD with sd_avg()
smd(mean_int_d, mean_con_d, sd_avg(sd_int_pre, sd_int_post), sd_avg(sd_con_pre, sd_con_post), n, n, vartype = 2) |> get_ci()
# also perfect match

# this is a bit challenging to interpret, because the ES of 0.00 does not 
# allow to determine the correct standardizer for the ES
# maybe I should also go for the ES of the other group (PNF), which is:
# -0.15 [-1.04, 0.73]

# using data from Tab 1 (PF (N), Intervention period, PNF)

pnf_mean_int_pre <- 296
pnf_sd_int_pre <- 98
pnf_mean_int_post <- 288
pnf_sd_int_post <- 70

pnf_mean_con_pre <- 289
pnf_sd_con_pre <- 79
pnf_mean_con_post <- 294
pnf_sd_con_post <- 74

# calculate mean changes
pnf_mean_int_d <- pnf_mean_int_post - pnf_mean_int_pre
pnf_mean_con_d <- pnf_mean_con_post - pnf_mean_con_pre

# SMD using average of SDs
smd(pnf_mean_int_d, pnf_mean_con_d, mean(c(pnf_sd_int_pre, pnf_sd_int_post)), mean(c(pnf_sd_con_pre, pnf_sd_con_post)), n, n, vartype = 2) |> get_ci()
# perfect match

# SMD using sd_avg()
smd(pnf_mean_int_d, pnf_mean_con_d, sd_avg(pnf_sd_int_pre, pnf_sd_int_post), sd_avg(pnf_sd_con_pre, pnf_sd_con_post), n, n, vartype = 2) |> get_ci()
# almost perfect match, lower CI off by 0.01

# so it is very likely that the average of the pre-post sd was used for the 
# calculations

r_to_sdd(70, 80, 0.5)

