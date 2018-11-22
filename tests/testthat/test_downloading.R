context("downloading")

test_that("a page can be downloaded", {

  target <- paste0("# graphics::plot\n\n> base plotting\n\n",
                   "  - dot plot of y against x\n  \n  ",
                   "`plot (y ~ x)`\n\n  - line plot of y against",
                   " x\n  \n  `plot (y ~ x, type = \"l\")`")
  page <- get_page("graphics", "plot")
  expect_equal(page, target)

})
