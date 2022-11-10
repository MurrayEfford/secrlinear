\name{subset.linearmask}
\alias{subset.linearmask}

\title{Select Part of linearmask Object}

\description{

  Methods to subset linear mask objects.

}

\usage{

\method{subset}{linearmask}(x, subset, LineID, droplinesbeyond = Inf, ...)

}

\arguments{
  \item{x}{linearmask object from \code{\link{read.linearmask}}}
  \item{subset}{numeric or logical vector to select rows of mask}
  \item{LineID}{vector of identifiers for lines to retain}
  \item{droplinesbeyond}{logical; distance criterion for dropping lines (m)}
  \item{\dots}{other arguments (not used)}
}

\details{

Specify only one of `subset' and `LineID'.

If the input object has a `graph' attribute then a new graph will be
included in the output.

\code{subset.linearmask} leaves the underlying SpatialLinesDataFrame
intact unless either (i) \code{LineID} is specified, or (ii) a finite value is provided for \code{droplinesbeyond}. \code{droplinesbeyond} retains lines that have at least one point within the specified distance of at least one mask point, after subsetting.
   
}

\value{

  A linearmask object.
  
}

\seealso{

   \code{\link{read.linearmask}}, \link{linearmask}
  
 }
 
\examples{


## rbind two linear masks,
x <- seq(0, 4*pi, length = 200)
xy <- data.frame(x = x*100, y = sin(x)*300)
xy2 <- data.frame(x = x*100, y = cos(x)*300)
test <- read.linearmask(data = xy, spacing = 10)
test2 <- read.linearmask(data = xy2, spacing = 10)
test3 <- rbind(test, test2)
table(covariates(test3)$LineID)

## then retrieve one... 
test4 <- subset(test3, LineID = '1.1')

## ... or the other
test5 <- subset(test3, LineID = '2.1')
}

\keyword{ manip }

