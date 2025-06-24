# Recalculation of MA #085 (Prince)

library(metapp)

# Study to recalculate: Zhou et al. 2019 (SPE + ASE)
# target ES: 23.17 [18.74, 27.60]

# using 20-m shuttle run (laps) data for SPE+ASE vs CON 
# Table 3 for pre values
mean_con_pre <- 38.09
sd_con_pre <- 14.59
mean_int_pre <- 39.00
sd_int_pre <- 15.75

# Table 4 for change scores
mean_con_d <- 3.52
mean_int_d <- 25.78

# calculate post score
mean_con_post <- mean_con_pre + mean_con_d
mean_int_post <- mean_int_pre + mean_int_d
# these match the mean data from the forest plot
# the sd data from the forest plot are the pre sd!

# using a MD with these values:
# n(CON) divided by 3 because of different arms included in the MA
# n(INT) has an extraction error: study says 168, but forest plot reports 180
md(mean_int_post, mean_con_post, sd_int_pre, sd_con_pre, 180, round(170/3)) |> get_ci()
# perfect match

# what happens if we use the correct sample size
md(mean_int_post, mean_con_post, sd_int_pre, sd_con_pre, 168, 170/3) |> get_ci()
# minor difference

# I'll take a look at the previous study from the forest plot just to see, 
# whether also pre sd were used there, or if this was just for Zhou because they
# did not report post sd
# Robinson et al. 1999
# checked: uses post intervention means and sd