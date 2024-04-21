#' @export
foo <- function(.get = NA) {
  ev <- XRPython::RPython()
  XRPython::pythonAddToPath(package = "XRPyApp", evaluator = ev)

  ev$Import("recycleFunction", "recycle")
  ev$Import("beerClass", "Beer")

  ev$Command("beer = Beer('Quöllfrisch', 33)")
  ev$Command("recycle(beer)")
  ev$Command("beer.drink(33)")
  pant <- ev$Eval("recycle(beer)")

  if (!is.na(.get) & .get)
  {
    out <- ev$Get(pant)
  } else {
    out <- pant
  }

  return(pant)
}
