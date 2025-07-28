#Recalculation of MA Oliver
#Selected Study: Negra et al. 2020 
#target ES:
#Hedges g : -0.19 [-1.00; 0.62], SE: 0.411
#reported method: 
#change score based, post scores used as standardizer, Hedges g correction 
library(metapp)
n <- 11
#control group
pre_cg <- 83.82
post_cg <- 91.45
x2 <- post_cg - pre_cg
sd2 <- 15.39
sd_pre_cg <- 18.34
sd_post_cg <- 15.39


#plyometric training group 
pre_ptg <- 86.18
post_ptg <- 89.82
x1 <- post_ptg - pre_ptg
sd1 <- 24.14
sd_pre_ptg <- 3.67
sd_post_ptg <- 24.14

smd(x1, x2, sd1, sd2, n, n, hedges = TRUE, homo = FALSE, exact = TRUE) |> get_ci()
#very close: ES -0.19 [-1.03; 0.65]

smd(3.6, 7.7, 24.1, 15.4, n, n, hedges = TRUE, homo = FALSE, exact = TRUE) |> get_ci()
#try with rounding- very again, close: ES -0.20 [-1.03; 0.64]

smd(x1, x2, sd1, sd2, n, n, hedges = TRUE, homo = TRUE, exact = FALSE) |> get_ci()
#again, very close: ES -0.19 [-1.03; 0.65]

smd(x1, x2, sd1, sd2, n, n, hedges = TRUE, homo = FALSE, exact = FALSE) |> get_ci()
#again, close: ES -0.20 [-1.03; 0.64]

smd(x1, x2, sd1, sd2, n, n, hedges = TRUE, homo = TRUE, exact = TRUE) |> get_ci()
#again, close: ES -0.20 [-1.03; 0.64]


#try with avg sd 
sd_avg_cg <- sd_avg(sd1 = sd_pre_cg, sd2 = sd_post_cg)
sd_avg_ptg <- sd_avg(sd1 = sd_pre_ptg, sd2 = sd_post_ptg)

smd(x1, x2, sd_avg_ptg, sd_avg_cg, n, n, hedges = TRUE, homo = FALSE, exact = TRUE) |> get_ci()
#no, ES -0.22 [-1.06; 0.62]

