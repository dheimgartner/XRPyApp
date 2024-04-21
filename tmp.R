Beer_Python <- XR::setProxyClass("Beer", module = "beerClass",
                                 evaluatorClass = "PythonInterface", language = "Python", proxyObjectClass = "PythonObject",
                                 methods = list(),
                                 fields = list(
                                   brand = function (value)
                                   {
                                     proxy <- get(".proxyObject", envir = .self)
                                     if (missing(value))
                                       .ev$Eval("%s.brand", proxy)
                                     else {
                                       .ev$Command("%s.brand = %s", proxy, value)
                                       invisible(value)
                                     }
                                   },
                                   remaining = function (value)
                                   {
                                     proxy <- get(".proxyObject", envir = .self)
                                     if (missing(value))
                                       .ev$Eval("%s.remaining", proxy)
                                     else {
                                       .ev$Command("%s.remaining = %s", proxy, value)
                                       invisible(value)
                                     }
                                   },
                                   size = function (value)
                                   {
                                     proxy <- get(".proxyObject", envir = .self)
                                     if (missing(value))
                                       .ev$Eval("%s.size", proxy)
                                     else {
                                       .ev$Command("%s.size = %s", proxy, value)
                                       invisible(value)
                                     }
                                   }
                                 )
)

Beer_Python$methods(
  initialize = function (..., .evaluator, .serverObject)
  {
    if (missing(.evaluator)) {
      if (missing(.serverObject))
        .evaluator <- XR::getInterface("PythonInterface",
                                       .makeNew = FALSE)
      else .evaluator <- XR::proxyEvaluator(.serverObject)
    }
    if (!nargs() && is.null(.evaluator))
      return()
    if (missing(.serverObject)) {
      if (is.null(.evaluator))
        .evaluator <- XR::getInterface("PythonInterface")
      .evaluator$Import("beerClass")
      .serverObject <- .evaluator$New("Beer", "beerClass",
                                      ...)
    }
    else if (!missing(...))
      initFields(...)
    if (is(.serverObject, "ProxyClassObject"))
      proxy <- .serverObject$.proxyObject
    else proxy <- .serverObject
    .proxyObject <<- proxy
    .ev <<- .evaluator
  },

  ServerClassInfo = function ()
    list(ServerClass = "Beer", ServerModule = "beerClass", language = "Python",
         evaluatorClass = "PythonInterface", proxyFields = c("brand",
                                                             "remaining", "size"), proxyMethods = c("initialize", "ServerClassInfo",
                                                                                                    "drink"), proxyContains = character(0), proxyObjectClass = "PythonObject"),

  drink = function (..., .ev = XRPython::RPython(), .get = NA)
  {
    "Python Method: drink(sip =)\nTake a sip"
    nPyArgs <- length(substitute(c(...))) - 1
    if (nPyArgs > 1)
      stop("Python function drink() only allows 1 argument; got ",
           nPyArgs)
    .ev$MethodCall(.proxyObject, "drink", ..., .get = .get)
  })


