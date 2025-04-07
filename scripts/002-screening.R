## Script for the meta-pre-post project
## Script #2: Article Sreening
## written by Simon Nolte in 04/2025

# load packages

# read screening results
a <- read.csv("./data/reviews.csv")
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
# no remain after abstract screening
sum(ab$res == 0)

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
# no remain after abstract screening
sum(ft$res == 0)

# Articles in screening: 209
# Articles after abstract screening: 137
# Articles after fulltext screening: 106
