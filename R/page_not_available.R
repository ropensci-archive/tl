# if we don't have that page, tell the user and prompt them to submit one
page_not_available <- function (namespace, fun) {

  msg <- sprintf("we don't have a page for %s::%s yet",
                 namespace, fun)
  message(msg)

}
