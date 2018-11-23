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

  lines <- readLines(file)
  lints <- lapply(tl_page_linters,
                  do.call,
                  list(lines = lines,
                       filename = file))

  lints_passed <- vapply(lints, is.null, FUN.VALUE = TRUE)
  lints <- lints[!lints_passed]

  # convert to a lints class object and print for the user
  lints <- structure(lints, class = "lints")
  print(lints)

  # return them invisibly. If this is an empty list, we passed the test!
  invisible(lints)

}


# !! need to add two spaces to the end of each line before linting !!


# The linters. Each of these takes in a *tokenised* version of the file, stored
# as a nested list (returned by lintr::get_source_expressions(file))

# the title line should start with a "# "
title_hash_linter <- function(lines, filename) {

  first_line <- lines[1]
  valid <- startsWith(first_line, "# ")

  if (!valid) {
    lintr::Lint(filename = filename,
                message = "The title line must start with a hash (#) and a space.",
                line = first_line,
                linter = "title_hash")
  }

}

# the next few lines should be "<namespace>::<function>"
title_ns_fun_linter <- function(lines, filename) {

  first_line <- lines[1]
  # remove start and end
  first_line <- gsub("# ", "", first_line)
  first_line <- gsub(" ", "", first_line)

  # the rest should be splittable on "::"
  split <- strsplit(first_line, "::")[[1]]

  valid <- length(split) == 2

  if (!valid) {
    lintr::Lint(filename = filename,
                message = "The title line should have the format: package::function.",
                line = first_line,
                linter = "title_ns_fun")
  }
}

# the third line should be sentence-case text without a full stop, but ending
# with two spaces and a blank line
description_line_linter <- function(lines, filename) {

}

# the remainder of the page should be made up of three-line usage blocks
# each one should have:
# a line starting "- " and ending "  " (double space)
# a line starting "`" and ending "`  " (incl. double space)
# a blank line
usage_entry_linter <- function(lines, filename) {

}

# the page should have fewer than 30 lines
number_of_lines_linter <- function(lines, filename) {

  n_lines <- length(lines)
  valid <- n_lines < 30 & n_lines >= 7

  if (!valid) {
    lintr::Lint(filename = filename,
                message = "The page should have between 7 and 30 lines.",
                linter = "number_of_lines")
  }

}

# the page should have blank lines on the 2nd, 4th, and then every third line
blank_lines_linter <- function(lines, filename) {

  n_lines <- length(lines)

}

# a list of the linters we are going to run on our markdown file
tl_page_linters <- list(title_hash_linter,
                        title_ns_fun_linter,
                        description_line_linter,
                        usage_entry_linter,
                        number_of_lines_linter)

