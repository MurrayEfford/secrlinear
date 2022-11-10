\name{networkdistance}
\alias{networkdistance}

\title{Network Distances}

\description{

  Simple network computation of distance between points along linear
  landscape features (e.g. rivers).
  
}

\usage{

networkdistance(xy1, xy2, geometry)

}

\arguments{
  
 \item{xy1}{2-column matrix or dataframe}

 \item{xy2}{2-column matrix or dataframe}

 \item{geometry}{`linearmask' object}

}

\details{

\code{networkdistance} computes the distance in metres between the
points in \code{xy1} and the points in \code{xy2}. The \code{geometry}
is a linearmask; if it is missing then it takes the value of \code{xy2},
which then of course must be a full linearmask. A network is taken from
the `graph' attribute of \code{geometry} or (if necessary) constructed
from the linearmask `on the fly', joining any points closer than
(\code{spacingfactor} x \code{spacing(geometry)}). Points in \code{xy1}
and \code{xy2} are first snapped to the nearest point in
\code{geometry}. The computed distance is the sum of the graph's edge
weights along the shortest path joining two points.

The commonest use of \code{networkdistance} is to calculate distances
between detectors (traps) and points on a linear mask. In this case it
is sufficient to provide two arguments only, as \code{xy2} serves as
both destination and geometry.

\code{networkdistance} meets the requirements for a user-defined
distance function (userdist) in \pkg{secr}. No parameter is estimated.

Use \code{\link{showpath}} to check network distances interactively.

}

\value{

  \code{networkdistance} --

  given \eqn{k} detectors and \eqn{m} mask
  points, a \eqn{k} x \eqn{m} matrix of distances.

  If called with no arguments \code{networkdistance} returns a
  zero-length character vector.

}

\seealso{
  
  \code{\link{read.linearmask}}, \code{\link{showpath}},
  \code{\link{asgraph}}
  
}

\examples{

x <- seq(0, 4*pi, length = 200)
xy <- data.frame(x = x*100, y = sin(x)*300)
mask <- read.linearmask(data = xy, spacing = 20)
trps <- make.line(mask, n = 15, startbuffer = 1000, by = 30)

## networkdistance; geometry in 'mask'
d <- networkdistance (trps, mask, mask)
dim(d)
head(d)

}

\keyword{ manip }
