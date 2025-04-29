# Recalculation of MA #007 (Ingram)

library(metapp)

# ES to recalculate: Hayes & Walker 2007 [1] (from Suppl S6, Fig 1)
# 0.24 [-1.00, 1.47]

# the selected effect size is the larger of the two presented in the forest plot
# for the same study, so it is probably the PSS condition (not SS)

# extracted data from Fig 2 Hayes & Walker:
# control
c_mean_pre = 22.1
c_sd_pre = 30.6-c_mean_pre
c_mean_post = 22.1
c_sd_post = 30.7-c_mean_post
e_mean_pre = 21.9
e_sd_pre = 31.0-e_mean_pre
e_mean_post = 24.2
e_sd_post = 32.6-e_mean_post

# matches published data with some marginal error
published = TRUE
if (published) {
  c_sd_pre = 8.4
  c_sd_post = 8.5
  e_mean_pre = 21.8
  e_sd_pre = 9.2
  e_mean_post = 24.1
}

# the study design is cross-over with n = 7
# however the MA reports n = 4 for the control condition. This is possibly a 
# data extraction error (as MA Table S2 reports the correct number)

sd_pooled(c_sd_pre, e_sd_pre, 4, 7)

# assuming r = 0.5
ppc(e_mean_post - e_mean_pre, c_mean_post - c_mean_pre, e_sd_pre,  c_sd_pre, n1 = 7, n2 = 4, r = 0.5) |> get_ci()
# ES matches, CI almost

