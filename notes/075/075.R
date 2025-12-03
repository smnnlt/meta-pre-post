# Recalculation for MA #075 (Moncian)

library(metapp)

# This is a Bayesian network meta-analysis, but also contains some pairwise 
# (probably frequentist) analyses. Only aggregated effect sizes are presented 
# (i.e., direct comparisons of treatement conditions), so I select a comparison 
# which is only present in one study (selected via Fig. 2 and Appendix 2.0)
# I use the outcome BSP for the comparison HICT vs. No exercise

# EDIT AFTER AUTHOR CONTACT: The authors have provided the forest plot of 
# the pairwise frequentist MAs

# I stick with the comparison but use the outcome VO2peak instead 
# (as only data for this outcome is provided)

# Study to recalculate: Potempa 1995
# target ES:3.60 [2.93, 4.27]

# using data from Table 2 (VO2)
mean_int_post <- 18.8
se_int_post <- 1.1
mean_con_post <- 15.2
se_con_post <- 0.9
# matches MA Appendix 2.0
# BUT beware that data is presented as SEM!
# using data from Tab 1
n_int <- 19
n_con <- 23

# calculate SD
sd_int_post <- sqrt(n_int) * se_int_post
sd_con_post <- sqrt(n_con) * se_con_post

# considering one data extraction error (SD CON is reported as 1.1 instead of 0.9)
# and considering a SE/SD mixup

# incorrectly use SE (+ data extraction error)
md(mean_int_post, mean_con_post, se_int_post, 1.1, n_int, n_con) |> get_ci()
# perfect match

# what would be the result after correcting the errors?
md(mean_int_post, mean_con_post, sd_int_post, sd_con_post, n_int, n_con) |> get_ci()
# much wider CI

# try another study: only study for MICT vs. No exercise: Lennon et al. 2008
# target ES: 0.90 [-0.29, 2.09]

# using data from Tab 2
l_mean_con_post <- 11.1
l_sd_con_post <- 1.9
l_mean_int_post <- 12.0
l_sd_int_post <- 2.2
l_n_int <- 23
l_n_con <- 23
# matches published and provided data
md(l_mean_int_post, l_mean_con_post, l_sd_int_post, l_sd_con_post, l_n_con, l_n_int) |> get_ci()
# perfect match