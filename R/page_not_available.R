#' Check if Page exists
#'
#' If we don't have that page, tell the user and prompt them to submit one
#'
#' @param namespace package the function exists within
#' @param fun function for documentation
#'
#' @return a message
page_not_available <- function (namespace, fun) {

  msg <- sprintf(paste0("We don't have a page for %s::%s yet. ",
                        "You can make one by using create_page()"),
                 namespace, fun)
  message(msg)

}
