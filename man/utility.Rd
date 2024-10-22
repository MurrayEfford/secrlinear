\name{utility}
\alias{make.sldf}
\alias{snapPointsToLinearMask}
\alias{asgraph}
\alias{getLineID}
\alias{branched}

\title{ Utility Functions }

\description{

  Utilities for various functions

  -- conversion of a flat table of coordinates for a line or set of
  lines to a SpatialLinesDataFrame object

  -- snapping points from objects of various types (traps, popn, matrix
  etc.) to a linearmask object.

  -- converting distances along a linear mask to x-y coordinates

  -- build igraph network from linearmask object

}

\usage{

make.sldf(coord, f)

snapPointsToLinearMask(xy, mask)

asgraph(mask)

getLineID(mask, laboffset = rep(spacing(mask) * 3, 2), ...)

branched(mask)

}

\arguments{
  
  \item{coord}{ dataframe of coordinates - must include columns 'x','y'}
  
  \item{f}{vector of values by which to split coord rows}
  
  \item{xy}{any object that may be coerced to a 2-column matrix (columns
    interpreted as x- and y-coordinates)}
  
  \item{mask}{`linearmask' object}
 
  \item{laboffset}{offset of label from point}

  \item{...}{ other arguments passed to \code{\link{plot.linearmask}} }

}

\details{

In \code{make.sldf}, if \code{f} is missing and there is a column `lineID' in `coord' then this
will be used instead.

\code{snapPointsToLinearMask} shifts each point in the input to the
nearest point on the graph stored as the `graph' attribute of \code{mask}.

\code{\link{make.line}} creates a `traps' object with equally spaced or clustered 
detectors.

\code{asgraph} is a utility function used internally for expressing the
points in \code{mask} as an igraph network (Csardi and Nepusz 2006). 

\code{getLineID} plots the mask and for each mouse click displays the
corresponding point and LineID.

Other utilities specific to editing graphs are documented in \link{edges}.

}

\value{

  For \code{make.sldf}, a SpatialLinesDataFrame.

  For \code{snapPointsToLinearMask}, the output has the same attributes (including class) as
  the \code{xy} input: only the coordinates themselves may change.

  For \code{alongmask}, a 2-column dataframe with the x and y
  coordinates of the points.

  For \code{asgraph}, an object of class `igraph'

  \code{getLineID} invisibly returns a dataframe with columns 'Point'
  and 'LineID'.
  
  For \code{branched}, a logical value indicating whether the degree of any node exceeds 2.
  
}

\seealso{

  \code{\link{checkmoves}}
  \code{\link{make.line}}, \code{\link{networkdistance}},
  \code{\link[sp]{SpatialLinesDataFrame}},
  \code{\link{showedges}}, \code{\link{deleteedges}}, \code{\link{addedges}}

}

\references{

  Csardi, G. and Nepusz, T. (2006) The igraph software package for complex network
  research, InterJournal, Complex Systems 1695. \url{https://igraph.org/}.
  
}

\examples{

## test make.sldf()

coord <- data.frame(x = c(1,2,3,1.05,2.05,3.05),
    y = c(3,2,2,3.05,2.05,2.05))

sldf1 <- make.sldf(coord)
sldf2 <- make.sldf(coord, f = c(1,1,1,2,2,2))

if (require('sp')) {
  plot(sldf1)
  plot(sldf2)
}

## test snapPointsToLinearMask()

\dontrun{

x <- seq(0, 4*pi, length = 200)
xy <- data.frame(x = x*100, y = sin(x)*300)
mask <- read.linearmask(data = xy, spacing = 20)
plot(mask)
## click several points, right-click and select 'stop'
pts <- locator()
pts <- do.call(cbind, pts)
points(pts)
pts1 <- snapPointsToLinearMask(pts, mask)
segments(pts[,1], pts[,2], pts1[,1], pts1[,2])
points(pts1, pch = 16, col = 'red')
df <- data.frame(pts, pts1)
names(df) <- c('from.x', 'from.y', 'to.x', 'to.y')
df

}

## asgraph (called by networkdistance)
## see 'igraph' for further manipulation
grmask <- asgraph(glymemask)
if (require('igraph')) {
  summary(grmask)
}

}

\keyword{ manip }

