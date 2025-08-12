## Script for the meta-pre-post project
## Script #1: Article Search
## written by Simon Nolte in 02/2025

# load packages
library(rentrez)  # PubMed API
library(RMariaDB) # Database connection
library(xml2)     # result parsing

# search done on 13 Feb 2025

# Journals:
# Sports Medicine
# Journal of Strength & Conditioning Research
# International Journal of Sports Physiology & Performance
# British Journal of Sports Medicine
# Journal of Science and Medicine in Sports
# Journal of Sports Sciences

# initially we searcher for articles published in the year 2024
# as stated in the preregistration, the target number of articles included in
# the data extraction phase was 100. As the initial search (only 2024) 
# retrieved only ~120 articles, we directly performed an extension of the 
# search to the year 2023, as stated in the preregistration

# search data base (year 2024)
search <- rentrez::entrez_search(
  db = "pubmed",
  term = '((("Sports Med"[Journal]) OR ("J Strength Cond Res"[Journal]) OR ("Int J Sports Physiol Perform"[Journal]) OR ("Br J Sports Med"[Journal]) OR ("J Sci Med Sport"[Journal]) OR ("J Sports Sci"[Journal])) AND (("2024/01/01"[Date - Publication] : "2025/01/01"[Date - Publication]))) AND (Meta-Analysis[Title])',
  retmax = 500
)
# search for year 2023
search23 <- rentrez::entrez_search(
  db = "pubmed",
  term = '((("Sports Med"[Journal]) OR ("J Strength Cond Res"[Journal]) OR ("Int J Sports Physiol Perform"[Journal]) OR ("Br J Sports Med"[Journal]) OR ("J Sci Med Sport"[Journal]) OR ("J Sports Sci"[Journal])) AND (("2023/01/01"[Date - Publication] : "2024/01/01"[Date - Publication]))) AND (Meta-Analysis[Title])',
  retmax = 500
)

ids <- c(search$ids, search23$id)
n <- length(ids)# initial number of results

# function to retrieve article details from PubMed
get_details <- function(i) {
  xml_full <- rentrez::entrez_fetch(db = "pubmed", id = ids[i], rettype = "xml")
  xml_data <- xml2::read_xml(xml_full)
  
  abstract <- xml2::xml_find_all(xml_data, "//Abstract") |> xml2::xml_text()
  if (length(abstract) == 0) abstract <- NA
  
  out <- data.frame(
    id = i,
    doi = xml2::xml_find_all(xml_data, "//ELocationID[@EIdType='doi']") |> xml2::xml_text(),
    title = xml2::xml_find_all(xml_data, "//ArticleTitle") |> xml2::xml_text(),
    abstract = abstract,
    name = xml2::xml_find_first(xml_data, "//LastName") |> xml2::xml_text(),
    journal = xml2::xml_find_all(xml2::xml_find_all(xml_data, "//Journal"), "//Title") |> xml2::xml_text()
  )
  out
}

# get article details
d <- purrr::list_rbind(lapply(seq_len(length(ids)), get_details))
# remove data retrival errors
d <- d[!duplicated(d$id),]
# remove duplicate entries
d <- d[!duplicated(d$doi),]

# total number of search results
ns <- nrow(d)

# remove studies without abstract
dr <- d[!is.na(d$abstract),]

# remove studies when the title begins with one of the following phrases:
# 'correction to', 'response to', 'reply', 'comment on', 'letter to'
drr <- dr[!(grepl("(?i)^Comment on", d$title) | grepl("(?i)^Comment on", d$title) | grepl("(?i)^Response to", d$title) | grepl("(?i)^Reply", d$title) | grepl("(?i)^Letter to", d$title)),]

# number of studies remaining
nr <- nrow(dr)

# reassign ids
dr$id <- seq_len(nr)

# write website
dr$doi <- paste0("doi.org/", dr$doi)

# print number of studies:
cat("Search results: ", ns, "\nAfter automated screening: ", nr)

# Search results:  250
# Remaining after duplicate removal: 226 
# After automated screening:  209

# print number of studies by journal
table(dr$journal)

# write to local data base
con <- dbConnect(MariaDB(), host = "127.0.0.1", user = "root", dbname = "local")
#dbWriteTable(con, "studies", dr, overwrite = TRUE)
