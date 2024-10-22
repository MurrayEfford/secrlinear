% File linearmask.object.Rd
% Part of the R package secrlinear

\name{linearmask.object}

\title{Description of Linear Mask Objects}
\alias{linearmask}

\description{
  
  An object of class \code{linearmask} maps linear habitat, such
  as a river, in a way that is useful for spatially explicit
  capture--recapture analysis.  The object contains two representations
  of the linear habitat: as features in a SpatialLinesDataFrame, and
  discretized as a set of equally spaced points, as in a mask object
  from \pkg{secr}.

  Usually the object was created in a call to
  \code{\link{read.linearmask}}, which performs the discretization given
  linear input data and a chosen spacing.

  A linearmask object does not explicitly include topological
  information i.e. the branching pattern of river networks. Instead, a
  network is constructed on-the-fly in \code{\link{asgraph}} by joining
  adjacent mask points (those within a certain small Euclidean
  distance). This results in 'shortcut' edges where lines approach at an
  acute angle (see the Examples for a demonstration).

  A more complete, but also more cumbersome, solution for
  river networks might be to adapt the SpatialStreamNetwork object class
  of the \pkg{SSN} package (ver Hoef et al. 2014). Data input for
  \pkg{SSN} requires pre-processing in the proprietary software ArcGIS.

}

\value{
  
  The object itself is a dataframe of coordinates for the points
  comprising the mask, as for a 2-dimensional habitat mask (\link[secr]{mask}).

  Additional information is stored as attributes (these usually remain
  hidden, but are essential except for `graph'):
  
  \item{spacingfactor}{The spacing factor determines which
    points in a linear mask are joined to form a linear network, as
    happens automatically when computing distances with
    \code{\link{networkdistance}}. Points are joined when their Euclidean
    separation is less than spacingfactor x spacing. The default value
    is 1.1.}

  \item{SLDF}{The SLDF attribute is a SpatialLinesDataFrame
    (defined in \pkg{sp}) that provides the underlying description of the
    linear habitat.}

  \item{graph}{\pkg{igraph} network. Optionally computed by \code{\link{read.linearmask}}
  and saved as attribute, or computed on the fly by \code{\link{networkdistance}}}.
  
  \item{covariates}{A required dataframe of covariate values, including at least the column `LineID'}

  Other attributes are common to masks and linearmasks:

  \item{spacing}{In this context, the length of habitat in metres that is associated with
    each mask point (segment length).}

  \item{meanSD}{A matrix with mean and standard deviation of
    coordinates.}
  
  \item{boundingbox}{In this context, a dataframe giving the coordinate
    ranges spanned by the SLDF. Differs from 2-D mask in not being 'buffered' by spacing/2.}
  
  
  Further attributes of 2-dimensional masks (area, polygon etc.) are not
  relevant but may be present. The object has class
  \code{c("linearmask", "mask", "data.frame")} or \code{c("list",
  "linearmask", "mask", "data.frame")} for a multi-session linear mask.
  }

\seealso{
    
  \code{\link{read.linearmask}}, \code{\link[secr]{mask}},
  \code{\link{showpath}}, \code{\link{networkdistance}}

}

\references{

Ver Hoef, J. M., Peterson, E. E., Clifford, D. and Shah, R. (2014)
\bold{SSN} : an \R package for spatial statistical modeling on stream
networks. \emph{Journal of Statistical Software} \bold{56(3)}, 1--45.

}

\examples{

## make a complex linear mask
x <- seq(0, 4*pi, length = 200)
xy <- data.frame(x = x*100, y = sin(x)*300)
xy2 <- data.frame(x = x*100, y = cos(x)*300)
test <- read.linearmask(data = xy, spacing = 10)
test2 <- read.linearmask(data = xy2, spacing = 10)
test3 <- rbind(test, test2)

## visualize the igraph network used by networkdistance()
tmp <- asgraph(test3)
if(require('igraph')) {
  i2 <- get.edges(tmp,1:ecount(tmp))
  plot(test3, linecol = 'white', col = 'grey')
  segments(test3[i2[,1],1], test3[i2[,1],2], test3[i2[,2],1],
      test3[i2[,2],2], lwd=2, col='blue')
}
}
\keyword{S3class}
