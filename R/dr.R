dr <- function(fun, namespace = NULL){

  # deparse the function & namespace
  fun <- deparse(substitute(fun))
  namespace <- deparse(substitute(namespace))

  warn = FALSE
  # if namespace == NULL & !grep("::", fun) search path

  # If !is.null(namespace) query
  if(!is.null(namespace)){
    f <-  fun
    ns <-  namespace
  }

  # If fun contains namespace, return from specified namespace
    #if !is.null(namespace) warn
  if(grepl("::", fun)) {
    if(!is.null(namespace)) warn = TRUE
    x <- strsplit(fun, "::")
    f <- x[[1]]
    ns <- x[[2]]
  }

  # Error -
  if(!grepl("::", fun) & namespace == "NULL") {
    stop("No namespace provided")
  }

  # query(f, ns, warn)
}

query <- function(f, ns, warn = FALSE){
  #searches ns for f, prints.
  print()
}
