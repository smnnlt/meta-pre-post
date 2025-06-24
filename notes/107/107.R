# Recalculation of MA #107 (Nolan)

library(metapp)

# Study to recalculate: Dalgaard et al. 2022
# target ES: 0.03 [-0.51, 0.58]

# the study has multiple measurements of muscle hypertrophy, which are combined
# for the ES in the forest plot.
# Instead I will look for a study from the forest plot which has only one 
# measure of hypertrophy. With the help of the published MA raw data, this is:

# Romance et al. 2019
# target ES: 0.02 [-0.62, 0.67]

# using data for FFM from Tab. 3
mean_con_pre <- 43.5
sd_con_pre <- 2.8
mean_con_post <- 44.2
sd_con_post <- 3.4
mean_int_pre <- 43
sd_int_pre <- 5.1
mean_int_post <- 44.4
sd_int_post <- 5.6

n_int <- 12
n_con <- 11

# Use ppc1 from Morris with variance estimator from Becker 1988 

ppc(
  mean_int_post - mean_int_pre, mean_con_post - mean_con_pre, 
  sd_int_pre, sd_con_pre, 
  n_int, n_con, 
  type = 1, r1 = 0.7, r2 = 0.7, var_becker = TRUE
) |> get_ci()
# perfect match!
