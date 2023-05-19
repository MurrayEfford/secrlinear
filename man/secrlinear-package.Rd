\name{secrlinear-package}
\alias{secrlinear}

\docType{package}

\title{Spatially Explicit Capture--Recapture for Linear Habitats }

\description{

An \pkg{secr} add-on package for linear habitat models. 
  
}

\details{
\tabular{ll}{
Package: \tab secrlinear\cr
Type: \tab Package\cr
Version: \tab 1.2.1\cr
Date: \tab 2023-05-19\cr
License: \tab GNU General Public License Version 2 or later\cr
}

The important functions in \pkg{secrlinear} are:
\tabular{ll}{
  \code{\link{read.linearmask}} \tab import and discretize a linear
  habitat map (route) \cr
  \code{\link{networkdistance}} \tab compute network distances between detectors
    and points using a linear habitat mask \cr
  \code{\link{sim.linearpopn}} \tab simulate population along linear mask \cr
  \code{\link{make.line}} \tab place detectors along
  (part of) a linear route \cr
}

Other useful functions are:
\tabular{ll}{
  \code{\link{checkmoves}} \tab check capthist object for extreme movements \cr
  \code{\link{showpath}} \tab interactive examination of network distances \cr
  \code{\link{clipmask}} \tab drop mask points outside buffer distance \cr
  \code{\link{rbind.linearmask}} \tab combine two linear masks \cr
  \code{\link{subset.linearmask}} \tab select part of a linear mask \cr
  \code{\link{asgraph}} \tab convert linear mask to igraph \cr
  \code{\link{snapPointsToLinearMask}} \tab closest point on graph \cr
  \code{\link{make.sldf}} \tab convert coordinates to SpatialLinesDataFrame \cr
}

Documentation is provided in a vignette
\url{../doc/secrlinear-vignette.pdf} and in the pdf version of the help
pages \url{../doc/secrlinear-manual.pdf}

The package draws on the packages \pkg{sp} (Pebesma and Bivand 2005) and
\pkg{igraph} (Csardi and Nepusz 2006).

In order to fit a linear-habitat model with the \pkg{secr} function \code{secr.fit}:

\enumerate{
  \item specify a linear mask for the `mask' argument
  \item specify \code{details = list(userdist = networkdistance)} so
  that \code{secr.fit} uses network distances rather than Euclidean distances.
}

An example dataset \link{arvicola} is drawn from trapping of water voles \emph{Arvicola
  amphibius} in June 1984 along the River Glyme in the U.K. -- the relevant linear
mask is \link{glymemask}.

A more complex linear network (\link{Silverstream}) is provided as an ESRI shapefile.

}

\seealso{

\code{\link{addedges}},
\code{\link{asgraph}},
\code{\link{checkmoves}},
\code{\link{clipmask}},
\code{\link{deleteedges}},
\code{\link{linearmask}},
\code{\link{linearpopn}},
\code{\link{make.line}},
\code{\link{make.sldf}},
\code{\link{networkdistance}},
\code{\link{plot.linearmask}},
\code{\link{rbind.linearmask}} ,
\code{\link{read.linearmask}},
\code{\link{showpath}},
\code{\link{showedges}},
\code{\link{sim.linearpopn}},
\code{\link{snapPointsToLinearMask}},
\code{\link{subset.linearmask}} 
}

\references{

 Csardi, G. and Nepusz, T. (2006) The igraph software package for complex network
  research. \emph{InterJournal, Complex Systems} \bold{1695}. \url{https://igraph.org/}.

 Pebesma, E.J. and Bivand, R. S. (2005) Classes and methods for spatial
  data in R. \emph{R News} \bold{5}(\bold{2}), \url{https://cran.r-project.org/doc/Rnews/}.

}

\author{ Murray Efford \email{murray.efford@otago.ac.nz} }

\examples{

## Water voles in June 1984 on the R. Glyme in Oxfordshire, UK
## capture and trap location files are exactly as for a 2-D analysis

inputdir <- system.file("extdata", package = "secrlinear")
arvicola <- read.capthist(captfile = paste0(inputdir, "/Jun84capt.txt"), 
    trapfile = paste0(inputdir, "/glymetrap.txt"), detector = "multi", 
    covname = "sex")

## Import map of linear habitat
## -- from text file of x-y coordinates
glymemask <- read.linearmask(file = paste0(inputdir, "/glymemap.txt"), spacing = 4)
## -- from a previously constructed SpatialLinesDataFrame
SLDF <- as(sf::st_read(paste0(inputdir,"/glymemap.shp")), 'Spatial')
glymemask <- read.linearmask(data = SLDF, spacing = 4)

## display the mask and capture data
plot (glymemask)
plot(arvicola, add = TRUE, tracks = TRUE)
plot(traps(arvicola), add = TRUE)

## fit model, estimate density
linearfit <- secr.fit(arvicola, mask = glymemask, trace = FALSE,
    details = list(userdist = networkdistance))
predict(linearfit)

## NOTE : the unit of density (D) is animals / km
}

\keyword{ package }
