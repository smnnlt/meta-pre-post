# Recalculation of MA #140 (Martínez-Calderon)

library(metapp)

# Study to recalculate: Gupta & Mamidi 2013
# target ES: -0.44 [-1.59, 0.70]

# using data from text section 
# "Effect of therapy based on total score of HARS"

mean_int <- 16.83
sd_int <- 9.66
mean_con <- 12.83
sd_con <- 6.76

n_int <- 6
n_con <- 6

smd(mean_int, mean_con, sd_int, sd_con, n_int, n_con) |> get_ci()
# perfect match, maybe wrong sign??

# This depends on whether the reported values are change scores or post score.
# If these are change score, the MA ES is correct, because INT reduced anxiety 
# more. If these are post scores, the sign is wrong, because INT has a higher 
# HARS score (thus more severe anxiety ratings)

# I will try another study to see if change scores or post scores were used.
# Since the only other study from the same forest plot could not be retrieved,
# I use the next forest plot (Fig 3), study 1, which is
# Buttner et al. 2015
# target ES: -0.46 [-1.03, 0.10]

# using POST data for IDAS-SA from Tab 2

smd(7.00, 8.44, 2.03, 3.73, 23, 27) |> get_ci()
# perfect match!
