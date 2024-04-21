# XRPyApp

Minimal demonstration of XR (foreign language) interface with XRPython.

## Idea

We have some Python functionality (in `inst/python`) that we want to use in R. The key is to generate `ProxyClasses` and `ProxyFunctions` that wrap this API. In particular the src repo needs to be added to the Python path, s.t. the modules can be imported. The `setPythonClass()` and `setPythonFunction()` calls require access to metadata and therefore need to be called in a load action. Alternatively, we could use a setup step (`inst/tools` script) that generates the source code during development. For the latter approach you can refer to the `shakespeare` package (https://github.com/johnmchambers/shakespeare/).

## Might be of interest

The `XRPython` package uses `reticulate` under the hood (but conveys the idea of the `XR` interface structure). Reticulate uses an **embedded** Python interpreter. You can refer to the `src` folder for a minimal hint how this works. An alternative would be to use an **external** process (s.a. the `XRJulia` package). In particular, this would be non-blocking but the IPC might be a little less efficient than when embedded... (?)

## Some issues (notes to myself)

- `XRPython` does not support type hints (it was developed with Python2 and I made some minimal pull requests s.t. it works with Python3)...
- `devtools::load_all()` does not work with the load actions and the `pythonAddToPath.R` (you need to explicitly pass `"inst/python"` instead of default `"python"`). This is in particular annoying to generate the manpages with roxygen. So in order to work with `devtools::load_all()` you need to adjust the call like so `XRPython::pythonAddToPath("inst/python")`. But for the installation you need to remove the arg again...
- The `pythonAddToPath()` sets up a load action and the proxies load action works correctly (even with `devtools::load_all()` if the path is adjusted accordingly).