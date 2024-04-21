devtools::load_all()
# Interesting: Makefile in src is run too...

## On debugging methods
library(XRPython)
ev <- RPython()
debugonce(ev$Command)
ev$Command("print('hello debug')")

# using trace
ev$trace("Command", tracer = browser)
ev$Command("print('hello debug')")

# This works for specific objects. I.e. not for all PythonInterface$Command() calls


debugonce(foo)
foo()

library(XRPython)

ev <- RPython()

directory <- "python"
system.file(directory, package = "XRPyApp")  # why does this work top level but not in ev$AddToPath()? i.e. it does not work if system.file is called from another package... (this is a known "issue"...)

ev$AddToPath("python", package = "XRPyApp")
pythonAddToPath("inst/python", package = "XRPyApp", evaluator = ev)  # for now inst/python -> in pkg functions you would use without inst (see foo.R but only works if package installed Ctrl + Shift + B)

ev$Import("recycleFunction", "recycle")
ev$Import("beerClass", "Beer")

# pythonShell()

ev$Command("beer = Beer('Quöllfrisch', 33)")
ev$Command("recycle(beer)")
ev$Command("beer.drink(33)")
ev$Command("recycle(beer)")
proxy <- ev$Eval("recycle(beer)")
proxy_converted <- ev$Get(proxy)
proxy_converted
class(proxy_converted)
pant <- proxy_converted@fields$pant



# Understand Eval, Command, Get, Send (with simple built in functions and types) and Call

devtools::load_all()

library(XRPython)

ev <- RPython()

# reinstall <- function() {
#   remove.packages("XRPython")
#   install.packages("~/github/forks/XRPython", repos = NULL)
# }
#
# reinstall()


## Eval (.get)
ev$help("Eval")
ev$Eval
# Calls ServerEval(ServerExpression(expr, ...))
# These are generic functions, right? So the XRPython package extends these

# ev$trace("Eval", quote(browser(skipCalls = 1)))

xx <- ev$Eval("[1, %s, 5]", pi)
xx_ <- ev$Eval("[1, 2, 3]", .get = TRUE)
ev$Command("import numpy as np")
xy <- ev$Eval("np.array([1, 2, 3])")
xy
# xy_ <- ev$Get(xy)

# ev$untrace("Eval")

xx <- ev$Send(c(1, pi, 5))
xy <- ev$Get(xx)
xy


## Command
ev$Command("x = [1, 2, 3, 4]")
x <- ev$Eval("x")
x_ <- ev$Get(x)

# equivalent
expr <- "print(f'This is x: {x}')"
pythonCommand(expr, evaluator = ev)

# or use the proxy object
ev$Command("print(%s)", x)



## Call
# vectorR is a python function
ev$Call("vectorR", x, "numeric", .get = TRUE)
ev$Call("vectorR", x, "character", .get = TRUE)


## With my functions
ev$AddToPath("inst/python", package = "XRPyApp")
ev$Import("recycleFunction", "recycle")
ev$Import("beerClass", "Beer")

beer <- ev$Eval("Beer('Quöllfrisch', 33)")
ev$Call("recycle", beer)  # returns NULL or object of class Pant

ev$Get

# ev$trace("Eval", quote(browser(skipCalls = 1)))
ev$Get(beer)
# I think if you want to overwrite the default conversion, you could write a
# method for asRObject generic? Or generate a proxy class (see further below).

library(XR)
method.skeleton("asRObject", "Beer", file = stdout())
setMethod("asRObject",
          signature(object = "Beer"),
          function (object, evaluator)
          {
            cat("Overwritten conversion\n")
          }
)

# XR::valueFromServer()
XR::objectAsJSON(beer)
ev$Get(beer)


## Understand need for tools folder (see page 285) -> read again on load actions and setup steps (in package chapter)
con <- file("tmp.R", "w")
debugonce(setPythonClass)  # this is some serious meta programming!
setPythonClass("Beer", "beerClass", save = con)
close(con)
Beer <- setPythonClass("Beer", "beerClass")  # This cannot be called in an R src script since it involves metaprogramming and metainfo from the evaluator
# BUT: if the package developer runs it (such as above), the resulting generated R script can be executed (as it retrieved the metainfo already)!
beer <- Beer("Feldschlössli", 33)
sloop::otype(beer)
beer$drink(10)


## Resolve add to path weirdness and import error
# more or less understood -> see first lines

## Create proxyFunctions and Classes (see also above output to tmp.R)
# start new session
devtools::load_all()
library(XRPython)
ev <- RPython()
pythonAddToPath("inst/python", package = "XRPyApp", evaluator = ev)
source("./tmp.R")
beer <- Beer_Python(.evaluator = ev)
beer$drink()

# somehow needs to setup load action for this to work with arbitrary evaluator...

# default conversion
recycle <- XRPython::PythonFunction("recycle", "recycleFunction")
recycle
recycle@serverDoc
recycle@serverArgs
recycle(beer)
beer$drink(28)
pant <- recycle(beer)
pant. <- ev$Get(pant)
pant.@fields

# let's create a ProxyClass for Pant and check the returned object of recycle() again
pant <- setPythonClass("Pant", "beerClass")
test <- recycle(beer)
class(test)
test$pant

# again, we want to create the proxy function and classes as load action / setup step...
# -> See zzz.R and pythonAddToPath.R

## Make sure everything is installable





