## Script for the meta-pre-post project
## Script #5.3: Example Case - Comparison of different calculation methods
## written by Simon Nolte in 08/2025

# Comparing different effect size calculation methods for the MA from Oliveira 
# et al. (Fig1)

# NOTE: this script cannot be fully reproduced, because we do not have the
# permission to share the IPD we have been provided. You can still rund the
# script, but the ANCOVA estimated from IPD will not be directly computed. The
# original analysis runs with the flag `private <- TRUE`

private <- file.exists("data/example/ipd_sim.csv")

# load packages
library(meta)    # running the meta-analyses
library(metapp)  # effect size calculation
library(purrr)   # functional programming
library(tidyr)   # data wrangling
library(ggplot2) # visualization
library(lme4)

# load data
ex <- read.csv("data/example/extracted.csv") # extracted data from the original studies
if (private) {
  ipd <- read.csv("data/example/ipd_sim.csv") # shared/simulated individual participant data
}

# function to calculate ANCOVA based effect size
anc2 <- function(subset, data) {
  d <- data[data$study == subset,] # filter study
  m <- lm(post ~ pre + group, data = d) # run ANCOVA
  b <- coef(summary(m))[3,1] # adjusted mean difference
  # using estimator g_A2 from Hedges et al. 2023
  n_int <- sum(d$group == "int")
  n_con <- sum(d$group == "con")
  es <- metapp::j(nrow(d)-2) * (b / sd(d$post, na.rm = TRUE))
  var <- (((n_int+n_con)*(1-cor(d$pre, d$post, use = "complete.obs")^2))/(n_int*n_con))+(es^2/(2*(n_int+n_con-2)))
  data.frame(
    es = es,
    var = var
  )
}

# function to round with trailing zero (and empty sign if needed)
rd <- function(x, digits = 0, emptysign = FALSE) {
  a <- sprintf(paste0("%.", digits, "f"), round(x, digits))
  if (emptysign) {
     a <- ifelse(x >= 0, paste0(" ", a), a)
  }
  a
}


# one-stage ANCOVA
# anc1 <- function(data) {
#   m <- lmer(post ~ pre + group + (1 + group|study), data = data) 
#   es_raw <- fixef(m)[["groupint"]]
#   es <- es_raw / sd(data$post, na.rm = TRUE) # standardize by post score SD
#   n_int <- 100
#   n_con <- 149
#   var <- (((n_int+n_con)*(1-cor(data$pre, data$post, use = "complete.obs")^2))/(n_int*n_con))+(es^2/(2*(n_int+n_con-2)))
#   list(es = es, var = var)
# }

## STEP 1: Preprocessing -----------------------------------------------------

# # first calculate missing data
# missing post means
pmm <- is.na(ex$mean_post)
ex$mean_post[pmm] <- ex$mean_pre[pmm] * (1 + 0.01 * ex$mean_dper[pmm])
# missing post sd (assume same sd as pre)
pms <- is.na(ex$sd_post)
ex$sd_post[pms] <- ex$sd_pre[pms]

# combine groups
new <- ex[-c(2,3, 23, 24), ]

# combine the Stöggl control groups
s_pre2 <- metapp::pool_groups(ex$mean_pre[1], ex$mean_pre[2], ex$sd_pre[1], ex$sd_pre[2], ex$n[1], ex$n[2])
s_pre3 <- metapp::pool_groups(s_pre2$x, ex$mean_pre[3], s_pre2$sd, ex$sd_pre[3], s_pre2$n, ex$n[3])
s_post2 <- metapp::pool_groups(ex$mean_post[1], ex$mean_post[2], ex$sd_post[1], ex$sd_post[2], ex$n[1], ex$n[2])
s_post3 <- metapp::pool_groups(s_post2$x, ex$mean_post[3], s_post2$sd, ex$sd_post[3], s_post2$n, ex$n[3])

new$mean_pre[1] <- s_pre3$x
new$sd_pre[1] <- s_pre3$sd
new$mean_post[1] <- s_post3$x
new$sd_post[1] <- s_post3$sd
new$n[1] <- s_pre3$n

# instead of combining the Selles-Peres data from running and cycling for the 
# same individuals, I only use the data from the most common exercise test 
# modality, as stated in the preregistration, which is running

