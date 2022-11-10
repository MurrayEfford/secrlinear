\name{make.line}
\alias{make.line}

\title{Linear Detector Array}

\description{

  Build \pkg{secr} `traps' object, positioning detectors along a
  predefined set of lines. \code{make.line} is in the same family as
  \pkg{secr} functions \code{\link{make.grid}} etc.
  
}

\usage{

make.line(SLDF, n = 10, startbuffer = 0, by = 20, endbuffer = 0, cluster
= NULL,
type = c("fixedstart", "randomstart", "centred"), detector = "multi")

}

\arguments{
  \item{SLDF}{linearmask object or SpatialLinesDataFrame from \pkg{sp}}
  \item{n}{maximum number of detectors (or clusters of detectors) per line}
  \item{startbuffer}{distance of first detector from start of line(s)}
  \item{endbuffer}{minimum distance of last detector from end of line(s)}
  \item{by}{ spacing between detectors (or clusters of detectors) (m)}
  \item{cluster}{numeric vector of within-cluster positions (m from
    start)}
  \item{type}{character}
  \item{detector}{ character value for detector type - "single", "multi" etc.}
}

\details{

  Detectors are placed independently on each line.
  
}

\value{

An object of class \code{traps} comprising a data frame of x- and
y-coordinates, the detector type ("single", "multi", or "proximity" etc.),
and possibly other attributes. The SpatialLinesDataFrame is retained as
attribute `SLDF'.

}

\seealso{
  
  \code{\link[secr]{make.traps}}
  
}

\examples{

x <- seq(0, 4*pi, length = 200)
xy <- data.frame(x = x*100, y = sin(x)*300)
mask <- read.linearmask(data = xy, spacing = 20)

trps <- make.line(mask, n = 15, startbuffer = 1000, by = 50)
plot(mask)
plot(trps, add = TRUE)

}

\keyword{ datagen }
