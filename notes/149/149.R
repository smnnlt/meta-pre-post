# Recalculation of MA #149 (Edwards)

library(metapp)

# EDIT AFTER REVISITING: I tried two further studies and revisited the three
# already tested. For the two new studies, and for one old study when
# incorrectly using the SEM instead of the SD (and using a different sample
# size), I could perfectly recalculate the target ES with CI.

# Study to recalculate: Tew et al. 2019
# target ES: 2.500 [-2.406, 7.406] # var: 6.265

# using data from Tab 2 (peak oxygen uptake)

mean_int_pre <- 27.3
sd_int_pre <- 7.7
mean_int_post <- 29.7
sd_int_post <- 8.2

mean_con_pre <- 28.6
sd_con_pre <- 10.0
mean_con_post <- 28.5
sd_con_post <- 9.2

n_int <- 12 # see Fig 1
n_con <- 11

# calculate change scores and change score sd
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre

sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.5)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.5)

# try change score based MD
md(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con, var_homo = TRUE) |> get_ci()
# match for ES point estimate, no match for CI
# still cannot figure out where the differences come from (n_int = 13 also does
# not match)

# try next study: Thomsen et al. 2018
# target ES: 3.720 [2.288, 5.152]

# using data from Tab 2

# assuming 95% CIs
ci_to_sd <- function(ci_low, ci_high, n) {
  ci_len <- (ci_high - ci_low) / 2
  se <- ci_len / qt(0.975, n - 1)
  sd <- se * sqrt(n)
  sd
}

thom_n_con <- 29
thom_n_int <- 31

thom_mean_con <- 0.25
thom_mean_int <- 3.97
thom_sd_con <- ci_to_sd(-0.71, 1.20, thom_n_con)
thom_sd_int <- ci_to_sd(3.01, 4.93, thom_n_int)

md(thom_mean_int, thom_mean_con, thom_sd_int, thom_sd_con, thom_n_int, thom_n_con) |> get_ci()
# match for ES point estimate, bit off for CI
# probably because of the CI backcalculation procedure

# try next study: Tjonna et al. 2008
# target ES: 10.300 [8.284, 12.316] #var: 1.058

# using data from Tab 2:
# data given as mean and SE!
tj_mean_con_pre <- 32.3
tj_se_con_pre <- 3.4
tj_mean_con_post <- 33.7
tj_se_con_post <- 2.7

tj_mean_int_pre <- 33.6
tj_se_int_pre <- 2.5
tj_mean_int_post <- 45.3
tj_se_int_post <- 3.3

# using data from Fig 1:
# tj_n_int <- 11
# tj_n_con <- 9
# using baseline sample sizes instead
tj_n_int <- 12
tj_n_con <- 10

# calculate change scores
tj_mean_con_d <- tj_mean_con_post - tj_mean_con_pre
tj_mean_int_d <- tj_mean_int_post - tj_mean_int_pre

# incorrectly using SEM instead of SD!
# calculate change score sd 
tj_se_con_d <- r_to_sdd(tj_se_con_pre, tj_se_con_post, 0.7)
tj_se_int_d <- r_to_sdd(tj_se_int_pre, tj_se_int_post, 0.7)

md(tj_mean_int_d, tj_mean_con_d, tj_se_int_d, tj_se_con_d, tj_n_int, tj_n_con, var_homo = TRUE) |> get_ci()
# perfect match for var_homo = TRUE and r = 0.7

# further study: Trapp et al. (2008)
# target ES: 8.300 [7.196, 9.404] (var = 0.317)

# using data from Tab 1 (VO2peak (ml/kg/min); HIIE as INT, CONT as CON)
# data given as mean and SE!
trapp_mean_int_pre <- 28.8
trapp_se_int_pre <- 2.1
trapp_mean_int_post <- 36.4
trapp_se_int_post <- 2.5

trapp_mean_con_pre <- 31.4
trapp_se_con_pre <- 1.5
trapp_mean_con_post <- 30.7
trapp_se_con_post <- 1.6

# use baseline sample sizes (as given in the abstract)
# the correct post sample sizes are given in the 'Subjects' section of the text
# (shown as comments here)
trapp_n_int <- 15 # post measures: n = 11
trapp_n_con <- 15 # post measures: n = 15

# calculating change score
trapp_mean_int_d <- trapp_mean_int_post - trapp_mean_int_pre
trapp_mean_con_d <- trapp_mean_con_post - trapp_mean_con_pre

# calculate change score se/sd
# incorrectly using SE!
trapp_se_int_d <- r_to_sdd(trapp_se_int_pre, trapp_se_int_post, 0.7)
trapp_se_con_d <- r_to_sdd(trapp_se_con_pre, trapp_se_con_post, 0.7)

# calculate mean difference
md(trapp_mean_int_d, trapp_mean_con_d, trapp_se_int_d, trapp_se_con_d, trapp_n_int, trapp_n_con, var_homo = TRUE) |> get_ci()
# perfect match!

# last verification: Trilk et al. (2011)
# target ES: 3.000 [2.434, 3.566] (var: 0.083)

# using data from Tab 3 (VO2max (ml/kg/min); SIT as INT)
# data given as mean and SE!
trilk_mean_int_pre <- 21.6
trilk_se_int_pre <- 1.1
trilk_mean_int_post <- 24.5
trilk_se_int_post <- 1.1

trilk_mean_con_pre <- 20.5
trilk_se_con_pre <- 0.9
trilk_mean_con_post <- 20.4
trilk_se_con_post <- 0.8

# from the abstract, assuming equal sample sizes
trilk_n_int <- 14 
trilk_n_con <- 14

# calculating change score
trilk_mean_int_d <- trilk_mean_int_post - trilk_mean_int_pre
trilk_mean_con_d <- trilk_mean_con_post - trilk_mean_con_pre

# calculate change score se/sd
# incorrectly using SE!
trilk_se_int_d <- r_to_sdd(trilk_se_int_pre, trilk_se_int_post, 0.7)
trilk_se_con_d <- r_to_sdd(trilk_se_con_pre, trilk_se_con_post, 0.7)

# calculate mean difference
md(trilk_mean_int_d, trilk_mean_con_d, trilk_se_int_d, trilk_se_con_d, trilk_n_int, trilk_n_con, var_homo = TRUE) |> get_ci()
# perfect match!

# so overall, I had three perfect recalculation matches when using MD with
# var_homo = TRUE and an imputed correlation of 0.7. In all three cases the SE
# was mistaken for the SD and in two cases baseline sample sized were used
# instead of final sample sizes.
