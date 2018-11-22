# display a page, encoded as a length-one character vector
display  <- function (page) {

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

# display in the terminal
display_text <- function (page) {
  message(page)
}

#' @importFrom utils browseURL
# convert to html and display in the viewer
display_html <- function (page) {


  browser <- getOption("viewer")

  if (is.null(browser)) {

    # if the browser seems broken, produce a warning and use text instead
    warning( "To display html help files (your default option) you",
             "need to specify a default viewer. Try changing your",
             "viewer via options. Printing to console instead")

    display_text(page)

  }

  # otherwise continue with hrml display

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
