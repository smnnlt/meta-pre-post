# libs
library(metapp)

# Meta analysis: Article 134
# Original article: Teo, S. Y., Kanaley, J. A., Guelfi, K. J., Marston, K. J., & Fairchild, T. J.
# (2020). The impact of exercise timing on glycemic control: a randomized clinical trial.
# Medicine and science in sports and exercise, 52(2), 323-334.
# target: -0.22 [-1.10, 0.66]

# FG from Table 1
delta_am <- -0.9
sd_am <- 0.68
delta_pm <- -1.18
sd_pm <- 1.4
n_am <- 20
n_pm <- 20
smd(delta_pm, delta_am, sd_pm, sd_am, n_pm ,n_am, hedges = FALSE) |> get_ci()

# Effect size is greater compared to the 