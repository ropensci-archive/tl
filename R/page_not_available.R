#' Check if Page exists
#'
#' If we don't have that page, tell the user and prompt them to submit one
#'
#' @param namespace package the function exists within
#' @param fun function for documentation
#'
#' @return a message
page_not_available <- function (namespace, fun) {

  name <- paste0(namespace, "::", fun)
  msg <- paste0("We don't have a page for ", name," yet.\n",
                "You can make one by using tl::create_page(", name, ")")
  message(msg)

}
