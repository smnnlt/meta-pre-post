library(metapp)
#MA Desai et al. 
#Study for recalculation: Spillane et al (2009)
#target MD (CI 95%): 
  # 1.00 [-0.87;2.87]
#there seems to be an extraction error regarding the number of subjects of the control group
#in MA: 5, in study: 10 participants
#Control Mean Change (SD) : 0.85 (1.14)
#Intervention Mean Change: 1.85 (2.55)

#Correlation coefficient acc. to MA: 
r <- 0.975

#calculation of change scores: 
mean_placebo <- 56.25-54.55 #No, but if it is divided by 2 it meets the MA 
#the control group was split as this study is also party of another forest Plot
#but why did they divide the mean then...? 
mean_pla_ma <- (56.25-54.55)/2
mean_crt <- 65.12-63.27 #Yes

SD_placebo <- r_to_sdd(sd_pre = 10.05, sd_post = 10.22, r = r) 
#and again, it seems to be divided by 2
SD_pla_ma <- SD_placebo/2
#Yes... 

SD_crt <- r_to_sdd(sd_pre = 10.79, sd_post = 11.39, r = r) #Yes

#calculate with values of MA
md(mean_pla_ma, mean_crt, SD_pla_ma, SD_crt, n1 = 5, n2 = 10)|>get_ci()
#Yes, meets the target ES and CI

#try with unchanged values of placebo group and split sample size:
md(mean_placebo, mean_crt, sd1 = SD_placebo, sd2 = SD_crt, n1 = 5, n2 = 10) |>get_ci()

#MD -0.15 [-2.69;2.39]

#In the other forest tree they analysed a different measure (Body fat)- so, from my point of view, there was no need to split groups. 
#and again without splitting the sample size, as the forest plots are dealing with separate outcomes.
md(mean_placebo, mean_crt, sd1 = SD_placebo, sd2 = SD_crt, n1 = 10, n2 = 10) |>get_ci()
#MD -0.15 [-2.27;1.97]

#I don't understand why they split the control group and its mean (and SD) as it is a continuous variable
#however, it was possible to recalculate the reported ES and CI based on change scores  