
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
dr <- function(fun, namespace = NULL){

  # deparse the function & namespace
  fun <- deparse(substitute(fun))
  namespace <- deparse(substitute(namespace))

  warn = FALSE
  # if namespace == NULL & !grep("::", fun) search path

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
