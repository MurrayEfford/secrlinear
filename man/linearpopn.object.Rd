% File linearpopn.object.Rd
% Part of the R package secrlinear

\name{linearpopn.object}

\title{Description of Linear Population Objects}
\alias{linearpopn}

\description{
  
  An object of class \code{\link{linearpopn}}, usually created in a call
  to \code{\link{sim.linearpopn}} and used as input to
  \code{\link[secr]{sim.capthist}}.
  
}

\value{
  
  The object itself is a dataframe of coordinates for points
  along the mask, as for a 2-dimensional population (\link[secr]{popn}).

  The attribute model2D is always \dQuote{linear}.

  The object has class \code{c("linearpopn", "popn", "data.frame").}

}

\seealso{
  \code{\link{plot.linearpopn}}, \code{\link[secr]{popn}}.
}

\examples{

glymepop <- sim.linearpopn(glymemask, 30)
plot(glymepop, jitter=1)

CH <- sim.capthist(traps(arvicola), glymepop, detectpar = list(g0 = 0.4,
    sigma = 40), noccasions = 6, userdist = networkdistance)

plot(glymemask)
plot(CH, add = TRUE, tracks = TRUE)

}

\keyword{S3class}
