# libs
library(metapp)

# Systematic review No. 183
# Moore, E., Fuller, J. T., Bellenger, C. R., Saunders, S., Halson, S. L., Broatch, J. R., & Buckley, J. D. (2023).
# Effects of cold-water immersion compared with other recovery modalities on athletic performance following acute strenuous exercise in physically active participants: a systematic review, meta-analysis, and meta-regression.
# Sports Medicine, 53(3), 687-705.
# Original article:
# Wilson, L. J., Dimitriou, L., Hills, F. A., Gondek, M. B., & Cockburn, E. (2019).
# Whole body cryotherapy, cold water immersion, or a placebo following resistance exercise: a case of mind over matter?.
# European journal of applied physiology, 119(1), 135-147.

# target: -0.76 [-1.72, 0.56]

# 90% CL given
n <- 8
con_avg <- -5.1
con_ci <- 5.7
trt_avg <- -6.3
trt_ci <- 6.8

# estimating standard deviation
con_sd <- con_ci * sqrt(n) / qt(0.9, 7)
trt_sd <- trt_ci * sqrt(n) / qt(0.9, 7)

# smd(hedges = TRUE, homo = TRUE,vartype = 1)
smd(trt_avg, con_avg, trt_sd, con_sd, n, n, hedges = T, homo = T, vartype = 1) |> get_ci()

# nope, using the CL
smd(trt_avg, con_avg, trt_ci, con_ci, n, n, hedges = T, homo = T, vartype = 1) |> get_ci()

# using standard 1.96
con_sd <- con_ci * sqrt(n) / qnorm(0.975)
trt_sd <- trt_ci * sqrt(n) / qnorm(0.975)
smd(trt_avg, con_avg, trt_sd, con_sd, n, n, hedges = T, homo = T, vartype = 1) |> get_ci()

# nope, trying isometric peak force
con_avg <- -13.2
con_ci <- 11.3 
trt_avg <- -14.4 
trt_ci <- 12.1 
con_sd <- con_ci * sqrt(n) / qt(0.9, 7)
trt_sd <- trt_ci * sqrt(n) / qt(0.9, 7)

# smd(hedges = TRUE, homo = TRUE,vartype = 1)
smd(trt_avg, con_avg, trt_sd, con_sd, n, n, hedges = T, homo = T, vartype = 1) |> get_ci()

