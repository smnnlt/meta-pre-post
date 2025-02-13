library(rentrez)
library(RMariaDB)

# Journals:
# Sports Medicine
# Journal of Strength & Conditioning Research
# International Journal of Sports Physiology & Performance
# British Journal of Sports Medicine
# Journal of Science and Medicine in Sports
# Journal of Sports Sciences

# search data base
search <- rentrez::entrez_search(
  db = "pubmed",
  term = '((("Sports Med"[Journal]) OR ("J Strength Cond Res"[Journal]) OR ("Int J Sports Physiol Perform"[Journal]) OR ("Br J Sports Med"[Journal]) OR ("J Sci Med Sport"[Journal]) OR ("J Sports Sci"[Journal])) AND (("2024/01/01"[Date - Publication] : "2025/01/01"[Date - Publication]))) AND (Meta-Analysis[Title])',
  retmax = 500
)

ids <- search$ids
n <- length(ids)# initial number of results

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

d <- purrr::list_rbind(lapply(seq_len(length(ids)), get_details))

# total number of search results
ns <- nrow(d)
if (ns != n) warning("Search Details retrieved different number of results.")

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

# print number of studies by journal
table(dr$journal)

# write to local data base
con <- dbConnect(MariaDB(), host = "127.0.0.1", user = "root", dbname = "local")
#dbWriteTable(con, "studies", dr, overwrite = TRUE)
