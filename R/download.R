# fetch the page from the online repository, and return as a character vector
# (one element per line)

get_page <- function (namespace, fun) {

  # hardcode the URL for now
  base_url <- "https://raw.githubusercontent.com/ropenscilabs/tl/master/inst/pages/"
  url <- paste0(base_url, "/", namespace, "/", fun, ".md")
  readLines(url)

}
