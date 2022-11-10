\name{clipmask}
\alias{clipmask}

\title{Drop Points Distant From Detectors}

\description{
  
\code{clipmask} may be used to drop superfluous points from a mask
(those further than \code{buffer} from any detector).

}

\usage{
clipmask(mask, traps, buffer = 100, clipvert = FALSE)
}

\arguments{
  
  \item{traps}{`traps' object from \pkg{secr}}

  \item{mask}{`linearmask' object}

  \item{buffer}{network distance for retaining mask points (m)}

  \item{clipvert}{logical; if TRUE the underlying lines are also
  clipped}

}
\details{

  None yet.
  
}
\value{

  `linearmask' object retaining only points within \code{buffer} m of
  any trap. By default, the `SLDF' attribute is
  unchanged.

  \code{clipvert = TRUE} causes the attribute ``SLDF'' (a
  SpatialLinesDataFrame) to be clipped to within spacing/2 of detectors,
  using functions from \pkg{rgeos} (Bivand and Rundel 2014).

}

\seealso{
  
  \code{\link{make.line}}
  
}

\references{

  Bivand, R. and Rundel, C. (2014) rgeos: Interface to Geometry
  Engine - Open Source (GEOS). R package version 0.3-4.
  \url{https://CRAN.R-project.org/package=rgeos/}

}

\examples{
x <- seq(0, 4*pi, length = 200)
xy <- data.frame(x = x*100, y = sin(x)*300)
mask <- read.linearmask(data = xy, spacing = 20)

## clipmask
trps <- make.line(mask, n = 15, startbuffer = 1000, by = 30)
newmask <- clipmask(mask, trps, buffer = 200)
plot(newmask)
plot(trps, add = TRUE)

if (require('rgeos')) {
  newmask <- clipmask(mask, trps, buffer = 200, clipvert = TRUE)
  plot(newmask)
  plot(trps, add = TRUE)
}

}

\keyword{ manip }