# # combine running and cycling data for Seles-Perez
# sp_pre_con <- metapp::pool_groups(ex$mean_pre[21], ex$mean_pre[23], ex$sd_pre[21], ex$sd_pre[23], ex$n[21], ex$n[23])
# sp_post_con <- metapp::pool_groups(ex$mean_post[21], ex$mean_post[23], ex$sd_post[21], ex$sd_post[23], ex$n[21], ex$n[23])
# sp_pre_int <- metapp::pool_groups(ex$mean_pre[22], ex$mean_pre[24], ex$sd_pre[22], ex$sd_pre[24], ex$n[22], ex$n[24])
# sp_post_int <- metapp::pool_groups(ex$mean_post[22], ex$mean_post[24], ex$sd_post[22], ex$sd_post[24], ex$n[22], ex$n[24])
# 
# new$mean_pre[19] <- sp_pre_con$x
# new$sd_pre[19] <- sp_pre_con$sd
# new$mean_post[19] <- sp_post_con$x
# new$sd_post[19] <- sp_post_con$sd
# new$mean_pre[20] <- sp_pre_int$x
# new$sd_pre[20] <- sp_pre_int$sd
# new$mean_post[20] <- sp_post_int$x
# new$sd_post[20] <- sp_post_int$sd

# remove Seles-Peres cycling data from IPD
if (private) ipd <- ipd[ipd$type != "cycling",]

## STEP 2: Effect size calculation----------------------------------------------

# calculate change scores and different change score standard deviations
new$mean_change <- new$mean_post - new$mean_pre
new$sd_change_0 <- r_to_sdd(new$sd_pre, new$sd_post, r = 0)
new$sd_change_05 <- r_to_sdd(new$sd_pre, new$sd_post, r = 0.5)
new$sd_change_07 <- r_to_sdd(new$sd_pre, new$sd_post, r = 0.7)
new$sd_change_09 <- r_to_sdd(new$sd_pre, new$sd_post, r = 0.9)

# transform to wide data
w <- tidyr::pivot_wider(new, id_cols = c(name, year), names_from = "group_type", values_from = c(mean_pre, mean_post, mean_change, sd_pre, sd_post, sd_change_0, sd_change_05, sd_change_07, sd_change_09, n))

# calculate individual study effect sizes
ies <- list()
ies$post <- smd(x1 = w$mean_post_int, x2 = w$mean_post_con, sd1 = w$sd_post_int, sd2 = w$sd_post_con, n1 = w$n_int, n2 = w$n_con)
ies$change_0 <- smd(x1 = w$mean_change_int, x2 = w$mean_change_con, sd1 = w$sd_change_0_int, sd2 = w$sd_change_0_con, n1 = w$n_int, n2 = w$n_con)
ies$change_05 <- smd(x1 = w$mean_change_int, x2 = w$mean_change_con, sd1 = w$sd_change_05_int, sd2 = w$sd_change_05_con, n1 = w$n_int, n2 = w$n_con)
ies$change_07 <- smd(x1 = w$mean_change_int, x2 = w$mean_change_con, sd1 = w$sd_change_07_int, sd2 = w$sd_change_07_con, n1 = w$n_int, n2 = w$n_con)
ies$change_09 <- smd(x1 = w$mean_change_int, x2 = w$mean_change_con, sd1 = w$sd_change_09_int, sd2 = w$sd_change_09_con, n1 = w$n_int, n2 = w$n_con)
ies$ppc1_05 <- ppc(x1d = w$mean_change_int, x2d = w$mean_change_con, sd1pre = w$sd_pre_int, sd2pre = w$sd_pre_con, n1 = w$n_int, n2 = w$n_con, r = 0.5, type = 1)
ies$ppc1_09 <- ppc(x1d = w$mean_change_int, x2d = w$mean_change_con, sd1pre = w$sd_pre_int, sd2pre = w$sd_pre_con, n1 = w$n_int, n2 = w$n_con, r = 0.9, type = 1)
ies$ppc2_05 <- ppc(x1d = w$mean_change_int, x2d = w$mean_change_con, sd1pre = w$sd_pre_int, sd2pre = w$sd_pre_con, n1 = w$n_int, n2 = w$n_con, r = 0.5, type = 2)
ies$ppc2_09 <- ppc(x1d = w$mean_change_int, x2d = w$mean_change_con, sd1pre = w$sd_pre_int, sd2pre = w$sd_pre_con, n1 = w$n_int, n2 = w$n_con, r = 0.9, type = 2)
# ancova
if (private) {
  ies$anc2 <- purrr::list_rbind(lapply(paste0(tolower(w$name), w$year), anc2, data = ipd))
} else { # manually give the data here
  ies$anc2 <- df <- data.frame(
    es = c(0.68050646, 0.69078013, 0.05644153, 0.31094975, 0.24282096,
           0.05213826, 0.18703672, -0.50918093, 0.32653180, -0.25214194),
    var = c(0.05460013, 0.09800664, 0.06560974, 0.04691996, 0.03191217,
            0.05242230, 0.02977604, 0.07017747, 0.03531309, 0.18166867)
  )
}

