#' Submit a Page to the Online Repository
#'
#' @description runs checks on the markdown file containing the tl::dr page, and
#'   provides instructions to submit the page to the github repository
#'
#' @param fun name of function being documented
#' @param namespace the package the function is in
#' @param location the folder containing the package folder and markdown file
#'   (see details).
#'
#' @details the markdown file should be named <function_name.md>, where
#'   <function_name> is the name of the function, and be in a directory with the
#'   same name as the package. That package directory should be within the
#'   directory given by \code{location} (by default the current working
#'   directory). the easiest way to set this up is by using
#'   \code{\link{create_page}()}.
#'
#' @export
#'
submit_page <- function (fun, namespace = NULL, location = getwd()) {

  # deparse the function & namespace
  fun <- deparse(substitute(fun))
  namespace <- deparse(substitute(namespace))
  fun <- gsub("\"|\'", "", fun)
  namespace <- gsub("\"|\'", "", namespace)

  # If !is.null(namespace) query
  if(!is.null(namespace)){
    f <-  fun
    ns <-  namespace
  }

  # If fun contains namespace, return from specified namespace
  #if !is.null(namespace) warn
  if(grepl("::", fun)) {
    if(!is.null(namespace)) warn = TRUE
    x <- strsplit(fun, "::")[[1]]
    ns <- x[1]
    f <- x[2]
  }

  # Error -
  if(!grepl("::", fun) & namespace == "NULL") {
    stop("No namespace provided")
  }




  # get the filepath
  filepath <- file.path(location, ns, paste0(f, ".md"))

  if (!file.exists(filepath)) {
    stop ("the file does not exist: ", filepath,
          "\n\nPerhaps you need to run tl::create_page() to create a template ",
          "or change the 'location' argument to point to the folder ",
          "containing your template?")
  }

  # run the checks
  lints <- lint_page(filepath)

  checks_failed <- !identical(lints,
                              structure(list(), class = "lints"))

  # if the checks fail
  if (checks_failed) {
    stop ("There were some issues with the formatting of your markdown file. ",
          "Please try to fix them and then run tl::submit_page() again.\n\n",
          "If you still can't tell what's wrong from the check messages, ",
          "please let us know via the GitHub issues tracker: ",
          "https://github.com/ropenscilabs/tl/issues")
  }

  # how to submit to GitHub

  msg <- paste0("Your page passed all the automated checks! ",
                "To submit the page to the online repository ",
                "please follow these instructions:\n\n",
                "1. If you don't have a GitHub account, ",
                "go to: https://github.com/join to create one\n\n")

  filename <- paste0(ns, "/", f, ".md")

  if (exists_in_repo(filename)) {

    # if the file exists already we open the edit page
    upload_url <- sprintf("https://github.com/ropenscilabs/tl/edit/master/inst/pages/%s/%s.md",
                          ns, f)

    msg <- paste0(msg,
                  "2. Go to: ", upload_url, "\n\n",
                  "3. Click 'Fork this repository'\n\n")

  } else {

    # if the namespace doesn't exist
    upload_url <- "https://github.com/ropenscilabs/tl/new/master/inst/pages"
    to_type <- paste0(ns, "/", f, ".md")

    # if the directory exists already
    if (exists_in_repo(ns)) {

      upload_url <- paste0(upload_url, "/", ns)
      to_type <- paste0(f, ".md")

    }

    # if it's a new directory
    msg <- paste0(msg,
                  "2. Go to: ", upload_url, "\n\n",
                  "3. Click 'Fork this repository' and type: ", to_type,
                  " into the 'Name your file...' box at the top of the page",
                  "\n\n")

  }

  open_editor(filepath)

  msg <- paste0(msg,
                "4. Copy-paste the helpfile from the file (", filepath, "), ",
                "enter a message, and click 'Propose file change'.\n\n",
                "5. Click 'Create pull request', on this and the next page")

  message(msg)

}

# is there a webpage for this thingo in the inst/pages folder on GitHub?
exists_in_repo <- function (thingo) {
  directory_url <- paste("https://github.com/ropenscilabs/tl/tree/master/inst/pages",
                         thingo, sep = "/")

  exists <- tryCatch(
    expr = {
      suppressWarnings(readLines(directory_url))
      TRUE
    },
    error = function (e) {
      FALSE
    }
  )

  exists

}
