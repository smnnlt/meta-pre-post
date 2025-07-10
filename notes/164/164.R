# Recalculation of MA #164 (Fernández-Landa)

library(metapp)

# Study to recalculate: Nelson et al. 2000
# target ES: -0.16 [-0.67, 0.35]

# using data from Results section ("Maximal values")
mean_int_pre <- 3.41
sd_int_pre <- 0.68
mean_con_pre <- 3.69
sd_con_pre <- 1.06

mean_int_post <- 3.33
sd_int_post <- 0.72
mean_con_post <- 3.74
sd_con_post <- 1.07

# calculate change scores and change score with imputed r = 0.7
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre

sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.7)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.7)

# use sample sizes from abstract
n_int <- 19
n_con <- 17

smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()
# ES point estimate slightly off, CI off

# in the second study I got a match for PPC type 1 with var_becker = TRUE
# so I now also try this for the first study:
ppc(mean_int_d, mean_con_d, sd_int_pre, sd_con_pre, n_int, n_con, r1 = 0.7, r2 = 0.7, type = 1, var_becker = TRUE) |> get_ci()
# perfect match!

# try next study: Ostojic 2004
# target ES: -0.43 [-1.15, 0.29]

o_n_int <- 10
o_mean_int_pre <- 684.8
o_mean_int_post <- 654.1
o_sd_int_pre <- 51.2
o_sd_int_post <- 45.5

o_n_con <- 10
o_mean_con_pre <- 672.9
o_mean_con_post <- 666.8
o_sd_con_pre <- 47.6
o_sd_con_post <- 58.3

# calculate change scores and change score with imputed r = 0.7
o_mean_int_d <- o_mean_int_post - o_mean_int_pre
o_mean_con_d <- o_mean_con_post - o_mean_con_pre

o_sd_int_d <- r_to_sdd(o_sd_int_pre, o_sd_int_post, 0.7)
o_sd_con_d <- r_to_sdd(o_sd_con_pre, o_sd_con_post, 0.7)

smd(o_mean_int_d, o_mean_con_d, o_sd_int_d, o_sd_con_d, o_n_int, o_n_con) |> get_ci()
# no match

# use pooled sd
smd(o_mean_int_d, o_mean_con_d, sd_avg(o_sd_int_pre, o_sd_int_post), sd_avg(o_sd_con_pre, o_sd_con_post), o_n_int, o_n_con) |> get_ci()
# use pre sd
smd(o_mean_int_d, o_mean_con_d, o_sd_int_pre, o_sd_con_pre, o_n_int, o_n_con) |> get_ci()
# use Morris 2008
ppc(o_mean_int_d, o_mean_con_d, o_sd_int_pre, o_sd_con_pre, o_n_int, o_n_con, r1 = 0.7, r2 = 0.7, type = 1, var_becker = TRUE) |> get_ci()
# okay, so PPC type 1 with Becker variance would perfectly match!

# so I tried it for the first study, and also got a perfect match!
