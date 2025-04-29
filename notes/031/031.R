# recalculation for MA #031 (Terada)

library(metapp)

# Study used for recalculation: Arthur et al. 2007
# target ES: 0.17 [-0.27;0.60]

# okay, funnily enough the random number generator picked a special case here 
# (or picked the one before, but that couldn't be retrieved so I landed here)
# the MA states that this particular study did not report post sds so pre sd
# were used to impute post sds
# this is because the study focussed on the follow up data (12m), but the MA
# is interested in the post intervention data (6m).
# sample sizes at 6m can be seen in Fig 1
n_int <- 40
n_con <- 42

# Outcome as per MA is cardiopulmonary fitness, so probably VO2peak here
# baseline values (mean and sd) taken from Tab 2
mean_con_pre <- 0.93
sd_con_pre <- 0.22

mean_int_pre <- 0.98
sd_int_pre <- 0.25

# the only 6m VO2 data that is given is the mean percentage change from baseline
# as written in the text: "19% increase in the AST group vs 22% increase in the
# AT group)"
# so we use this to construct post values
mean_con_post <- mean_con_pre * 1.22
mean_int_post <- mean_int_pre * 1.19

# test if mean change scores match MA forest plot
mean_con_d <- mean_con_post - mean_con_pre
mean_int_d <- mean_int_post - mean_int_pre

# does not match!

# okay, okay, I see there is a lot going on here:

# 1. the means seem to be percentage changes instead of absolute changes. This 
# is incorrect as long as the sd is given on the absolute scale (which it is)
# 2. The percentage of 19% is incorrectly extracted as 18%
# 2. also the means are wrongly assigned (22% as intervention, but it is for 
# aerobic training alone and 19% is combined) 

# as stated in the MA text, no post sds are available, so the pre sd is used as
# a post sd. Because r = 0.5 is set for imputation, this means that the change
# score sd will be equal to the pre sd, see here:

sd_con_d <- r_to_sdd(sd_con_pre, sd_con_pre, 0.5)
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_pre, 0.5)

# for now we follow both mistakes above and set the values given in the forest
# plot to recalculate the ES (should be SMD):
metapp::smd(0.22, 0.18, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()

# perfect match using the defaults
# using vartype=3 (the RevMan default) has almost identical output
# using hedges=FALSE is almost identical

# just out of interest this is the result if we use the (correct!) absolute 
# values instead of wrong and falsely assigned percentages
metapp::smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()
# so, reverse direction, only half of the effect, var/CI width similar