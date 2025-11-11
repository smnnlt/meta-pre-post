# Recalculation of MA #119 (Singh)

library(metapp)

# Study to recalculate: Cochrane 2013
# target ES: 0.07 [-0.64, 0.78]

# using POST data for RAT from Tab 1

mean_int <- 1.91
mean_con <- 1.92
sd_int <- 0.11
sd_con <- 0.14
n <- 8

smcr(mean_int, mean_con, sd_int, sd_con, n, 0.5) |> get_ci(df = 7)
# point estimate matches perfectly, CI not

# back calculate SE from online calculator CI output
((0.62-(-0.78))*0.5)/abs(qnorm(0.025))
# rounded value matches SE in forest plot

# I use the data with the online calculator referenced in the MA, available at
# https://effect-size-calculator.herokuapp.com/#paired-samples-t-test
# this almost matches the CI. I try to reproduce the formula later, but first
# verify if I get an exact match with the online calculator for the next study

# Next: Dann et al 2023
# target ES: 0.97 [0.30, 1.64]

# okay this is extremely challenging to reproduce because we have three
# conditions and two timepoints (4 + 8 min) that are potentially used for the ES

# I will analyze the next study instead: Maloney et al. 2014
# target ES: 0.70 [-0.10, 1.50]

# data needs to be extracted from plots
# use next study instead: Moreno-Perez et al. 2021
# target ES: 0.27 [-0.14, 0.68]

mp_sd_int <- 0.16
mp_sd_con <- 0.11
mp_mean_int <- 2.68
mp_mean_con <- 2.72
mp_n <- 26
mp_r <- 0.5

# try to reproduce the values from the online calculator

# hedges average
(mp_mean_int - mp_mean_con)/sd_avg(mp_sd_int, mp_sd_con) * j(mp_n-1, exact = FALSE)
smcr(mp_mean_int, mp_mean_con, mp_sd_int, mp_sd_con, mp_n, 0.5, exact = FALSE) |> get_ci(df = 25)
# perfect match

# using non-corrected version for CI
smcr(mp_mean_int, mp_mean_con, mp_sd_int, mp_sd_con, mp_n, 0.5, hedges = FALSE) |> get_ci(df = 25)
# very near match (off only 0.01 on one side)

# hedges repeated measures
hrm <- ((mp_mean_int - mp_mean_con)/(r_to_sdd(mp_sd_int, mp_sd_con, mp_r)))*sqrt(2*(1-mp_r)) * j(mp_n-1, exact = FALSE)
hrm
# perfect match!

# back calculate SE from online calculator CI output
((0.12-(-0.69))*0.5)/abs(qnorm(0.025))
# rounded value matches SE in forest plot

# using the ES and SE data from the forest plot
o$es <- 0.27
o$var <- 0.21^2
o |> get_ci()
# perfect match

# So considering some level of (intermediate) rounding, the forest plot values
# can be recalculated by first using the online calculator to determine the ES and
# SE using a within-group SMD approach to the post-score between-group data.
# Then the rounded ES and SE is used to calculate the forest plot including CIs