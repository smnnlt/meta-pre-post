# recalculation for MA #031 (Terada)

library(metapp)

# Study used for recalculation: Arthur et al. 2007
# target ES: 0.17 [-0.27;0.60]

# okay, funnily enough the random number generator picked a special case here 
# (or picked the one before, but that couldn't be retrieved so I landed here)
# the MA states that this particular study did not report post sds so pre sd
# were used to impute post sds
# this is because the study focused on the follow up data (12m), but the MA
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
# a post sd. But the forest plot shows that the pre sd were used as change 
# score sds

# for now we follow both mistakes above and set the values given in the forest
# plot to recalculate the ES (should be SMD):
metapp::smd(0.22, 0.18, sd_int_pre, sd_con_pre, n_int, n_con) |> get_ci()

# perfect match using the defaults
# using vartype=3 (the RevMan default) has almost identical output
# using hedges=FALSE is almost identical

# just out of interest this is the result if we use the (correct!) absolute 
# values instead of wrong and falsely assigned percentages
metapp::smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()
# so, reverse direction, only half of the effect, var/CI width similar

# try another study for verification: Christle et al. 2018
# target ES: -0.35 [-0.85, 0.15]

# using data from Tab 4 Maximal Exercise, VO_2 mL/kg/min
# Fig 1 for post group size
smd(17.1-17.2, 17.8-17.2, r_to_sdd(2.4, 3.6, 0.5), r_to_sdd(3.3, 3.0, 0.5), 32, 30) |> get_ci()
# the presented SD do not match the calculated ones
r_to_sdd(2.4, 3.6, 0.84)
r_to_sdd(3.3, 3.0, 0.84)
# using r = 0.84 would match

# using the presented SD
smd(17.1-17.2, 17.8-17.2, 2.1, 1.8, 32, 30, vartype = 3) |> get_ci()
# could verify hedges = TRUE
# vartype = 3 is possible (as is vartype = 1)

# try another: Ghannem et al. 2014
# using data from Tab 2 (VO_2pic)
r_to_sdd(7.8, 7.2, 0.84) # matches INT SD (4.3)
r_to_sdd(4.4, 4.9, 0.84) # matches CON SD (2.7)
# matches
# using data from forest plot
smd(0.1, 2.0, 4.3, 2.7, 9, 9, vartype = 3) |> get_ci()
# perfect match, verified vartype = 3

# last study to validate r = 0.84: Marzolini 2008
# CON group (should be 2.4, NOTE: Data presented as SEM)
r_to_sdd(0.9*sqrt(14), 1.2*sqrt(14), 0.84)
r_to_sdd(round(0.9*sqrt(14),2), round(1.2*sqrt(14),2), 0.84) #almost match
# so I could verify the actual imputed r as 0.84 (contrary to the reported 0.5)
