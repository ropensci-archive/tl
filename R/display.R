#' Display Page Documentation

#' Display a page, encoded as a length-one character vector
#'
#' @param page the page to display
#' @noRd
#' @return a message to the user in the console or viewer pane depending on
#'   user options
display  <- function(page) {

  # what type of help do we want
  type <- getOption("help_type")
  if (is.null(type)) {
    type <- "text"
  }

  types <- c("text", "html")
  type <- match.arg(tolower(type), types)

  # call the specific helpfile
  switch(type,
         html = display_html(page),
         text = display_text(page))

}

#' Display Page as Text
#'
#' Display in the terminal
#'
#' @param page the page to display
#' @noRd
#' @return a message to the console
display_text <- function(page) {
  message(format_text(page))
}

#' Display Page as HTML
#'
#' Display the page in the Viewer pane
#'
#' @param page the page to display
#' @noRd
#' @importFrom utils browseURL
#'
#' @return an HTML page to the Viewer pane
display_html <- function(page) {

  browser <- getOption("viewer")

  if (is.null(browser)) {

    # if the browser seems broken, produce a warning and use text instead
    warning("To display html help files (your default option) you",
            "need to specify a default viewer. Try changing your",
            "viewer via options. Printing to console instead")

    display_text(page)

  }

  # otherwise continue with html display

  # temporary files to store the markdown input and html output
  md_file <- tempfile(fileext = ".md")
  html_file <- tempfile(fileext = ".html")

  # write the text to a temporary file, so pandoc can read it in
  cat(page, file = md_file)

  # convert it to html, in a temporary file
  rmarkdown::pandoc_convert(md_file, to = "html", output = html_file)

  # display the html in the browser
  utils::browseURL(url = html_file, browser = browser)

}

#' Format Text Output
#'
#' Formats the document page output for nice display in the console
#'
#' @param page the text stream from the document page
#' @noRd
#' @return a text formatted version of the document page
format_text <- function(page) {
  tmp <- gsub("`", "  ", page)
  formatted_page <- gsub("# |#", "", tmp)

  formatted_page
}
