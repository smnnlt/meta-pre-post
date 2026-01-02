# libs
library(metapp)

# Meta analysis: No 90.
# Original article: Figure 2 Study 8
# 
# Target: 0.7 [0.36, 1.05]

n_i <- 9
n_c <- 18
delta_i <- 2.33
sd_i <- 3.12
delta_c <- 0.08
sd_c <- 3.1
smd(delta_i, delta_c, sd_i, sd_c, n_i, n_c) |> get_ci()
ppc(delta_i, delta_c, sd_i, sd_c, n_i, n_c, 0.5) |> get_ci()

# The effect size can be reproduced but not the confidence interval.
