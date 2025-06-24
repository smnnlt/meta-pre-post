# Recalculation of MA #087 (Hassett)

library(metapp)

# Study to recalculate: Van Puymbroeck et 2018
# target ES: 0.68 [-0.10, 1.46]

# effect on mobility: using Mini-BESTest data from Tab. 3
# using post scores
mean_int_post <- 24.87
sd_int_post <- 7.79
mean_con_post <- 19.92
sd_con_post <- 6.22
n_int <- 15
n_con <- 12
# matches rounded values from forest plot
# it is interesting to note that the pre values also differ between both groups

# calculate SMD (Hedges' g) with RevMan default
smd(mean_int_post, mean_con_post, sd_int_post, sd_con_post, n_int, n_con, vartype = 3) |> get_ci()
# almost match

# try rounded values
smd(
  round(mean_int_post,1), round(mean_con_post, 1), 
  round(sd_int_post, 1), round(sd_con_post, 1)
  , n_int, n_con, vartype = 3
) |> 
  get_ci()
# perfect match!