# linting pages, to make sure they conform to our standards
lint_page <- function (file) {

  # the user needs lintr to be installed to do this, check and error nicely
  have_lintr <- requireNamespace("lintr", quietly = TRUE)

  if (!have_lintr) {
    stop ("tl needs the lintr package to be installed ",
          "in order to check a page is correctly formatted, ",
          "but lintr isn't installed. You can install it with:  ",
          "install.packages(\"lintr\")")
  }

  # run the lintrs using lint
  lints <- lintr::lint(file, linters = tl_page_linters)

  # remove any that are errors (it thinks this is R code, so erros are false
  # positives)
  are_errors <- vapply(lints,
                       function (lint) {
                         lint$type == "error"
                       },
                       FUN.VALUE = FALSE)
  lints <- lints[!are_errors]

  # display the lints for the user
  print(lints)

  # return them invisibly. If this is an empty list, we passed the test!
  invisible(lints)

}

tl_page_linters <- list()
