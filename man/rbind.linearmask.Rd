\name{rbind.linearmask}
\alias{rbind.linearmask}

\title{Combine linearmask Objects}

\description{
  
Form a new linearmask object by combining the underlying vertices and
drawing a new systematic sample.

}

\usage{
\method{rbind}{linearmask}(..., cleanskips = TRUE)
}

\arguments{
  
  \item{\dots}{one or more linearmask objects with the same spacing }
  \item{cleanskips}{logical; passed to internal function \code{make.linearmask}}

}

\details{

  The \pkg{sp} function \code{rbind} is used to combine the
  `SLDF' attributes of the inputs.

  If the input objects have a `graph' attribute then a new graph will be
  included in the output.

}

\value{

  A linearmask object
  
}

\seealso{

  \code{\link{read.linearmask}},
  \link{linearmask}, \code{\link{subset.linearmask}}

  
}

\examples{

x <- seq(0, 4*pi, length = 200)
xy <- data.frame(x = x*100, y = sin(x)*300)
xy2 <- data.frame(x = x*100, y = cos(x)*300)
test <- read.linearmask(data = xy, spacing = 20)
test2 <- read.linearmask(data = xy2, spacing = 20)

plot(rbind(test, test2))

}

\keyword{ manip }

