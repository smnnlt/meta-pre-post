# Recalculation of MA #102 (Ward)

library(metapp)

# Study to recalculate: Spinks et al. 2007
# target ES: -0.07 [-0.95, 0.81]

# Supple Tab S3 says that the data for 0-5m was used
# using data from Tab. 2 and converting from m/s to s:
mean_int_pre <-  5 / 3.62
sd_int_pre <- 0.25
mean_int_post <- 5 / 3.95
sd_int_post <- 0.23

# use Nonresisted group as CON:
mean_con_pre <- 5 / 3.51
sd_con_pre <- 0.32
mean_con_post <- 5 / 3.79
sd_con_post <- 0.29

# check if change scores match with forest plot data
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre
# exact values but with rounding error for both

# try to get the sd
r_to_sdd(sd_int_pre, sd_int_post, 0.9)
# maybe first convert sd to s
# (do this by calculating the sd as a percentage than adding to the transformed 
# mean)
sd_int_pre_new <- mean_int_pre * (sd_int_pre / 3.62)
sd_int_post_new <- mean_int_post * (sd_int_post / 3.95)
r_to_sdd(sd_int_pre_new, sd_int_post_new, 0.5)
r_to_sdd(sd_int_pre_new, sd_int_post_new, 0)

# wait, but the MA Fig 3 forest plot for the within group analysis should have
# pre and post sd, so it should be possible to verify the transformed sd
# which is: 0.09 for INT both pre and post, this does not match the calculated
# data
# but at least it may be possible to determine the imputation procedure
# should be 0.13
r_to_sdd(0.09, 0.09, 0)
# would work in theory

# using the data given in the forest plot
smd(-0.11, -0.10, 0.13, 0.14, 10, 10, vartype = 3) |> get_ci()
# match (vartype=3 and vartype=1 both match)

# could reproduce the ES calculation but still unclear about the imputation 
# procedure

# try next one: Upton 2011
# similar problem, because velocity instead of time is given
# so I cannot determine the transformation procedure for velocity sd and the 
# imputation method for correlation at the same time

# so check again the Fig 3, which says:
# 0.05 for INT both pre and post
# should be 0.07
r_to_sdd(0.05, 0.05, 0)
# match

# next one: West et al. 2013
# target ES: -0.16 [-1.04, 0.72]

# here the data is reported in s, so no need to transform
# which makes it easier to verify the correlation imputation for the sd
w_mean_int_pre <- 1.74
w_sd_int_pre <- 0.10
w_mean_con_pre <- 1.74
w_sd_con_pre <- 0.07

w_mean_int_post <- 1.70
w_sd_int_post <- 0.10
w_mean_con_post <- 1.72
w_sd_con_post <- 0.06

w_mean_int_d <- w_mean_int_post - w_mean_int_pre # matches data from forest plot
w_mean_con_d <- w_mean_con_post - w_mean_con_pre # matches data from forest plot

w_sd_int_d <- r_to_sdd(w_sd_int_pre, w_sd_int_post, 0) # matches
w_sd_con_d <- r_to_sdd(w_sd_con_pre, w_sd_con_post, 0) # matches

smd(w_mean_int_d, w_mean_con_d, w_sd_int_d, w_sd_con_d, 10, 10, vartype = 3) |> get_ci()
# perfect match (vartype=3 and vartype=1 both match)
