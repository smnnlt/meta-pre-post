# Recalculation of MA #134 (Galan-Lopez)

library(metapp)

# Study to recalculate: Teo et al. 2020 
# target ES: -0.22 [-1.10, 0.66]

# use reported change score and change score sd from Tab 1 FG Overall
smd(-0.9, -1.18, 0.68, 1.40, 20, 20) |> get_ci()
# ES quite near, CI far off

# use imputed change score sd instead
smd(-0.9, -1.18, r_to_sdd(1.70, 1.45, 0.7), r_to_sdd(3.72, 2.41, 0.7), 20, 20)
# no

# try next study: Savikj et al. 2019
# target ES: -0.75 [-1.62, 0.11]

# design is crossover, but as stated in the MA I analyse as if it was parallel
# group design
n <- 11
# using data from Tab 2 Glucose
# calculate mean change scores using the sam
mean_am <- 7.7-7.3
mean_pm <- 7.5-7.3
# calculate change score sd based on imputation
# note that data is given as SEM
sd_am <- r_to_sdd(0.3*sqrt(n), 0.4*sqrt(n), 0.7)
sd_pm <- r_to_sdd(0.3*sqrt(n), 0.3*sqrt(n), 0.7)
# calculate SMD
smd(mean_am, mean_pm, sd_am, sd_pm, n, n)
# far off
# maybe mistakenly taken SEM instead of SD
smd(mean_am, mean_pm, 0.35, 0.3, n, n)
# no

# try next study: Mancilla et al 2020
# target ES: -0.46 [-1.22, 0.31]

# using data from Tab 2 Fasting glucose
smd(0.5, -0.3, 0.8, 1.0, 12, 20) |> get_ci()
# way off

# use imputed change score SD instead of reported
smd(0.5, -0.3, r_to_sdd(2.1,2.7,0.7), r_to_sdd(2.1,2.0,0.7), 12, 20) |> get_ci()
# quite near but not perfect (particularly for CI)

# try next study: Savikj et al. 2022
# target ES: -0.12 [-1.04, 0.80]

# It seems challenging to find the appropriate data in the publication, also the
# study is a cross-over trial. So for convenience reasons I try the next study:

# Menek et al. 2022
# target ES: 0.06 [-0.65, 0.78]

# this is a rather complex design with two groups performing a cross-over trial
# each. I'll try the next study instead:

# Which is again Theo et al. 2020
# this is a bit curious, because the same study is twice in the forest plot
# without any indicators, and the original study does present two groups, but
# shows only overall results and results for one group in Tab 2

# maybe this second group is just the subgroup amEx presented in Tab 2
smd(-1.27, -1.80, 0.75, 1.77, 10, 10) |> get_ci()
# no match

# but I had a look at the MA forest plot panel B
# which also shows two ES for Theo 2020 
# I recalculate the ES (MA) first for the overall and then for the amEX subgroup
md(-0.27, -0.25, 0.24, 0.23, 20, 20) |> get_ci()
# very near ES point estimate, CI far off

md(-0.57, -0.4, 0.13, 0.12, 10, 10) |> get_ci()
# perfect match for ES point estimate, CI far off

# Overall I do not really know what is going on in the ES calculation
# I tried several studies but could not fully reproduce a single ES
