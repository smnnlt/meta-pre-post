# Recalculation of MA #200 (Glänzel)

library(metapp)

# Study to recalculate: Griefahn et al. 2021
# target ES: 0.360 [-0.415, 1.135] 

# first, it was not really clear for me which groups and which parameters were used
# I tried a few combinations of data from Tab 2 but did not succeed.
# In the end, I could finally find out that the two studies from Griefahn et al.
# were mixed up in the forest plot

# so the actual target ES for this study was: 0.026 [-0.702, 0.754] [var: 0.138]

# using POST data from Tab 2 (Sliding TLF, FR vs CON)
mean_int <- 5.49
sd_int <- 2.73
mean_con <- 5.55
sd_con <- 1.82

# using data from Fig 1:
n_int <- 14
n_con <- 15

# calculate SMD (without correction) from post values
smd(mean_int, mean_con, sd_int, sd_con, n_int, n_con, hedges = FALSE) |> get_ci()
# perfect match, but wrong direction of effect
# (the CON group has larger POST values)


# I could only determine the confused ES, because I tried the other study:
# Griefahn et al. 2017
# target ES: 0.026 [-0.702, 0.754]

# actual target ES: 0.360 [-0.415, 1.135] [var: 0.156]

# using POST data from Tab 1 (Foam roll vs. Control)
g2_mean_int <- 5.987
g2_sd_int <- 2.3874
g2_mean_con <- 5.172
g2_sd_con <- 2.1572

# using sample size data from Fig 1
g2_n_int <- 13
g2_n_con <- 13

# calculate SMD
smd(g2_mean_int, g2_mean_con, g2_sd_int, g2_sd_con, g2_n_int, g2_n_con, hedges = FALSE) |> get_ci()
# very near, almost perfect match

# use rounded values (to two decimals)
smd(round(g2_mean_int,2), round(g2_mean_con,2), round(g2_sd_int,2), round(g2_sd_con,2), g2_n_int, g2_n_con, hedges = FALSE) |> get_ci()
# perfect match!
