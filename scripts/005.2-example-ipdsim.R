## Script for the meta-pre-post project
## Script #5.2: Simulate missing IPD for ANCOVA estimates
## written by Simon Nolte in 10/2025

# set random seed
set.seed(4711)
library(MASS)
library(purrr)
library(dplyr)

# read available IPD
d <- read.csv("data/example/ipd.csv")
ipd_available <- unique(d$study)

# get median correlation from available IPD
dtest <- d
dtest$group_id <- paste0(dtest$study, dtest$group, dtest$type)
cor_table <- dtest |> 
  group_by(group_id) |>
  summarize(r = cor(pre, post, use = "complete.obs"))
cor_ipd <- median(cor_table$r) # 0.85

# load extracted data from all studies
ex <- read.csv("data/example/extracted.csv")

# filter studies that have no ipd
ex$study <- paste0(tolower(ex$name), ex$year)
ex_filt <- ex[!ex$study %in% ipd_available,]

# function to simulate multivariate normal data given a pre-post correlation

sim_trial <- function(mean_pre, mean_post, sd_pre, sd_post, r, n, study, group, type) {
  # calculate covariance
  cv <- r * sd_pre * sd_post
  sig <- matrix(c(sd_pre^2, cv, cv, sd_post^2), nrow = 2) # covariance matrix
  o <- MASS::mvrnorm(
    n = n, 
    mu = c(mean_pre, mean_post), 
    Sigma = sig, 
    empirical = TRUE # get exact values
  )
  o <- as.data.frame(o)
  colnames(o) <- c("pre", "post")
  info <- data.frame(study = study, group = group, type = type)
  cbind(info, o)
}

# simulate IPD
ipd_sim <- purrr::pmap(
  .l = list(
    mean_pre = ex_filt$mean_pre, mean_post = ex_filt$mean_post,
    sd_pre = ex_filt$sd_pre, sd_post = ex_filt$sd_post,
    n = ex_filt$n,
    study = ex_filt$study, group = ex_filt$group, type = ex_filt$group_type
  ),
  .f = sim_trial,
  # sets a fixed reasonable correlation for all studies
  r = 0.85
) |>
  purrr::list_rbind()

# merge real and simulated IPD
d$sim <- FALSE
ipd_sim$sim <- TRUE
ipd_sim$id <- (nrow(d)+1):(nrow(d)+nrow(ipd_sim))
full <- rbind(d, ipd_sim)

# check if total N is correct
nrow(full) == sum(ex$n)
# no
nrow(ipd_sim) == sum(ex_filt$n)
# yes
# so there is a mismatch in the n for the IPD data received

# I took a look into the raw IPD received. In several cases, the IPD reports
# more participants than the published results. In one case (n = 2), this
# appears to be because only pre-measures are available. In the other case (n =
# 2, twice) the provided IPD is complete.

# export IPD
write.csv(full, "data/example/ipd_sim.csv")