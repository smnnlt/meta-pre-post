# recalculation of MA #038 (Deng)

library(metapp)

# study to recalculate: Sardeli et al. 2022
# target ES is 0.36 [-0.23; 0.94]

# taking the SDNN data from Tab 5
# I first try to use a post-score method only
# assuming that the last time point (W16) is post

n_int <- 23
n_con <- 23

mean_int_post <- 35
sd_int_post <- 18
mean_con_post <- 29
sd_con_post <- 15

# the forest plot states that a MD was used
metapp::md(mean_int_post, mean_con_post, sd_int_post, sd_con_post, n_int, n_con)

# which of course cannot be true

# try SMD instead
metapp::smd(mean_int_post, mean_con_post, sd_int_post, sd_con_post, n_int, n_con) |> get_ci()

# perfect match (using standard parameters)
# hedged=FALSE would be slightly deviating, homo=FALSE would also match
# vartype=1 and 3 both match
