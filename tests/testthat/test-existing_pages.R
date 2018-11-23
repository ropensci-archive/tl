context("check existing pages")

test_that("all existing pages are lint-free", {

  files <- list.files("../../inst/pages",
                      pattern = "*.md$",
                      recursive = TRUE,
                      full.names = TRUE)

  for (file in files) {
    expect_true(run_checks(file))
  }

})
