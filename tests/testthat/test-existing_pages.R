context("check existing pages")

test_that("all existing pages are lint-free", {

  # all the pages, including the template
  files <- list.files("../../inst/pages",
                      pattern = "*.md$",
                      recursive = TRUE,
                      full.names = TRUE)

  for (file in files) {
    expect_true(run_checks(file))
  }

})
