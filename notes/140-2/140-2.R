# library
library(metapp)

# Gupta K, Prasad M. A pilot study on certain Yogic and Natiropathic procedures in generalized anxiety disorder. Int J Res Ayurveda Pharm 2013;4:858–61.
# Target: -0.44 [-1.59, 0.70]

n_con <- 6
n_trt <- 6
m_con <- 1.66
sd_con <- 1.03
m_trt <- 1.33
sd_trt <- 0.81
smd(m_trt, m_con, sd_trt, sd_con, n_trt, n_con, hedges = TRUE, homo = TRUE, vartype = 1) |> get_ci()
# no match!

# Trying out the last line in Table 1
m_con <- 1 
sd_con <- 1.09
m_trt <- 2 
sd_trt <- 0.63
smd(m_trt, m_con, sd_trt, sd_con, n_trt, n_con, hedges = TRUE, homo = TRUE, vartype = 1) |> get_ci()
# no match!