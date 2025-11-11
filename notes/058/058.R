# Recalculation of MA #058 (Silva Oliveira)

library(metapp)

# Study to recalculate: Stöggl & Sperlich 2014c
# target ES: 0.98 [0.02, 1.93]
#
# for this study multiple groups served as separate control groups for the POL
# intervention group (this is an incorrect procedure for MA)
# extracting data for VO2peak from Tab 2 (and results section for n)
# based on the means, group c appears to be the comparison POL vs. THR

n_int <- 12
mean_int_pre <- 60.6
sd_int_pre <- 8.3
mean_int_post <- 67.4
sd_int_post <- 7.7

n_con <- 8
mean_con_pre <- 63.2
sd_con_pre <- 4.6
mean_con_post <- 60.8
sd_con_post <- 7.1

mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre
# match for change scores

# I could not get a match for the reported change score sds, BUT:
# This MA is a special case, because I analyzed it some months ago and got stuck
# at exactly this point when I tried to reanalyze it. I contacted the
# corresponding author via email and after some friendly exchange he provided me 
# with an Excel sheet I used to understand the process for calculating the 
# change score SDs. 

# The MA needed change score SDs, but many studies only reported pre and
# post sds. To impute change score sds, the authors kind of back-calculated them
# from the available values, by:
# (1) calculating an unpaired z-test for pre vs. post-values
# (2) back calculating the standard error by using the z-CIs and the formula
# for a paired t-test
# as a formula this means: s_d = sqrt(s_pre^2 + s_post^2) * z / t[df=n-1]
sd_int_d <- sqrt(sd_int_pre^2+sd_int_post^2)*qnorm(0.975) / qt(0.975, df = n_int - 1)
sd_con_d <- sqrt(sd_con_pre^2+sd_con_post^2)*qnorm(0.975) / qt(0.975, df = n_con - 1)
# this matches the values for SD in the forest plot

# use these values to calculate the SMD:
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()
# match for ES, almost for CI
# use the rounded values
smd(mean_int_d, mean_con_d, round(sd_int_d, 1), round(sd_con_d, 1), n_int, n_con) |> get_ci()
# same as above
# using vartype = 4
smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con, vartype = 4) |> get_ci()
# perfect match!

# so I could reproduce the ES and its CI as a SMD based on change scores and 
# their sds, but the sds were calculated based on pre and post sds without 
# imputation a pre-post correlation using an incorrect procedure. I could 
# determine the procedure only when contacting the authors. Without author 
# contact, I would not have been able to reproduce the ES. 

# As a disclaimer, I tried to reproduce this MA a few months ago and it was the 
# motivation to start this project. This MA will later be used as an example to 
# demonstrate the impact of different effect size calculation methods on meta-
# analytical findings.