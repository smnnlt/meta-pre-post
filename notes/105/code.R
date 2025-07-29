library(metafor)
library(clubSandwich)
library(tidyverse)

#1. Multilevel meta-analysis (meta-analysis I, II, III & V) 

my_data <- escalc(n1i = N_Experimental, 
                     n2i = N_Control, 
                     m1i = POST_Experimental, 
                     m2i = POST_Control, 
                     sd1i = POST_SD_Experimental, 
                     sd2i = POST_SD_Control, 
                     data = insert_name_of_dataset, 
                     measure = "SMD", 
                     append = TRUE, 
                     mutate(es_id = row_number()), 
                     group_by(Study), 
                     mutate(study_id = group_indices())) #SMD 

my_data <- escalc(ni = N, 
                     m1i = POST_Experimental, 
                     m2i = POST_Experimental2, 
                     sd1i = POST_SD_Experimental, 
                     sd2i = POST_SD_Experimental2, 
                     ri = Correlation, 
                     data = insert_name_of_dataset, 
                     measure = "SMCC", 
                     append = TRUE, 
                     mutate(es_id = row_number()), 
                     group_by(Study), 
                     mutate(study_id = group_indices())) #SMC

#constant sampling correlation working model (rho = 0.5 used as constant sampling correlation assumption)
V_mat <- impute_covariance_matrix(vi = my_data$vi, 
                                  cluster = my_data$study_id, 
                                  r = 0.5, 
                                  smooth_vi = TRUE)

ma_model <- rma.mv(yi, 
                   V = V_mat, 
                   random = list(~ 1 | study_id/es_id), 
                   data = my_data, 
                   method = "REML", 
                   slab = Study)

summary(ma_model) #model-based variance estimates, not robust 

coef_test(ma_model, 
          vcov = "CR2", 
          cluster = my_data$study_id, 
          test = "Satterthwaite") #robust variance estimation (RVE)

conf_int(ma_model, 
         vcov = "CR2", 
         cluster = my_data$study_id, 
         test = "Satterthwaite") #robust variance estimation (RVE) 


#I2 (heterogeneity)
W <- diag(1/ma_model$vi)
X <- model.matrix(ma_model)
P <- W - W %*% X %*% solve(t(X) %*% W %*% X) %*% t(X) %*% W
I2 <- 100 * sum(ma_model$sigma2) / (sum(ma_model$sigma2) + (ma_model$k- ma_model$p)/sum(diag(P)))

I2 #total

#calculate within- and between-cluster variance from total I2
100 * ma_model$sigma2 / (sum(ma_model$sigma2) + (ma_model$k-ma_model$p)/sum(diag(P)))

#[x], [y], where x = between-cluster I2, y = within-cluster I2


#Investigate funnel plot asymmetry (MLMA Egger's test with a modified measure of precision):

my_data_sda <- my_data %>%
  mutate(Va = 4/ (N_Experimental+N_Control), sda = sqrt(Va)) %>%
  mutate(yi = as.numeric(yi)) %>%
  select(study_id, es_id, yi, vi, sda, Va)

# sda = modified measure of precision # For SMD: Va = 4/ (N_Experimental+N_Control) # For SMC: Va = 4/ (N) 

mlma_egg_mod_sda <- rma.mv(yi ~ 1 + sda, 
                           V = vi, 
                           random = list(~ 1 | study_id/es_id), 
                           data = my_data_sda, 
                           test = "t")   

mlma_egg_mod_sda #MLMA Egger's test with a modified measure of precision 


#2. Univariate meta-analysis (meta-analysis IV)

my_data <- escalc(ni = N, 
                  m1i = POST_Experimental, 
                  m2i = POST_Experimental2, 
                  sd1i = POST_SD_Experimental, 
                  sd2i = POST_SD_Experimental2, 
                  ri = Correlation, 
                  data = insert_name_of_dataset, 
                  measure = "SMCC", 
                  append = TRUE)

ma_model <- rma(yi, 
                vi, 
                data = my_data, 
                method = "REML", 
                slab = Study)

summary(ma_model)

confint.rma.uni(ma_model) #I2 with CI 


#Investigate funnel plot asymmetry (Egger's test with a modified measure of precision):

my_data_sda <- my_data %>%
  mutate(Va = 4/ (N), sda = sqrt(Va)) %>%
  mutate(yi = as.numeric(yi)) %>%
  select(yi, vi, sda, Va)

# sda = modified measure of precision # For SMC: Va = 4/ (N)

egg_mod_sda <- rma(yi ~ 1 + sda, 
                   vi, 
                   data = my_data_sda, 
                   test = "t") 

egg_mod_sda # Egger's test with a modified measure of precision 



#Test for excess statistical significance (TESS)
#and proportion of statistical significance (PSST)
#code below are from Supporting Information in Stanley et al. 2021 [44]: 

#read in your data file (below called "my_data_se") that has a column for effect sizes
#labeled "d", and standard errors of those effect sizes, labeled "sed".
#to get sed/sei use: 
summary.escalc(my_data, append=TRUE) 

d = my_data_se$d
sed = my_data_se$sed
k = length(d) #number of studies
t = d/sed
Precision=1/sed
Precision_sq=1/sed^2

#estimate tau^2 and the true underlying effect
#with existing MA methods
HetVar = ma_model$tau2 #for univariate MA models
HetVar = sum(ma_model$sigma2) #for MLMA models, instead of using only tau2/sigma^2.1 for HetVar as in Stanley et al. 2021, we use total sigma2 for MLMA models to account for within-study variance as well    
reg = lm(t ~ 0 + Precision)
UWLS = as.numeric(reg$coefficients)

#Eq. 3
zz=((1.96*sed-UWLS)/(sed^2+HetVar)^.5) 

#Eq. 4
Esigtot = sum(1-pnorm(zz))

#Get intermediate calculations for Eq. 5
SS = (t>1.96)*1 
SStot = sum(SS)
Pss = SStot/k
ESS=(SStot-Esigtot)/k 
Pe = Esigtot/k

#Eq. 5, PSST
PSST=(Pss-Pe)/(Pe*(1-Pe)/k)^.5

#Eq. 6, TESS
TESS= (ESS-.05)/(.0475/k)^.5

#Logical of whether PSST and TESS are 
#statistically significant given one-tailed
#test and alpha = 0.05
PSST_Sig = PSST > 1.645
TESS_Sig = TESS > 1.645

#organize output
output = data.frame(
  Test_Name = c("PSST", "TESS"),
  Test_Statistic = c(PSST,TESS),
  Significant = c(PSST_Sig,TESS_Sig)
)
#Print results to console
print(output)
