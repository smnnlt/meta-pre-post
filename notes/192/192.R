# Recalculation of MA #192 (Spitz)

library(metapp)

# Study to recalculate: Botton et al. 2016 (High load unilateral training and testing)
# target ES: 2.46 [1.50, 3.42]

# using data from text section Methods - Subjects
n_int <- 14
n_con <- 14

# using data from Tab 1 (PT UNI, UG vs CG)
mean_int_pre <- 323.7
sd_int_pre <- 60.8
mean_int_post <- 390.0
sd_int_post <- 65.8

mean_con_pre <- 324.0
sd_con_pre <- 55.0
mean_con_post <- 323.9
sd_con_post <- 56.9

# calculate mean change and change score sd using r = 0.9
mean_int_d <- mean_int_post - mean_int_pre
mean_con_d <- mean_con_post - mean_con_pre
sd_int_d <- r_to_sdd(sd_int_pre, sd_int_post, 0.9)
sd_con_d <- r_to_sdd(sd_con_pre, sd_con_post, 0.9)
# using r = 0.9 despite the methods saying that for knee extension r = 0.923 was
# used, turned out to be the right way

# calculate SMD
# using total N data
o <- smd(mean_int_d, mean_con_d, sd_int_d, sd_con_d, n_int, n_con, hedges = FALSE) |> get_ci()
o
# perfect match for point estimate, near for CI
# maybe this is because multiple ES were used for the same study and this is
# somewhat accounted for in the CI calculation
# [okay, I later found out this is not the case!]

# so I try a study with only one ES included next: Yasuda et al. 2011
# target ES: 0.06 [-0.82, 0.94]

# using data from Tab 2 (relative isometric strength, LI-BFR vs CON)

o2 <- smd(1.59-1.53, 1.53-1.53, r_to_sdd(0.42, 0.45, 0.9), r_to_sdd(0.17, 0.20, 0.9), 10, 10, hedges = FALSE) |> get_ci()
o2
# no match (though the raw mean difference would match with the wrong sign)
# what if I use the raw MD as the point estimate, and the SMD var for the CI
o2$es <- 0.06
o2 |> get_ci()
# perfect match

# the other studies with only one ES included in the MA forest plot would 
# require data extraction, as stated in the methods section (ref number [15]-[17])
# therefore I will not try to recalculate these, but go back to the next ES from
# the forest plot, which is a different ES from the study reanalyzed above:
# Botton et al. 2016 (bilateral training, unilateral testing)
# target ES: 1.10 [0.32, 1.88]

n_int2 <- 15

# using data from Tab 1
mean_int2_pre <- 311.0
sd_int2_pre <- 62.4
mean_int2_post <- 342.5
sd_int2_post <- 72.3

# calculate mean change and change score sd using r = 0.9
mean_int2_d <- mean_int2_post - mean_int2_pre
sd_int2_d <- r_to_sdd(sd_int2_pre, sd_int2_post, 0.9)

# calculate SMD
# using total N data
smd(mean_int2_d, mean_con_d, sd_int2_d, sd_con_d, n_int2, n_con, hedges = FALSE) |> get_ci()
# perfect match!
