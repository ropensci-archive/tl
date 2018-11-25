context("check existing pages")

test_that("dr() works with all modes of input", {

  # temporarily set the help type to text
  ht <- getOption("help_type")
  on.exit(options(help_type = ht))
  options(help_type = "text")

  target <- paste0("graphics::plot\n\nbase plotting\n\n- dot plot of y against ",
                  "x  \n  plot (y ~ x)  \n\n- line plot of y against x  \n  ",
                  "plot (y ~ x, type = \"l\")  \n")

  # 6 types of input; either an expression or a string, and one of:
  # <function>
  # <function>, <namespace>
  # <namespace::function>

  out_single_expr <- capture_message( tl::dr(plot) )
  out_separate_expr <- capture_message( tl::dr(plot, graphics) )
  out_ns_expr <- capture_message( tl::dr(graphics::plot) )
  out_single_text <- capture_message( tl::dr("plot") )
  out_separate_text <- capture_message( tl::dr("plot", "graphics") )
  out_ns_text <- capture_message( tl::dr("graphics::plot") )

  expect_identical(out_single_expr$message, target)
  expect_identical(out_separate_expr$message, target)
  expect_identical(out_ns_expr$message, target)
  expect_identical(out_single_text$message, target)
  expect_identical(out_separate_text$message, target)
  expect_identical(out_ns_text$message, target)

})
