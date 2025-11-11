# Recalculation of MA #045 (Stutter)

library(metapp)

# Study to recalculate: Berton et al. 2022
# target ES: 0.19 [-0.07, 0.46]

# data from Tab 1 
# heavy (WL) acts as control here 
# light (PLYO) as intervention

n_con <- 15
n_int <- 15

# data from Tab 4 (30 m)
# from the forest plot and Tab 4 it seems more plausible that change score data
# was used instead of post values

mean_con_pre <- 6.39
sd_con_pre <- 0.31
mean_con_post <- 6.40
sd_con_post <- 0.30

mean_int_pre <- 6.24
sd_int_pre <- 0.4
mean_int_post <- 6.33
sd_int_post <- 0.35

mean_con_d <- mean_con_post - mean_con_pre
mean_int_d <- mean_int_post - mean_int_pre

# imputing r = 0.5 for the change score standard deviation
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.5)
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.5)

# maybe change score based
metapp::smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con) |> get_ci()
# ES point estimate only near if I try some imputations, but variance is way off

# or maybe post score based
metapp::smd(mean_int_post, mean_con_post, sd_int_post, sd_con_post, n_int, n_con)
# ES quite near, CI far off

#### EDIT AFTER AUTHOR CONTACT

# The authors provided a document with more details of the effect size 
# calculation method. They stated that they calculated within group effect sizes 
# for each group using metafor::escalc(measure = "SMCC") and then combined them

# the exact method of metafor is currently not implemented in the metapp 
# package as of version 0.0.3
# Therefore it is manually implemented here:
# g = j(df=n-1) * (x_post - s_pre) / sd_d
# var(g) = (1/n)+(g^2/2n)

# calculate effect size for intervention group
d_int <- j(n_int - 1) * (mean_int_post - mean_int_pre) / sd_int_d
var_int <- ((1 / n_int) + (d_int^2 / (2 * n_int)))

# calculate effect size for control group
d_con <- j(n_con - 1) * (mean_con_post - mean_con_pre) / sd_con_d
var_con <- ((1 / n_con) + (d_con^2 / (2 * n_con)))

# checking for consistency with metafor::escalc(measure = "SMCC")
metafor::escalc(measure = "SMCC", m1i = mean_int_post, m2i = mean_int_pre, sd1i = sd_int_post, sd2i = sd_int_pre, ni = n_int, ri = 0.5)
metafor::escalc(measure = "SMCC", m1i = mean_con_post, m2i = mean_con_pre, sd1i = sd_con_post, sd2i = sd_con_pre, ni = n_con, ri = 0.5)
# success

# combine within group effect sizes:
# substract point effect sizes, add up variances
sc <- sc_int
sc$es <- d_int - d_con
sc$var <- var_int + var_con
sc |> get_ci()
# perfect match for point effect estimate, far off for confidence interval

# the published code shows that the authors had insert the effect size standard
# error in the meta-analysis function meta::metagen(), so they had to take the
# square root of the variance
# What if this did not actually happen during the analysis, but instead the
# variance was directly inserted
sc$var <- sc$var^2
sc |> get_ci()
# perfect match!

# So effect size standard error and variance were mixed up during the analysis.

# (Another finding is that the authors stated that they used a t-distribution to
# calculate the confidence intervals, but from the code and this reanalysis it
# seems that they used the standard z-distribution.)

#### END OF EDIT

# I may need to take another study. Next one is:
# Cormie et al. 2010 (40m)
# target ES: 0.23 [-0.36, 0.82]

# change score based given the data in Tab 3
smd(-0.12, -0.22, 0.06, 0.14, 8, 8) 
# nooo
# so it was post scores all the time?
smd(5.76, 5.69, 0.17, 0.22, 8, 8)

# hm, also 30m has a larger ES, which matches with larger between group 
# differences in post-intervention data. Speaks for post-score

# but again, the ES does not match and the CI is way to small

#### edit after author contact

# try to verify the effect size calculation method and the standard error/
# variance mix-up as seen above

# calculate within group effects
corm_int <- j(8 - 1) * (5.76 - 5.86) / r_to_sdd(0.18, 0.16, 0.5)
corm_var_int <- ((1 / 8) + (corm_int^2 / (2 * 8)))
corm_con <- j(8 - 1) * (5.69 - 5.90) / r_to_sdd(0.22, 0.27, 0.5)
corm_var_con <- ((1 / 8) + (corm_con^2 / (2 * 8)))
# combine within group effects
corm <- sc_int
corm$es <- corm_int - corm_con
corm$var <- corm_var_int + corm_var_con
corm |> get_ci()
# match for point estimate, far off for confidence interval
corm$var <- corm$var^2
corm |> get_ci()
# perfect match!
# when considering the same mix-up
