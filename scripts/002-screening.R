## Script for the meta-pre-post project
## Script #2: Article Screening
## written by Simon Nolte in 04/2025, revised in 08/2025

# load packages

# read screening results
a <- read.csv("./data/reviews.csv")
a$exclusion_reason[a$exclusion_reason == "NULL"] <- NA
# screenings by person and type
table(a$user, a$type)

ids <- seq_len(max(a$study_id))
# number of articles in screening
length(ids)

ab = data.frame(
  id = ids,
  rev1 = NA,
  rev2 = NA,
  rev3 = NA,
  res = NA
)
# find abstract reviews for each study
for (i in ids) {
  di = a[a$type == "abstract" & a$study_id == i, ]
  for (j in seq_len(nrow(di))) {
    ab[i, j+1] <- di$exclusion[j]
  }
}
# count number of exclusion votings
ab$res <- apply(ab[,2:4], 1, sum, na.rm = TRUE)
ab$res <- ifelse(ab$res < 2, 0, 1)
# agreement:
sum(ab$rev1 == ab$rev2) / nrow(ab)
# no remain after abstract screening
sum(ab$res == 0)

# get reasons for exclusion 
a_excl_id <- ab$id[ab$res == 1]
ar <- data.frame(id = a_excl_id, reason1 = NA, reason2 = NA)
for (i in seq_along(a_excl_id)) {
  sub <- a[a$study_id == a_excl_id[i] & a$type == "abstract",]
  sub <- sub[!is.na(sub$exclusion_reason),]
  ar[i,2] <- sub$exclusion_reason[1]
  ar[i,3] <- sub$exclusion_reason[2]
}
table(ar$reason1)

# fulltext screening
ft = data.frame(
  ids = ids[ab$res == 0],
  rev1 = NA,
  rev2 = NA,
  rev3 = NA,
  res = NA
)
for (i in ft$ids) {
  di = a[a$type == "fulltext" & a$study_id == i, ]
  for (j in seq_len(nrow(di))) {
    ft[ft$ids == i, j+1] <- di$exclusion[j]
  }
}
# count number of exclusion votings
ft$res <- apply(ft[,2:4], 1, sum, na.rm = TRUE)
ft$res <- ifelse(ft$res < 2, 0, 1)
# agreement:
sum(ft$rev1 == ft$rev2) / nrow(ft)
# no remain after abstract screening
sum(ft$res == 0)

# get reasons for fulltext exclusion  
f_excl_id <- ft$id[ft$res == 1]
fr <- data.frame(id = f_excl_id, reason1 = NA, reason2 = NA)
for (i in seq_along(f_excl_id)) {
  sub <- a[a$study_id == f_excl_id[i] & a$type == "fulltext" ,]
  sub <- sub[!is.na(sub$exclusion_reason),]
  fr[i,2] <- sub$exclusion_reason[1]
  fr[i,3] <- sub$exclusion_reason[2]
}
table(fr$reason1)

# Articles in screening: 209 
# Articles after abstract screening: 137 Articles
# after fulltext screening: 106

# screening agreement abstract: 79%
# screening agreement full text: 81%
