# recalculation for MA #024 (Smart)

library(metapp)

# study to recalculate is Eguchi et al. 2012 (interval)
# target ES: -2.000 [-32.041, 28.041] (provided by the authors)
((28.041-(-32.041))*0.5)/abs(qnorm(0.025)) # recalculate SE

# using data from Table 2 T-Cho
# INT (TSIE group)
mean_int_pre <- 206.6
mean_int_post <- 203.8
sd_int_pre <- 27.8
sd_int_post <- 24.8
n_int <- 10
# CON (NE group)
mean_con_pre <- 219.3
mean_con_post <- 218.4
sd_con_pre <- 30.4
sd_con_post <- 34.3
n_con <- 10

# change scores
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.5)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.5)

# correcting for multiple use of control group
md(mean_int_d - 0.1, mean_con_d, sd_int_d, sd_con_d, n_int, 0.5 * n_con) |> get_ci()
md(mean_int_d - 0.1, mean_con_d, sd_int_post, sd_con_post, n_int, 0.5 * n_con) |> get_ci()

# Eguchi continuous -9.000 [-37.682, 19.682]
md(214.3-225.4, 218.4-219.3, r_to_sdd(21.1,26.9,0.5), r_to_sdd(30.4,34.3,0.5),8,0.5*n_con) |> get_ci()

# next try: Elliott et al. (2002)
# target ES: -11.000 [-65.225, 43.225]

# using data from Table 2 (TC, baseline, after training)
# conversion from mmol/l to mg/dl, using the same formula as the cited online 
# converter
cv <- 38.67
el_mean_int_pre <- 6.94 * cv 
el_sd_int_pre <- 1.66 * cv
el_mean_int_post <- 6.50 * cv
el_sd_int_post <- 1.22 * cv
el_mean_con_pre <- 6.62 * cv
el_sd_con_pre <- 1.21 * cv
el_mean_con_post <- 6.77 * cv
el_sd_con_post <- 1.37 * cv
# using sample size from abstract
el_n_int <- 8
el_n_con <- 7

# calculate change scores
el_mean_int_d <- el_mean_int_post - el_mean_int_pre
el_mean_con_d <- el_mean_con_post - el_mean_con_pre
el_sd_int_d <- r_to_sdd(el_sd_int_pre, el_sd_int_post, 0.5)
el_sd_con_d <- r_to_sdd(el_sd_con_pre, el_sd_con_post, 0.5)

md(el_mean_int_d, el_mean_con_d, el_sd_int_d, el_sd_con_d, el_n_int, el_n_con) |> get_ci()
# no match
md(el_mean_int_d, -el_mean_con_d-0.31, el_sd_int_d, el_sd_con_d, el_n_int, el_n_con) |> get_ci()
# very near match if the control mean difference has the wrong sign

# back calculate SE
((43.225-(-65.225))*0.5)/abs(qnorm(0.025))

# next try without mutiple groups: Fang et al. 2018
# target ES: -23.000 [-41.591, -4.409]

# using data from Table 3 (Cholesterol)
fg_mean_int_pre <- 207.76
fg_sd_int_pre <- 47.40
fg_mean_int_post <- 195.49
fg_sd_int_post <- 40.44
fg_n_int <- 37
fg_mean_con_pre <- 186.29
fg_sd_con_pre <- 36.02
fg_mean_con_post <- 197.50
fg_sd_con_post <- 41.14
fg_n_con <- 38

# calculate change scores
fg_mean_int_d <- fg_mean_int_post - fg_mean_int_pre
fg_mean_con_d <- fg_mean_con_post - fg_mean_con_pre
# fg_sd_int_d <- r_to_sdd(fg_sd_int_pre, fg_sd_int_post, 0.5)
# fg_sd_con_d <- r_to_sdd(fg_sd_con_pre, fg_sd_con_post, 0.5)
fg_sd_int_d <- sd_avg(fg_sd_int_pre, fg_sd_int_post)
fg_sd_con_d <- sd_avg(fg_sd_con_pre, fg_sd_con_post)
# using post scores
fg <- md(fg_mean_int_d, fg_mean_con_d, fg_sd_int_post, fg_sd_con_post, fg_n_int, fg_n_con)
fg$es <- round(fg$es, 0)
fg |> get_ci()  
# near match

fg2 <- md(fg_mean_int_d, fg_mean_con_d, fg_sd_int_d, fg_sd_con_d, fg_n_int, fg_n_con)
fg2$es <- round(fg2$es, 0)
fg2 |> get_ci()  
# also near match
