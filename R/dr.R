
#' @title View a Quick Reference Page
#'
#' @description download and display a simple quick reference page for a
#'   function
#'
#' @param fun the function
#' @param namespace the package the function is in
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # pull up the quick-reference guide for the first function in dplyr
#' tl::dr(dplyr::first)
#'
#' # you can also call it in one of these ways!
#' tl::dr(first, dplyr)
#' tl::dr("dplyr::first")
#' tl::dr("first", "dplyr")
#' }
dr <- function(fun, namespace = NULL) {

  # deparse the function & namespace
  fun <- deparse(substitute(fun))
  namespace <- deparse(substitute(namespace))
  fun <- gsub("\"|\'", "", fun)
  namespace <- gsub("\"|\'", "", namespace)

  # if namespace == NULL & !grep("::", fun) search path
  if (namespace == "NULL" & !grepl("::", fun)) {

    # try and find the function within the current environment
    package <- find(fun)[1]

    if (length(package) < 1) {

      # stop if the find() returns a 0 length vector
      stop("Namespace not provided to find the function.
           Please try supplying a package with the function name.
           Example: base::grepl")

    } else {

      if (!grepl("package:", package)) {

        # stop if find() returns information about anything other than a package
        stop(fun, " is not from a valid package in your current environment.
             Please try supplying a package with the function name.
             Example: base::grepl")

      }

      f <- fun
      ns <- gsub("package:", "", package)
    }
  }

  # If !is.null(namespace) query
  if (namespace != "NULL") {

    f <-  fun
    ns <-  namespace

  }

  # If fun contains namespace, return from specified namespace
    #if !is.null(namespace) warn
  if (grepl("::", fun)) {

    x <- strsplit(fun, "::")[[1]]
    ns <- x[1]
    f <- x[2]

    if (namespace != "NULL") {

      message("Two namespaces have been provided defaulting to ", fun)

    }
  }

  # Error -
  if (is.null(f) & is.null(ns)) {
    stop("No namespace provided.
         Please try supplying a package with the function name.
         Example: base::grepl")
  }

  # try to get a page, catching all errors
  page <- tryCatch(

    expr = {
      get_page(ns, f)
    },

    error = function(e) {
      NULL
    }

  )

  # if it errored, give the user a message (and return NULL)
  if (is.null(page)) {

    page_not_available(ns, f)

  } else {

    # otherwise, go ahead and display the page
    display(page)

  }

  # return the page text, but don't print it
  invisible(page)

}