## STEP 3: Run meta-analyses----------------------------------------------------
m <- lapply(ies, function(x) metafor::rma(x$es, x$var))

# get meta analysis results from rma object
mod_to_es <- function(mod) {
  p <- predict(mod, pi.type = "Riley")
  data.frame(
    es = p$pred,
    var = p$se^2,
    ci_lower = p$ci.lb,
    ci_upper = p$ci.ub,
    pi_lower = p$pi.lb,
    pi_upper = p$pi.ub
  )
}

# get pooled effects, CIs and PIs
es <- purrr::list_rbind(lapply(m, mod_to_es), names_to = "name")

es$label <- c("Post", "Change (r = 0)", "Change (r = 0.5)", "Change (r = 0.7)",
             "Change (r = 0.9)", "ppc1 (r = 0.5)", "ppc1 (r = 0.9)", 
             "ppc2 (r = 0.5)", "ppc2 (r = 0.9)", "ANCOVA 2-stage")
es$text <- paste0(rd(es$es, 2), " [", rd(es$ci_lower, 2, TRUE), "; ", rd(es$ci_upper, 2), "]")

# show all ES
ggplot(es, aes(x = es, y = label)) +
  geom_vline(xintercept = c(-0.2, 0.2, 0.5, 0.8), linetype = "dotted", color = "gray50") +
  geom_vline(xintercept = 0, color = "gray50") +
  geom_point(size = 3, shape = 18) +
  #geom_errorbarh(aes(xmin = pi_lower, xmax = pi_upper), height = 0.1, color = "gray70") +
  geom_errorbarh(aes(xmin = ci_lower, xmax = ci_upper), height = 0.2) +
  coord_cartesian(xlim = c(-0.3, 1)) + 
  scale_x_continuous(breaks = c(-0.2, 0, 0.2, 0.5, 0.8)) +
  annotate("text", x = 0.2, y = Inf, label = "Small", vjust = -0.5, hjust = -0.1, size = 3, angle = 90, color = "gray50") +
  annotate("text", x = 0.5, y = Inf, label = "Medium", vjust = -0.5, hjust = -0.1, size = 3, angle = 90, color = "gray50") +
  annotate("text", x = 0.8, y = Inf, label = "Large", vjust = -0.5, hjust = -0.1, size = 3, angle = 90, color = "gray50") +
  labs(x = "Effect Size (SMD)", y = NULL) +
  theme_minimal() +
  theme(panel.grid = element_blank())
ggsave("plots/compare_all.png", width = 6.5, height = 4, dpi = 300, bg = "white")

# show selected methods
ggplot(es[es$name %in% c("post", "change_0", "change_05", "change_07", "change_09", "ppc1_05", "ppc2_05", "anc2"),], aes(x = es, y = reorder(label, es, decreasing = TRUE))) +
  geom_vline(xintercept = c(-0.2, 0.2, 0.5, 0.8), linetype = "dotted", color = "gray50") +
  geom_vline(xintercept = 0, color = "gray50") +
  geom_point(size = 3, shape = 18) +
  #geom_text(aes(x = 1, label = text)) +
  #geom_errorbarh(aes(xmin = pi_lower, xmax = pi_upper), height = 0.1, color = "gray70") +
  geom_errorbarh(aes(xmin = ci_lower, xmax = ci_upper), height = 0.2) +
  coord_cartesian(xlim = c(-0.3, 1)) +  
  scale_x_continuous(breaks = c(-0.2, 0, 0.2, 0.5, 0.8)) +
  annotate("text", x = 0.2, y = Inf, label = "Small", vjust = -0.5, hjust = -0.1, size = 3, angle = 90, color = "gray50") +
  annotate("text", x = 0.5, y = Inf, label = "Medium", vjust = -0.5, hjust = -0.1, size = 3, angle = 90, color = "gray50") +
  annotate("text", x = 0.8, y = Inf, label = "Large", vjust = -0.5, hjust = -0.1, size = 3, angle = 90, color = "gray50") +
  labs(x = "Effect Size (SMD)", y = NULL) +
  theme_minimal() +
  theme(panel.grid = element_blank())
ggsave("plots/compare_some.png", width = 6.5, height = 4, dpi = 300, bg = "white")

