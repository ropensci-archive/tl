context("check existing pages")

test_that("all existing pages are lint-free", {

  # all the pages, including the template
  files <- list.files("../../inst/pages",
                      pattern = "*.md$",
                      recursive = TRUE,
                      full.names = TRUE)

  for (file in files) {

    # inspired by lintr::expect_lint_free()
    lints <- lint_page(file)

    has_lints <- length(lints) > 0
    lint_output <- NULL

    if (has_lints) {
      lint_output <- paste(
        capture.output(print(lints)),
        collapse = "\n"
      )
    }

    test_message <- paste(
      "Not lint free",
      lint_output,
      sep = "\n"
    )

    expect(!has_lints, test_message)

  }

})
