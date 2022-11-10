\name{plotmethods}
\alias{plot.linearpopn}
\alias{plot.linearmask}

\title{Plot Methods for linearmask and linearpopn objects}

\description{

  Custom plotting.

}

\usage{

\method{plot}{linearpopn}(x, ..., jitter = 0, plotline = TRUE)

\method{plot}{linearmask}(x, ..., linecol = 'black', label = FALSE, 
                laboffset = c(spacing(x), 0))

}

\arguments{
  \item{x}{linearpopn object from \code{\link{sim.linearpopn}}, or a
  linearmask object from \code{\link{read.linearmask}}}
  
  \item{\dots}{For \code{plot.linearpopn}: other arguments passed to \code{\link[secr]{plot.popn}}(may include \code{add = TRUE}).  
    For \code{plot.linearmask}: other arguments passed to \code{\link[secr]{plot.mask}}
  (e.g., col, cex, add), to \code{\link{legend}} (pt.cex) or to the plot method for SpatialLines (lwd, lty)}
  
  \item{jitter}{numeric value for jittering}
  
  \item{plotline}{logical; if TRUE the mask line is overplotted in grey}
  
  \item{linecol}{line colour for linear habitat (see Color Specification
    in \code{\link[graphics]{par}})}
  
  \item{label}{logical; if TRUE each vertex is numbered}
  
  \item{laboffset}{offset of label from point (metres) }
  
}

\details{

  The linear mask used for plotting a `linearpopn' is the one saved as
  an attribute of the object.
  
  The main plotting in \code{plot.linearmask} is done by
  \code{plot.mask} with \code{dots = TRUE}. See the help for
  \code{\link{plot.mask}} for details of options such as \code{add}. The
  lines of the SpatialLinesdataFrame are overplotted unless
  \code{linecol = NA}.
  
  Jittering shifts points by a random uniform distance -- (\eqn{\pm 0.5
    \times} \code{jitter}) x mask spacing -- on both axes. This can give
    a better impression of density when points coincide.

  The option in\code{plot.popn} for plotting rectangular `frame' is
  suppressed: do not attempt to pass this argument in \dots. 

  
}

\value{

  \code{plot.linearpopn} does not return a value.
  
  \code{plot.linearmask} invisibly returns legend details as for \code{\link{plot.mask}}.
  
}

\seealso{

   \code{\link{sim.linearpopn}},  \code{\link{plot.mask}}, \code{\link[secr]{plot.popn}}
  
 }
 
\examples{
x <- seq(0, 4*pi, length = 200)
xy <- data.frame(x = x*100, y = sin(x)*300)
mask <- read.linearmask(data = xy, spacing = 10)
linpop <- sim.linearpopn(mask, 100)
plot(linpop, jitter = 2)

plot(mask)

## thicker band of grey points, dashed line
plot(mask, cex = 2, lty = 2)

## add a covariate, the distance downstream from the first mask point
downstrm <- networkdistance(glymemask, glymemask[1,], glymemask)[,1]
covariates(glymemask)<- data.frame(downstream = downstrm)

## point colour determined by a covariate
plot(glymemask, cex = 2, covariate = 'downstream', pt.cex = 2)

## point size determined by a covariate
plot(glymemask, cex = covariates(glymemask)$downstream/50, pch = 21)

}

\keyword{ hplot }

