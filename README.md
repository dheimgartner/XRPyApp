# XRPyApp

Minimal demonstration of XR (foreign language) interface with XRPython.

## Idea

We have some Python functionality (in `src`) that we want to use in R. The key is to generate `ProxyClasses` and `ProxyFunctions` that wrap this API. In particular the src repo needs to be added to the Python path, s.t. the modules can be imported. The `setPythonClass()` and `setPythonFunction()` calls require access to metadata and therefore need to be called in a load action. Alternatively, we could use a setup step (`src/tools` script) that generates the source code during development. For the latter approach you can refer to the `shakespeare` package (https://github.com/johnmchambers/shakespeare/).

## Some issues (notes to myself)

- `XRPython` does not support type hints (it was developed with Python2 and I made some minimal pull requests s.t. it works with Python3)...
- `devtools::load_all()` does not work with the load actions and the `pythonAddToPath.R` (you need to explicitly pass `"inst/python"` instead of default `"python"`). This is in particular annoying to generate the manpages with roxygen. So in order to work with `devtools::load_all()` you need to adjust the call like so `XRPython::pythonAddToPath("inst/python")`. But for the installation you need to remove the arg again...
- The `pythonAddToPath()` sets up a load action and the proxies load action works correctly (even with `devtools::load_all()` if the path is adjusted accordingly).