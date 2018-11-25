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

# the third line should be lower-case text without a full stop
description_lowercase_linter <- function(lines, filename) {

  desc_line <- lines[3]

  lower_case <- identical(desc_line, tolower(desc_line))

  no_full_stop <- !grepl("\\.", desc_line)

  valid <- lower_case & no_full_stop

  if (!valid) {
    lintr::Lint(filename = filename,
                message = "The description line should be lowercase, with no full stop.",
                line = desc_line,
                linter = "description_lowercase")
  }

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

# each line should have fewer than 80 characters
line_length_linter <- function(lines, filename) {

  n_characters <- nchar(lines)
  valid <- all(n_characters < 80)

  if (!valid) {
    lintr::Lint(filename = filename,
                message = "All lines should be fewer than 80 characters.",
                linter = "line_length")
  }

}

# the page should have blank lines on the 2nd, 4th, and then every third line
blank_lines_linter <- function(lines, filename) {

  n_lines <- length(lines)

  header_blank_lines <- c(2L, 4L)
  usage_blank_lines <- 4L + seq(3L, n_lines - 4L, by = 3L)
  expected_blank_lines <- c(header_blank_lines, usage_blank_lines)

  blank_lines <- which(lines == "")

  valid <- identical(blank_lines, expected_blank_lines)

  if (!valid) {

    msg <- paste0("The following lines should be blank: ",
                 paste(expected_blank_lines, collapse = ", "),
                 ".")

    lintr::Lint(filename = filename,
                message = msg,
                linter = "blank_lines")
  }
}


# the remainder of the page should be made up of three-line usage blocks
# each one should have:
# a line starting "- " and ending "  " (double space)
# a line starting "`" and ending "`  " (incl. double space)
# a blank line
usage_entry_linter <- function(lines, filename) {

  n_lines <- length(lines)

  # break the page up into usage blocks
  usage_lines <- lines[-(1:4)]
  usage_ids <- rep(1:8, each = 3, length.out = n_lines - 4)
  usages <- split(usage_lines, usage_ids)

  # lint if any of the usage sections are invalid
  valid <- TRUE

  for (usage in usages) {

    if (length(usage) == 3) {

      # the name
      name <- usage[1]
      # must be lowercase
      name_lower <- identical(name, tolower(name))
      # and have a bullet point
      name_bulleted <- startsWith(name, "- ")
      name_valid <- name_lower & name_bulleted

      # the code
      code <- usage[2]
      # must start and end with backticks
      code_valid <- startsWith(code, "`") & endsWith(code, "`")

      # the third line must be blank
      blank <- usage[3]
      blank_valid <- blank == ""

      usage_valid <- name_valid & code_valid & blank_valid

    } else {

      usage_valid <- FALSE

    }

    if (!usage_valid) {
      valid <- FALSE
    }

  }


}

# a list of the linters we are going to run on our markdown file
tl_page_linters <- list(title_hash_linter,
                        title_ns_fun_linter,
                        description_lowercase_linter,
                        number_of_lines_linter,
                        line_length_linter,
                        blank_lines_linter,
                        usage_entry_linter)

