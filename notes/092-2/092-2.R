# Recalculation for MA #092 Babiloni-Lopez

#Study used for Recalculation: 
# Cuesta-Vargas et al. 2011 - Exercise, Manual Therapy, and Education with or Without
#High-Intensity Deep-Water Running for Nonspecific Chronic Low Back Pain

#Target ES + CI 
# - 0.083 [-0.634; 0.469]
#Changes in pain intensity after water-based intervention compared with nonactive intervention. Values shown
#are effect sizes (Hedge’s g) with 95% confidence intervals (CIs)

library(metapp)
n <- 23
change_int <- -36.1
change_int_sd <- 25.1
change_con <- -34.1
change_con_sd <- 26

smd(change_int, change_con, change_int_sd, change_con_sd, n, n, hedges = TRUE) |> get_ci()
#close to the target ES

#Try with other sample size values
smd(change_int, change_con, change_int_sd, change_con_sd, 25, 24, hedges = TRUE) |> get_ci()
# doesn't really change the ES, although, the var and CI are closer this time

#try without hedges g adjustment:
smd(change_int, change_con, change_int_sd, change_con_sd, 25, 24, hedges = FALSE) |> get_ci()
#ES is a little closer

#Using Pre + Post Scores of Study
pre_int <- 52.5
pre_int_sd <- 20
pre_con <- 57.6
pre_con_sd <- 14.1

post_int <- 16.4
post_int_sd <- 24.4
post_con <- 23.4
post_con_sd <- 20.6

change_c <- post_con - pre_con # -34.2 instead -34.1
change_i <- post_int - pre_int

smd(change_int, -34.2, change_int_sd, change_con_sd, 23, 23, hedges = TRUE) |> get_ci()
#doesn't change a lot. 

# I am not able to recalculate the given ES, 
#however, the confidence interval is close to the one that was stated in MA 
