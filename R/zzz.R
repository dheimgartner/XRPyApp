.onLoad <- function(libname, pkgname = "XRPyApp") {
  cat(".oLoad() is called...\n")
  cat(libname, "\n")
  # function definition here would not be available from package namespace...
}

setLoadActions(
  function(ns) {
    cat("Loaded package", sQuote(getNamespaceName(ns)),
        "at", format(Sys.time()), "\n")
  },
  function(ns) {
    hello_load_action <- function() {
      cat("Hello load action\n")
      cat("Returning namespace\n")
      return(ns)
    }
    assign("hello_load_action", hello_load_action, envir = ns)
  },
  proxies = function(ns) {
    Beer <- XRPython::setPythonClass("Beer", "beerClass")
    assign("Beer", Beer, envir = ns)

    Pant <- XRPython::setPythonClass("Pant", "beerClass")
    assign("Pant", Pant, envir = ns)

    recycle <- XRPython::PythonFunction("recycle", "recycleFunction")
    assign("recycle", recycle, envir = ns)
  }
)

#' Demonstrates a load action
#'
#' @name hello_load_action
#' @export
hello_load_action <- function() NULL
