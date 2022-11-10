\name{sim.linearpopn}
\alias{sim.linearpopn}

\title{Simulate Animals on Lines}

\description{

 This function is a simple substitute for the \pkg{secr} function
 \code{sim.popn()} for the case of a linear habitat.

}

\usage{

sim.linearpopn(mask, D, N, Ndist = c('poisson', 'fixed'), ...)

}

\arguments{
  
  \item{mask}{linearmask object}
  \item{D}{numeric density animals / km}
  \item{N}{number of individuals}
  \item{Ndist}{ character string for distribution of total number of
    individuals }
  \item{...}{other arguments passed to \code{\link[secr]{sim.popn}}}
  
}

\details{

  The linearmask input represents a discretized line - essentially a chain
  of line segments. By default, each segment is populated with a Poisson number of
  individuals. The user may specify \code{D} or \code{N}.

  \code{D} may be a vector with one density per mask pixel, or a single
  number that will be applied across all pixels.

  If \code{Ndist = 'fixed'} then a constant number of individuals N are
  simulated in each trial; otherwise N has a Poisson distribution across
  trials. N = sum(\code{D}) x mask length if \code{D} is
  specified.

  This is a simplified wrapper for \code{\link[secr]{sim.popn}} called
  with \code{model2D = "linear"}.
  
}

\value{
  
  Object of class c(`linearpopn', `popn', `data.frame').

}

\seealso{

  \code{\link{linearpopn}}, \code{\link[secr]{sim.popn}}
  
}

\note{

  The population output from \code{sim.linearpopn} may be used unchanged
  with \pkg{secr} functions such as
  \code{\link[secr]{sim.capthist}}. However, to be faithful to the
  linear network you should set the `userdist' argument of
  \code{sim.capthist} to \code{networkdistance}.
  
}

\examples{

x <- seq(0, 4*pi, length = 200)
xy <- data.frame(x = x*100, y = sin(x)*300)
mask <- read.linearmask(data = xy, spacing = 10)
trps <- make.line(mask, n = 15, startbuffer = 1000, by = 30)

newmask <- clipmask(mask, trps, buffer = 200)

linpop <- sim.linearpopn(newmask, 200)
CH <- sim.capthist(trps, linpop, userdist = networkdistance)
plot(newmask)
plot(CH, add = TRUE)

secr.fit(CH, mask = mask, details = list(userdist = networkdistance))

}

\keyword{ datagen }
