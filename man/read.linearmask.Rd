\name{read.linearmask}
\alias{read.linearmask}

\title{Import Linear Habitat Mask}

\description{
  
  Construct a linearmask from line data in a text file, a polyline shapefile, a dataframe or a SpatialLinesDataFrame object.
  
}

\usage{

read.linearmask(file = NULL, data = NULL, spacing = 10, spacingfactor =
1.5, graph = TRUE, cleanskips = TRUE,  ...)

}

\arguments{
  
  \item{file}{file name}
  
  \item{data}{data frame or SpatialLinesDataFrame}
  
  \item{spacing}{length of each discretized segment}
    
  \item{spacingfactor}{numeric criterion for joining mask points}

  \item{graph}{logical; if TRUE the \pkg{igraph} representation of the
    mask is saved as an attribute}

  \item{cleanskips}{logical; if TRUE then \code{\link{cleanskips}} is
  applied to the graph}
    
  \item{\dots}{other arguments passed to \code{read.table} for file input }
  
}

\details{
  
  Only one of `file' or `data' should be specified. The file name should include 
  the extension (e.g., "silverstream.shp").
  
  Input from a text file, polyline shapefile or dataframe is first converted to a
  SpatialLinesDataFrame object. Points are spaced equally along each SpatialLine, 
  starting at spacing / 2.

  For dataframe input via \code{data} the coordinates are expected to be
  in columns `x' and `y'; if these names are missing, or input is from a
  file, the first two columns are used.

  \code{spacingfactor} is used by \code{\link{asgraph}} to determine
  which points are joined when computing distances. It should be between
  1 and 2.
  
}

\value{
  
  A `linearmask' object, i.e. a `mask' object in which each point
  represents a line segment of length \code{spacing}, and with
  additional attributes `SLDF', `spacingfactor' and possibly `graph' (see
  \link{linearmask}).  }

\seealso{
  
  \code{\link{asgraph}},
  \code{\link{linearmask}},
  \code{\link{make.sldf}},
  \code{\link{networkdistance}},
  \code{\link{SpatialLinesDataFrame}}
 
}

\note{

A valid shapefile includes at least three files with extensions `.shp', `.dbf' and `.shx'. The full name of the .shp file is provided as the `file' argument of \code{read.linearmask}. 

Line-level covariates are copied from SpatialLinesDataFrame input. Point-specific covariates may be added
later using \code{\link[secr]{covariates}} or \code{\link[secr]{addCovariates}}.

}

\examples{

x <- seq(0, 4*pi, length = 200)
xy <- data.frame(x = x*100, y = sin(x)*300)
test <- read.linearmask(data = xy, spacing = 20)
plot(test)

xy2 <- data.frame(x = x*100, y = cos(x)*300)
test2 <- read.linearmask(data = xy2, spacing = 20)

plot(test2, add = TRUE)

}

\keyword{ IO }
