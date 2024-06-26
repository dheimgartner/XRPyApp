% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/XRPyApp-package.R
\docType{package}
\name{XRPyApp-package}
\alias{XRPyApp}
\alias{XRPyApp-package}
\title{XRPyApp: Minimal demonstration of XR interface with XRPython}
\description{
Demonstrates how we can call python functionality (classes and functions) with help of the XRPython interface. Further shows how and why load actions need to be specified.
}
\examples{
library(XRPyApp)

beer <- Beer("Feldschlössli", 33)
beer$drink(33)
pant <- recycle(beer)
}
\author{
\strong{Maintainer}: Daniel Heimgartner \email{d.heimgartners@gmail.com} (\href{https://orcid.org/0000-0002-0643-8690}{ORCID})

}
