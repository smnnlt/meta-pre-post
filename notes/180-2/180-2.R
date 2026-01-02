# libs
library(metapp)

# Original article
# Junior, O. T. C., Dezotti, N. R. A., Dalio, M. B., Joviliano, E. E., & Piccinato, C. E. (2018).
# Effect of graduated compression stockings on venous lower limb hemodynamics in healthy amateur runners.
# Journal of Vascular Surgery: Venous and Lymphatic Disorders, 6(1), 83-89.

# target: 0.03 [-0.85, 0.91] Venous Not possible as the necessary
# data is not reported.

# Trying next article:
# Dascombe, B. J., Hoare, T. K., Sear, J. A., Reaburn, P. R., & Scanlan, A. T. (2011).
# The effects of wearing undersized lower-body compression garments on endurance running performance.
# International journal of sports physiology and performance, 6(2), 160-173.

# target: 0.9 [0.02, 1.79]
# not clear which measurement was chosen
# trying 0_2 pulse
n <- 11
mu_con <- 0.3
sd_con <- 0.05
mu_trt <- 0.32
sd_trt <- 0.03
md(mu_con, mu_trt, sd_con, sd_trt, n, n, var_homo = FALSE) |> get_ci()
ppc(mu_con, mu_trt, sd_con, sd_trt, n, n, r = 0.5) |> get_ci()

# nope, trying Post TTE

mu_con <- 11.6
sd_con <- 2.2
mu_trt <- 10.6
sd_trt <- 2.0
md(mu_con, mu_trt, sd_con, sd_trt, n, n, var_homo = FALSE) |> get_ci()
ppc(mu_con, mu_trt, sd_con, sd_trt, n, n, r = 0.5) |> get_ci()

# nope.