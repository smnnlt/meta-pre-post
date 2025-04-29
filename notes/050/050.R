# Recalculation of MA #050 (Souta)

library(metapp)

# Study to recalculate: Bily et al. 2008
# target ES: -0.29 [-0.95, 0.37]

# okay I have no idea where the data in the forest plot is from
# Tab 2 and the results section of the text do not seem to fit

# okay, Sup S3 stated that the data was directly retrieved from the authors
# therefore we use a different ES

# so take the next ES
# study to recalculate: Jing et al. 2024
# target ES: -0.29 [-0.99, 0.42]

# taking data from Tab 2 (only post-intervention it seems):
mean_int <- 2.33
sd_int <- 0.69
n_int <- 18
mean_con <- 2.53
sd_con <- 0.67
n_con <- 14

# try default RevMan SMD
metapp::smd(mean_int, mean_con, sd_int, sd_con, n_int, n_con, vartype = 3, homo = FALSE) |> get_ci()

# perfect match!

# vartype = 1 gets similar results, vartype = 2 and hedges = FALSE not
