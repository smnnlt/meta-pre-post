# Recalculation of MA #183 (Moore)

library(metapp)

# Study to recalculate: Wilson et al. 2019
# target ES: -0.76 [-1.72, 0.21]
# exact values taken from Tab S3: ES [var] 0.757037697 [0.241380639]

# using data from Tab 1
n_con <- 8
n_int <- 8

# using data from Tab 2 (DOMS B-24h)
# CWI as CON and WBC as INT
# mean changes are given
mean_con <- 3.75
mean_int <- 0.63

# recalculate sd from the given 90% CI:
sd_con <- (1.4 / qt(0.95, df = n_con - 1)) * sqrt(n_con)
sd_int <- (2.1 / qt(0.95, df = n_int - 1)) * sqrt(n_int)

# calculate SMD
smd(mean_int, mean_con, sd_int, sd_con, n_int, n_con)
# no match

# try next study: Wiewelhove et al. 2018
# target ES: -0.17 [-0.99, 0.66]
# exact values: ES [var] 0.168550797 [0.176618232]

# using data from Tab 1 (CWI as CON, MAS as INT)
w_n_con <- 11
w_n_int <- 10

# using data from Tab 3 (DOMS, Post24)
w_mean_con <- 3.8
w_sd_con <- 2.8
w_mean_int <- 3.3
w_sd_int <- 2.9

# calculate SMD based on post scores
smd(w_mean_int, w_mean_con, w_sd_int, w_sd_con, w_n_int, w_n_con, exact = FALSE) |> get_ci()
# perfect match for ES point estimate, near for SE and CI

# using vartype = 2
smd(w_mean_int, w_mean_con, w_sd_int, w_sd_con, w_n_int, w_n_con, exact = FALSE, vartype = 2) |> get_ci()
# perfect match

# so interestingly the Borenstein variance estimator was used (vartype = 2 for 
# {metapp}, vartype = "LS2" for {metafor}), which is not the metafor standard 