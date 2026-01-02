# Recalculation of MA #149 (Edwards)

library(metapp)

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
md(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()
# match for ES point estimate, no match for CI

# try pre score standardization
md(mean_int_d, mean_con_d, sd_int_pre, sd_con_pre, n_int, n_con) |> get_ci()
# no match for CI

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

# try next study: Tjonna et al. 2008
# target ES: 10.300 [8.284, 12.316] #var: 1.058

# using data from Tab 2:

tj_mean_con_pre <- 32.3
tj_se_con_pre <- 3.4
tj_mean_con_post <- 33.7
tj_se_con_post <- 2.7

tj_mean_int_pre <- 33.6
tj_se_int_pre <- 2.5
tj_mean_int_post <- 45.3
tj_se_int_post <- 3.3

# using data from Fig 1:
tj_n_int <- 11
tj_n_con <- 9

# calculate SD from SE:
tj_sd_con_pre <- tj_se_con_pre * sqrt(tj_n_con)
tj_sd_con_post <- tj_se_con_post * sqrt(tj_n_con)

tj_sd_int_pre <- tj_se_int_pre * sqrt(tj_n_int)
tj_sd_int_post <- tj_se_int_post * sqrt(tj_n_int)

# calculate change scores
tj_mean_con_d <- tj_mean_con_post - tj_mean_con_pre
tj_mean_int_d <- tj_mean_int_post - tj_mean_int_pre

# calculate change score sd 
tj_sd_con_d <- r_to_sdd(tj_sd_con_pre, tj_sd_con_post, 1)
tj_sd_int_d <- r_to_sdd(tj_sd_int_pre, tj_sd_int_post, 1)

md(tj_mean_int_d, tj_mean_con_d, tj_sd_int_d, tj_sd_con_d, tj_n_int, tj_n_con) |> get_ci()
# match for ES point estimate, CI only near (but not exact) if assuming r = 1
