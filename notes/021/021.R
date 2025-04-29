# Recalculation of MA #021 (Opazo-Díaz)

library(metapp)

# Study to recalculate: Banitalebi et al. 2019
# target ES: 7.54 [3.14, 11.94]

# hm okay, contrary to MA Tab 3, Banitalebi did not measure VO2peak, or at 
# least did not write this in their article

# take the next ES instead
# more than one study matches despite Tab S1 stating n = 1

# take the previous ES instead
# more than one study matches despite Tab S1 stating n = 1

# take the previous ES instead
# back to Banitalebi et al. 2019, but now HbA1c
# target ES: -1.30 [-2.18, -0.42]

# taking the data from Tab 4
mean_int_post <- 7.82
sd_int_post <- 0.93
mean_con_post <- 9.1
sd_con_post <- 1.41
n_int <- 14
n_con <- 14

metapp::md(mean_int_post, mean_con_post, sd_int_post, sd_con_post, n_int, n_con) |> get_ci()
# slightly of for ES and CI
# use rounding
metapp::md(7.8, 9.1, sd_int_post, sd_con_post, n_int, n_con) |> get_ci()
# perfect match

