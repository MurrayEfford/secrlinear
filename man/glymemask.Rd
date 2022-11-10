\name{glymemask}
\docType{data}

\alias{glymemask}

\title{ Linear Mask for Water Vole Dataset }

\description{

Habitat geometry for a trapping study of water voles (\emph{Arvicola amphibius})
along a river in Oxfordshire, U.K., used in conjunction with the capture
dataset \link{arvicola}.

}

\usage{glymemask}

\format{A linearmask object (see \code{\link{read.linearmask}})}

\details{

Water voles were trapped monthly from May 1984 to May 1985 along 0.9 km
of the River Glyme in Oxfordshire, U.K. (Efford 1985).
  
The raw data are provided both as a text file and as a shapefile in the
`extdata' folder of the \pkg{secrlinear} installation. The vignette
\url{../doc/secrlinear-vignette.pdf} shows how to import the data, which
are also provided here as an \pkg{secr} object.

}

\source{

M. G. Efford unpublished data.

}

\seealso{\link{arvicola}}

\references{

 Efford, M. G. (1985) \emph{The structure and dynamics of water vole
 populations}. D.Phil thesis, University of Oxford.

}

\examples{

plot(glymemask)
summary(glymemask)

## add a covariate, the distance downstream from the first mask point
downstrm <- networkdistance(glymemask, glymemask[1,], glymemask)[,1]
covariates(glymemask)<- data.frame(downstream = downstrm)

}

\keyword{datasets}
