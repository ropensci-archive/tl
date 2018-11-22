# fetch the page from the online repository as a character vector of length one
get_page <- function (namespace, fun) {

  # hardcode the URL for now
  base_url <- "https://raw.githubusercontent.com/ropenscilabs/tl/master/inst/pages/"
  url <- paste0(base_url, "/", namespace, "/", fun, ".md")

  # download the page into a character vector (one element per line)
  lines <- readLines(url)

  # collapse the page into a single vector
  page <- paste(lines, collapse = "\n")

  page

}
