\name{showpath}
\alias{showpath}

\title{Display Shortest Path}

\description{

  An interactive function to examine shortest paths and the associated network
  distances within a linear mask.
  
}

\usage{

showpath(mask, add = FALSE, ...)

}

\arguments{

  \item{mask}{linearmask object}
  \item{add}{logical; if TRUE the plot is added to an existing plot}  
  \item{...}{other arguments passed to \code{\link[graphics]{lines}} for drawing
  network path}
    
}


\details{

  The selected points are snapped to the nearest mask point before any
  calculations.
  
  The path shown is a shortest path as determined by function
\code{\link[igraph]{get.shortest.paths}} of the \pkg{igraph}
package. There may be others.

}

\value{
  Invisibly returns a list comprising 
  \item{paths}{a list of dataframes, each with the mask coordinates along a selected path}
  \item{results}{a dataframe with one row for each path giving the distances for each pair of
  points (columns `from', `to', `Euclidean.d', `network.d')}.

}

\references{

  Csardi, G. and Nepusz, T. (2006) The igraph software package for complex network
  research, InterJournal, Complex Systems 1695. \url{https://igraph.org/}.

}

\seealso{
  
  \code{\link{networkdistance}}
  
}

\examples{

\dontrun{

x <- seq(0, 4*pi, length = 200)
xy <- data.frame(x = x*100, y = sin(x)*300)
xy2 <- data.frame(x = x*100, y = cos(x)*300)
test <- read.linearmask(data = xy, spacing = 10)
test2 <- read.linearmask(data = xy2, spacing = 10)
test3 <- rbind(test, test2)
showpath(test3, lwd = 5)

}

}

\keyword{ manip }

