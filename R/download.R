#' Get Page
#'
#' Fetch the page from the online repository as a character vector of length one.
#' If the online repository cannot be reached the function returns from the local
#' install of the package.
#'
#' @param namespace the package the function exists within
#' @param fun the function to return documenation for
#'
#' @return a page for presenation
get_page <- function (namespace, fun) {

  # if we can access the repo
  if (can_access_repo()) {

    # get a nice fresh version from the web (hardcoding the URL for now)
    base_path <- "https://raw.githubusercontent.com/ropenscilabs/tl/master/inst/pages/"

  } else {

    # otherwise, get the version of the pages the last time this was installed
    base_path <- system.file("pages", package = "tl")

    # let the user know
    notify_using_cache()

  }

  path <- paste0(base_path, "/", namespace, "/", fun, ".md")

  # quietly try to read the page into a character vector (one element per line)
  suppressWarnings(
    lines <- readLines(path)
  )

  # collapse the page into a single vector and return
  page <- paste(lines, collapse = "\n")
  page

}

#' Check Availability of TL::DR Repo
#'
#' Check if we can access the repo (we have internet and the repo isn't down)
#'
#' @return boolean
can_access_repo <- function () {

  # hardcoded URL to a file we know should be there
  url <- "https://raw.githubusercontent.com/ropenscilabs/tl/master/inst/pages/template.md"

  # try to download it
  result <- tryCatch(

    expr = {
      suppressWarnings(
        readLines(url)
      )
      TRUE
    },

    # if it errors, give the user a message and quit the function
    error = function(e) {
      FALSE
    }

  )

  result

}

#' Using Cache
#'
#' Advising the user that they're using a cached version of the documenation.
#'
#' Let the user know we're using the cache
#'
#' @return prints a message
notify_using_cache <- function () {

  # see how long ago the user installed the package
  install_age <- as.numeric(Sys.Date() - date_tl_installed())

  # basic message
  msg <- paste0("Could not connect to the online repository of tl::dr pages, ",
                "so using the page versions from the last time you installed ",
                "the tl package, ")

  # most of the code in this function is to get the last two words of the
  # sentence right. *eyeroll*
  if (install_age == 0) {
    msg <- paste0(msg, "today")
  } else {
    if (install_age == 1) {
      days <- " day "
    } else {
      days <- " days "
    }
    msg <- paste0(msg, install_age, days, "ago.\n")
  }

  # add update instructions
  msg <- paste0(msg,
                "\nWhen you have internet access again, you can update ",
                "your stored versions of the pages by doing:  ",
                "devtools::install_github(\"ropenscilabs/tl\")\n")

  message(msg)

}

#' Date Package Installed
#'
#' On what date was tl last installed on this system?
#'
#' @return a date
date_tl_installed <- function() {
  file <- system.file("pages", package = "tl")
  info <- file.info(file)
  as.Date(info$mtime)
}
